// 경기 엔진
//
// 경기 진행 로직만 담당하는 순수 함수 엔진
// - 경기 시작/생성
// - 하이라이트 선택 처리
// - 평점 누적
// - 경기 종료 처리
//
// 🔑 핵심: 순수 함수로 경기 상태만 변경, 리그/커리어는 다른 엔진이 처리

import '../config/balance_config.dart';
import 'dart:math';
import 'package:uuid/uuid.dart';
import 'base_engine.dart';
import '../state/game_state.dart';
import '../action/game_action.dart';
import '../model/match.dart';
import '../model/player.dart';
import '../model/command.dart';
import '../engine/engine.dart' show HighlightGenerator, HighlightResolver;

const _uuid = Uuid();

/// 경기 엔진
class MatchEngine extends GameEngine<MatchAction> {
  @override
  bool canHandle(GameAction action) => action is MatchAction;

  @override
  GameState process(GameState state, MatchAction action, int seed) {
    return switch (action) {
      StartMatch() => _startMatch(state, seed),
      ProceedFromIntro() => _proceedFromIntro(state),
      ProcessHighlightChoice(:final command) =>
        _processHighlightChoice(state, command, seed),
      ProceedToNextHighlight() => _proceedToNextHighlight(state),
      FinishMatch() => _finishMatch(state),
      SpectateMatch() => _spectateMatch(state, seed),
      ExecuteTacticalShout(:final shoutType) => _executeTacticalShout(state, shoutType),
    };
  }

  /// 전술 외침 실행 Wrapper
  GameState _executeTacticalShout(GameState state, CommandType shoutType) {
    var match = state.ui.activeMatch;
    if (match == null) return state;

    match = processTacticalShout(match, shoutType);

    return state.copyWith(
      ui: state.ui.copyWith(activeMatch: match),
    );
  }

  /// 경기 시작
  ///
  /// 하이라이트 생성 및 MatchSession 초기화
  GameState _startMatch(GameState state, int seed) {
    // 부상 체크
    if (state.player.status.injury != InjuryStatus.none) {
      return state; // 부상 시 경기 불가
    }

    final nextFixture = state.season.getNextFixture(state.player.teamId);
    if (nextFixture == null) return state;

    final opponent = state.season.getTeam(
      nextFixture.homeTeamId == state.player.teamId
          ? nextFixture.awayTeamId
          : nextFixture.homeTeamId,
    );
    if (opponent == null) return state;

    final isHome = nextFixture.homeTeamId == state.player.teamId;
    final highlightGenerator = HighlightGenerator(seed: seed);

    // 하이라이트 생성
    final highlights = highlightGenerator.generateHighlights(
      trust: state.player.career.trust,
      opponentDefenseRating: opponent.defenseRating,
      initialContext: ScoreContext.draw,
    );

    final match = MatchSession(
      id: _uuid.v4(),
      fixtureId: nextFixture.id,
      homeTeamId: nextFixture.homeTeamId,
      awayTeamId: nextFixture.awayTeamId,
      isHome: isHome,
      highlights: highlights,
      rngSeed: seed,
      phase: MatchPhase.intro,
      log: [
        LogLine(
          type: LogType.system,
          text: '경기가 시작됩니다!',
        ),
      ],
    );

    return state.copyWith(
      ui: state.ui.copyWith(
        screen: UIScreen.match,
        activeMatch: match,
      ),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }

  /// 경기 인트로 → 첫 하이라이트
  GameState _proceedFromIntro(GameState state) {
    final match = state.ui.activeMatch;
    if (match == null || match.phase != MatchPhase.intro) return state;

    return state.copyWith(
      ui: state.ui.copyWith(
        activeMatch: match.copyWith(
          phase: MatchPhase.highlightPresent,
        ),
      ),
    );
  }

  /// 하이라이트 선택 처리
  ///
  /// 가장 복잡한 로직: 선택 → 결과 계산 → 평점/스코어 업데이트
  GameState _processHighlightChoice(
    GameState state,
    CommandType command,
    int seed,
  ) {
    var match = state.ui.activeMatch;
    if (match == null || match.phase != MatchPhase.highlightPresent) {
      return state;
    }

    final currentHighlight = match.currentHighlight;
    if (currentHighlight == null) return state;

    // 상대팀 정보
    final opponentId = match.isHome ? match.awayTeamId : match.homeTeamId;
    final opponent = state.season.getTeam(opponentId);

    // 결과 계산 (HighlightResolver 사용)
    final resolver = HighlightResolver(seed: seed);
    final result = resolver.resolve(
      event: currentHighlight,
      command: command,
      stats: state.player.stats,
      status: state.player.status,
      opponentRating: opponent?.defenseRating ?? 50,
      momentum: match.momentum,
      consecutiveSuccess: match.consecutiveSuccess,
      consecutiveFailure: match.consecutiveFailure,
      isClutchTime: match.isClutchTime,
    );

    // 스코어 업데이트
    var score = match.score;
    if (result.isGoal) {
      if (match.isHome) {
        score = score.copyWith(home: score.home + 1);
      } else {
        score = score.copyWith(away: score.away + 1);
      }
    }

    // 평점 누적 업데이트
    var accumulator = match.ratingAccumulator;
    accumulator = _updateAccumulator(
      accumulator,
      result,
      command,
      currentHighlight.type,
    );

    // 하이라이트 결과 저장
    final updatedHighlight = currentHighlight.copyWith(
      selectedChoice: command.name,
      result: result,
    );

    final updatedHighlights = [...match.highlights];
    updatedHighlights[match.currentHighlightIndex] = updatedHighlight;

    // 로그 추가
    final newLog = [
      ...match.log,
      LogLine(
        minute: currentHighlight.minute,
        type: LogType.commentary,
        text: result.description,
      ),
    ];

    // PC 상태 업데이트
    var status = state.player.status;
    status = status.copyWith(
      fatigue: (status.fatigue + result.fatigueChange).clamp(0, 100),
      confidence: (status.confidence + result.confidenceChange).clamp(-3, 3),
    );

    // 부상 처리
    if (result.isInjury) {
      final random = Random(seed);
      status = status.copyWith(
        injury: InjuryStatus.minor,
        injuryWeeksRemaining: 1 + random.nextInt(2),
      );
      newLog.add(LogLine(
        minute: currentHighlight.minute,
        type: LogType.system,
        text: '부상을 입었다!',
      ));
    }

    // 모멘텀 및 연속 성공/실패 업데이트
    // 성공 시: 연속 성공 +1, 연속 실패 절반으로 감소 (완만한 회복)
    // 실패 시: 연속 실패 +1, 연속 성공 절반으로 감소 (완만한 하락)
    final int newConsecutiveSuccess;
    final int newConsecutiveFailure;

    if (result.success) {
      newConsecutiveSuccess = match.consecutiveSuccess + 1;
      newConsecutiveFailure = (match.consecutiveFailure / 2).floor();
    } else {
      newConsecutiveSuccess = (match.consecutiveSuccess / 2).floor();
      newConsecutiveFailure = match.consecutiveFailure + 1;
    }

    final newMomentum = (match.momentum + result.momentumChange)
        .clamp(MomentumConfig.minMomentum, MomentumConfig.maxMomentum);

    match = match.copyWith(
      phase: MatchPhase.highlightResult,
      minute: currentHighlight.minute,
      score: score,
      highlights: updatedHighlights,
      ratingAccumulator: accumulator,
      momentum: newMomentum,
      consecutiveSuccess: newConsecutiveSuccess,
      consecutiveFailure: newConsecutiveFailure,
      log: newLog,
    );

    return state.copyWith(
      player: state.player.copyWith(
        character: state.player.character.copyWith(
          status: status,
        ),
      ),
      ui: state.ui.copyWith(activeMatch: match),
    );
  }

  /// 평점 누적 업데이트 (순수 함수)
  RatingAccumulator _updateAccumulator(
    RatingAccumulator accumulator,
    HighlightResult result,
    CommandType command,
    HighlightType highlightType,
  ) {
    var updated = accumulator;

    if (result.isGoal) {
      updated = updated.copyWith(goals: updated.goals + 1);
    }
    if (result.isAssist) {
      updated = updated.copyWith(assists: updated.assists + 1);
    }
    if (result.isYellowCard) {
      updated = updated.copyWith(yellowCards: updated.yellowCards + 1);
    }

    if (result.success) {
      updated = updated.copyWith(
        shotsOnTarget:
            updated.shotsOnTarget + (command == CommandType.shoot ? 1 : 0),
        keyPasses: updated.keyPasses + (command == CommandType.pass ? 1 : 0),
        successfulPresses:
            updated.successfulPresses + (command == CommandType.press ? 1 : 0),
      );
    } else {
      updated = updated.copyWith(
        chanceMissed:
            updated.chanceMissed + (highlightType == HighlightType.oneOnOne ? 1 : 0),
        possessionLost:
            updated.possessionLost + (command == CommandType.dribble ? 1 : 0),
      );
    }

    return updated;
  }

  /// 다음 하이라이트로 진행 / 경기 종료
  GameState _proceedToNextHighlight(GameState state) {
    var match = state.ui.activeMatch;
    if (match == null || match.phase != MatchPhase.highlightResult) {
      return state;
    }

    final nextIndex = match.currentHighlightIndex + 1;

    if (nextIndex >= match.highlights.length) {
      // 경기 종료
      match = match.copyWith(
        phase: MatchPhase.fullTime,
        currentHighlightIndex: nextIndex,
        log: [
          ...match.log,
          LogLine(
            minute: 90,
            type: LogType.system,
            text: '경기 종료! 최종 스코어: ${match.score.home} - ${match.score.away}',
          ),
        ],
      );
    } else {
      match = match.copyWith(
        phase: MatchPhase.highlightPresent,
        currentHighlightIndex: nextIndex,
      );
    }

    return state.copyWith(
      ui: state.ui.copyWith(activeMatch: match),
    );
  }

  /// 경기 완전 종료 (summary 페이즈로 전환)
  ///
  /// 🔑 MatchEngine은 경기 상태만 처리
  /// 커리어/리그 업데이트는 GameOrchestrator.finishMatch()에서 처리
  GameState _finishMatch(GameState state) {
    var match = state.ui.activeMatch;
    if (match == null || match.phase != MatchPhase.fullTime) {
      return state;
    }

    // PC 경기 픽스처 업데이트
    final fixtureId = match.fixtureId;
    final homeScore = match.score.home;
    final awayScore = match.score.away;

    final updatedFixtures = state.season.fixtures.map((f) {
      if (f.id == fixtureId) {
        return f.copyWith(
          isPlayed: true,
          homeScore: homeScore,
          awayScore: awayScore,
        );
      }
      return f;
    }).toList();

    return state.copyWith(
      ui: state.ui.copyWith(
        screen: UIScreen.postMatch,
        activeMatch: match.copyWith(phase: MatchPhase.summary),
      ),
      season: state.season.copyWith(fixtures: updatedFixtures),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }

  /// 경기 관전 (부상 시)
  ///
  /// PC 없이 팀 경기만 시뮬레이션
  GameState _spectateMatch(GameState state, int seed) {
    final nextFixture = state.season.getNextFixture(state.player.teamId);
    if (nextFixture == null) return state;

    final random = Random(seed);
    final pcTeamId = state.player.teamId;
    final isHome = nextFixture.homeTeamId == pcTeamId;

    // 팀 경기 시뮬레이션
    final homeTeam = state.season.getTeam(nextFixture.homeTeamId);
    final awayTeam = state.season.getTeam(nextFixture.awayTeamId);

    final homeScore = _simulateTeamGoals(homeTeam, awayTeam, true, random);
    final awayScore = _simulateTeamGoals(awayTeam, homeTeam, false, random);

    // 픽스처 업데이트
    final updatedFixtures = state.season.fixtures.map((f) {
      if (f.id == nextFixture.id) {
        return f.copyWith(
          isPlayed: true,
          homeScore: homeScore,
          awayScore: awayScore,
        );
      }
      return f;
    }).toList();

    // 부상 회복 (1주 감소)
    var status = state.player.status;
    if (status.injuryWeeksRemaining > 0) {
      final newWeeks = status.injuryWeeksRemaining - 1;
      status = status.copyWith(
        injuryWeeksRemaining: newWeeks,
        injury: newWeeks <= 0 ? InjuryStatus.none : status.injury,
      );
    }

    // 결과 텍스트
    final teamResult = isHome
        ? (homeScore > awayScore
            ? '승'
            : homeScore < awayScore
                ? '패'
                : '무')
        : (awayScore > homeScore
            ? '승'
            : awayScore < homeScore
                ? '패'
                : '무');

    // 관전 결과 MatchSession
    final spectateMatch = MatchSession(
      id: _uuid.v4(),
      fixtureId: nextFixture.id,
      homeTeamId: nextFixture.homeTeamId,
      awayTeamId: nextFixture.awayTeamId,
      isHome: isHome,
      phase: MatchPhase.summary,
      score: Score(home: homeScore, away: awayScore),
      highlights: [],
      rngSeed: 0,
      log: [
        LogLine(
          type: LogType.system,
          text: '부상으로 인해 벤치에서 경기를 관전했습니다.',
        ),
        LogLine(
          type: LogType.result,
          text:
              '경기 결과: ${isHome ? homeScore : awayScore} - ${isHome ? awayScore : homeScore} ($teamResult)',
        ),
      ],
    );

    return state.copyWith(
      player: state.player.copyWith(
        character: state.player.character.copyWith(
          status: status,
        ),
      ),
      ui: state.ui.copyWith(
        screen: UIScreen.postMatch,
        activeMatch: spectateMatch,
      ),
      season: state.season.copyWith(fixtures: updatedFixtures),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }

  /// 팀 골 시뮬레이션 (간단한 버전)
  int _simulateTeamGoals(
    dynamic team,
    dynamic opponent,
    bool isHome,
    Random random,
  ) {
    if (team == null || opponent == null) {
      return random.nextInt(4);
    }

    double expectedGoals = team.attackRating / SimulationConfig.attackDivisor;
    expectedGoals *= (100 - opponent.defenseRating) / SimulationConfig.defenseDivisor;
    if (isHome) expectedGoals *= SimulationConfig.homeAdvantage;
    expectedGoals *= SimulationConfig.randomBase + random.nextDouble() * SimulationConfig.randomVariance;

    return expectedGoals.round().clamp(0, SimulationConfig.maxGoals);
  }

  /// 전술 외침 처리
  ///
  /// 같은 하이라이트에서 중복 외침 방지 (쿨타임)
  MatchSession processTacticalShout(MatchSession match, CommandType shout) {
    // 쿨타임 체크: 같은 하이라이트에서 이미 외침을 사용했으면 무시
    if (match.lastShoutIndex == match.currentHighlightIndex) {
      return match; // 이미 이 하이라이트에서 외침을 사용함
    }

    var newMomentum = match.momentum;
    var logText = '';

    switch (shout) {
      case CommandType.shoutEncourage:
        newMomentum += ShoutConfig.encourageMomentumGain;
        logText = '🗣️ "할 수 있어!" 동료들을 격려합니다. (분위기 상승)';
        break;
      case CommandType.shoutDemand:
        newMomentum += ShoutConfig.demandMomentumGain;
        logText = '🗣️ "정신 차려!" 강력하게 지시합니다. (분위기 급상승)';
        // TODO: Confidence cost implementation if needed in MatchSession
        break;
      case CommandType.shoutCalm:
        if (newMomentum < 0) {
          newMomentum += ShoutConfig.calmMomentumRestoration;
          logText = '🗣️ "침착해!" 흥분한 동료들을 진정시킵니다. (분위기 회복)';
        } else {
          logText = '🗣️ "천천히 하자." 템포를 조절합니다.';
        }
        break;
      default:
        return match;
    }

    // Clamp
    newMomentum = newMomentum.clamp(MomentumConfig.minMomentum, MomentumConfig.maxMomentum);

    // Log addition
    final newLog = List<LogLine>.from(match.log)
      ..add(LogLine(
        type: LogType.system,
        text: logText,
        minute: match.minute,
      ));

    return match.copyWith(
      momentum: newMomentum,
      log: newLog,
      lastShoutIndex: match.currentHighlightIndex,
    );
  }
}
