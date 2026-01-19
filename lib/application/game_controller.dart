// 게임 컨트롤러 - 상태 전이 및 커맨드 처리

import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../domain/model/models.dart';
import '../domain/engine/engine.dart';
import '../data/storage/hive_store.dart';

/// 게임 상태 Notifier
class GameController extends StateNotifier<GameSnapshot?> {
  GameController() : super(null);

  final _uuid = const Uuid();
  late HighlightGenerator _highlightGenerator;
  late HighlightResolver _resolver;

  /// Auto-save on state changes
  Future<void> _autoSave() async {
    if (state != null) {
      await gameStorage.saveSnapshot(state!);
    }
  }

  /// 새 게임 시작
  void startNewCareer({
    required String playerName,
    required PlayerArchetype archetype,
    required String teamId,
  }) {
    final seed = DateTime.now().millisecondsSinceEpoch;
    _highlightGenerator = HighlightGenerator(seed: seed);
    _resolver = HighlightResolver(seed: seed);

    // 팀 데이터 생성
    final teams = LeagueData.createDefaultTeams();
    final teamMap = {for (final t in teams) t.id: t};
    final fixtures = LeagueData.createFixtures(teams);
    final standings = LeagueData.createInitialStandings(teams);

    // 플레이어 생성
    final pc = PlayerCharacter.create(
      id: _uuid.v4(),
      name: playerName,
      archetype: archetype,
      teamId: teamId,
    );

    // 시즌 생성
    final season = Season(
      id: _uuid.v4(),
      year: DateTime.now().year,
      teams: teamMap,
      fixtures: fixtures,
      standings: standings,
    );

    state = GameSnapshot(
      savedAt: DateTime.now(),
      gameState: GameState.home,
      pc: pc,
      season: season,
    );
    _autoSave();
  }

  /// 게임 로드
  void loadGame(GameSnapshot snapshot) {
    final seed = DateTime.now().millisecondsSinceEpoch;
    _highlightGenerator = HighlightGenerator(seed: seed);
    _resolver = HighlightResolver(seed: seed);
    state = snapshot;
  }

  /// 훈련 적용
  void applyTraining(TrainingType training) {
    if (state == null) return;
    if (!state!.canTakeAction) return;

    var pc = state!.pc;
    var stats = pc.stats;
    var status = pc.status;
    final random = Random();

    switch (training) {
      case TrainingType.shooting:
        stats = stats.copyWith(
          shooting: (stats.shooting + random.nextInt(2) + 1).clamp(0, 100),
        );
        status = status.copyWith(
          fatigue: (status.fatigue + 15).clamp(0, 100),
        );
        break;

      case TrainingType.passing:
        stats = stats.copyWith(
          passing: (stats.passing + random.nextInt(2) + 1).clamp(0, 100),
        );
        status = status.copyWith(
          fatigue: (status.fatigue + 15).clamp(0, 100),
        );
        break;

      case TrainingType.dribbling:
        stats = stats.copyWith(
          ballControl: (stats.ballControl + random.nextInt(2) + 1).clamp(0, 100),
        );
        status = status.copyWith(
          fatigue: (status.fatigue + 15).clamp(0, 100),
        );
        break;

      case TrainingType.positioning:
        stats = stats.copyWith(
          positioning: (stats.positioning + random.nextInt(2) + 1).clamp(0, 100),
        );
        status = status.copyWith(
          fatigue: (status.fatigue + 15).clamp(0, 100),
        );
        break;

      case TrainingType.stamina:
        stats = stats.copyWith(
          stamina: (stats.stamina + random.nextInt(2) + 1).clamp(0, 100),
        );
        status = status.copyWith(
          fatigue: (status.fatigue + 18).clamp(0, 100),
        );
        break;

      case TrainingType.composure:
        stats = stats.copyWith(
          composure: (stats.composure + random.nextInt(2) + 1).clamp(0, 100),
        );
        status = status.copyWith(
          fatigue: (status.fatigue + 12).clamp(0, 100),
        );
        break;

      case TrainingType.rest:
        status = status.copyWith(
          fatigue: (status.fatigue - 20).clamp(0, 100),
          confidence: (status.confidence + 1).clamp(-3, 3),
        );
        break;

      case TrainingType.rehab:
        status = status.copyWith(
          fatigue: (status.fatigue - 10).clamp(0, 100),
          injuryWeeksRemaining: (status.injuryWeeksRemaining - 1).clamp(0, 10),
        );
        if (status.injuryWeeksRemaining == 0) {
          status = status.copyWith(injury: InjuryStatus.none);
        }
        break;
    }

    // 부상 체크 (피로 높을 때 훈련하면 부상 위험)
    if (!training.isRest && status.fatigue > 70 && random.nextDouble() < 0.15) {
      status = status.copyWith(
        injury: InjuryStatus.minor,
        injuryWeeksRemaining: 1 + random.nextInt(2),
      );
    }

    pc = pc.copyWith(stats: stats, status: status);

    state = state!.copyWith(
      pc: pc,
      weeklyActionsRemaining: state!.weeklyActionsRemaining - 1,
      savedAt: DateTime.now(),
    );
  }

  /// 경기 시작
  void startMatch() {
    if (state == null) return;

    final nextFixture = state!.nextFixture;
    if (nextFixture == null) return;

    final opponent = state!.nextOpponent;
    if (opponent == null) return;

    final isHome = nextFixture.homeTeamId == state!.pc.profile.teamId;
    final seed = DateTime.now().millisecondsSinceEpoch;
    _highlightGenerator = HighlightGenerator(seed: seed);
    _resolver = HighlightResolver(seed: seed);

    // 하이라이트 생성
    final highlights = _highlightGenerator.generateHighlights(
      trust: state!.pc.career.trust,
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

    state = state!.copyWith(
      gameState: GameState.match,
      activeMatch: match,
      savedAt: DateTime.now(),
    );
  }

  /// 경기 인트로 → 첫 하이라이트
  void proceedFromIntro() {
    if (state?.activeMatch == null) return;

    final match = state!.activeMatch!;
    if (match.phase != MatchPhase.intro) return;

    state = state!.copyWith(
      activeMatch: match.copyWith(
        phase: MatchPhase.highlightPresent,
      ),
    );
  }

  /// 하이라이트 선택 처리
  void processHighlightChoice(CommandType command) {
    if (state?.activeMatch == null) return;

    var match = state!.activeMatch!;
    if (match.phase != MatchPhase.highlightPresent) return;

    final currentHighlight = match.currentHighlight;
    if (currentHighlight == null) return;

    final opponent = state!.nextOpponent;

    // 결과 계산
    final result = _resolver.resolve(
      event: currentHighlight,
      command: command,
      stats: state!.pc.stats,
      status: state!.pc.status,
      opponentRating: opponent?.defenseRating ?? 50,
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
    if (result.isGoal) {
      accumulator = accumulator.copyWith(goals: accumulator.goals + 1);
    }
    if (result.isAssist) {
      accumulator = accumulator.copyWith(assists: accumulator.assists + 1);
    }
    if (result.isYellowCard) {
      accumulator = accumulator.copyWith(yellowCards: accumulator.yellowCards + 1);
    }
    if (result.success) {
      accumulator = accumulator.copyWith(
        shotsOnTarget: accumulator.shotsOnTarget + (command == CommandType.shoot ? 1 : 0),
        keyPasses: accumulator.keyPasses + (command == CommandType.pass ? 1 : 0),
        successfulPresses: accumulator.successfulPresses + (command == CommandType.press ? 1 : 0),
      );
    } else {
      accumulator = accumulator.copyWith(
        chanceMissed: accumulator.chanceMissed + 
            (currentHighlight.type == HighlightType.oneOnOne ? 1 : 0),
        possessionLost: accumulator.possessionLost + 
            (command == CommandType.dribble ? 1 : 0),
      );
    }

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
    var status = state!.pc.status;
    status = status.copyWith(
      fatigue: (status.fatigue + result.fatigueChange).clamp(0, 100),
      confidence: (status.confidence + result.confidenceChange).clamp(-3, 3),
    );

    if (result.isInjury) {
      status = status.copyWith(
        injury: InjuryStatus.minor,
        injuryWeeksRemaining: 1 + Random().nextInt(2),
      );
      newLog.add(LogLine(
        minute: currentHighlight.minute,
        type: LogType.system,
        text: '부상을 입었다!',
      ));
    }

    match = match.copyWith(
      phase: MatchPhase.highlightResult,
      minute: currentHighlight.minute,
      score: score,
      highlights: updatedHighlights,
      ratingAccumulator: accumulator,
      log: newLog,
    );

    state = state!.copyWith(
      activeMatch: match,
      pc: state!.pc.copyWith(status: status),
    );
  }

  /// 다음 하이라이트로 진행
  void proceedToNextHighlight() {
    if (state?.activeMatch == null) return;

    var match = state!.activeMatch!;
    if (match.phase != MatchPhase.highlightResult) return;

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

    state = state!.copyWith(activeMatch: match);
  }

  /// 경기 종료 처리
  void finishMatch() {
    if (state?.activeMatch == null) return;

    var match = state!.activeMatch!;
    if (match.phase != MatchPhase.fullTime) return;

    // 평점 계산
    final finalRating = match.ratingAccumulator.finalRating;

    // 커리어 업데이트
    var career = state!.pc.career;
    final newRatings = [...career.lastRatings, finalRating];
    if (newRatings.length > 10) {
      newRatings.removeAt(0);
    }

    // XP 계산
    final xpGain = (finalRating * 10).toInt();

    // 신뢰도 변화
    final trustDelta = ((finalRating - 6.0) * 4).toInt();

    career = career.copyWith(
      matchesPlayed: career.matchesPlayed + 1,
      totalGoals: career.totalGoals + match.ratingAccumulator.goals,
      totalAssists: career.totalAssists + match.ratingAccumulator.assists,
      lastRatings: newRatings,
      xp: career.xp + xpGain,
      trust: (career.trust + trustDelta).clamp(0, 100),
    );

    // 레벨업 체크
    final xpNeeded = career.level * 100;
    if (career.xp >= xpNeeded) {
      career = career.copyWith(
        level: career.level + 1,
        xp: career.xp - xpNeeded,
      );
    }

    // 순위표 업데이트 (PC의 경기)
    final homeTeamId = match.homeTeamId;
    final awayTeamId = match.awayTeamId;
    final homeScore = match.score.home;
    final awayScore = match.score.away;

    var updatedStandings = state!.season.standings.map((row) {
      if (row.teamId == homeTeamId) {
        return row.copyWith(
          played: row.played + 1,
          won: row.won + (homeScore > awayScore ? 1 : 0),
          drawn: row.drawn + (homeScore == awayScore ? 1 : 0),
          lost: row.lost + (homeScore < awayScore ? 1 : 0),
          goalsFor: row.goalsFor + homeScore,
          goalsAgainst: row.goalsAgainst + awayScore,
        );
      } else if (row.teamId == awayTeamId) {
        return row.copyWith(
          played: row.played + 1,
          won: row.won + (awayScore > homeScore ? 1 : 0),
          drawn: row.drawn + (homeScore == awayScore ? 1 : 0),
          lost: row.lost + (awayScore < homeScore ? 1 : 0),
          goalsFor: row.goalsFor + awayScore,
          goalsAgainst: row.goalsAgainst + homeScore,
        );
      }
      return row;
    }).toList();

    // PC 경기 결과 저장
    var updatedFixtures = state!.season.fixtures.map((f) {
      if (f.id == match.fixtureId) {
        return f.copyWith(
          isPlayed: true,
          homeScore: homeScore,
          awayScore: awayScore,
        );
      }
      return f;
    }).toList();

    // 🆕 AI 팀들의 경기 시뮬레이션 (같은 라운드)
    final currentRound = state!.season.currentRound;
    final random = Random();
    final pcTeamId = state!.pc.profile.teamId;

    for (var i = 0; i < updatedFixtures.length; i++) {
      final fixture = updatedFixtures[i];
      
      // 같은 라운드 + 아직 안 한 경기 + PC팀 경기 아님
      if (fixture.round == currentRound &&
          !fixture.isPlayed &&
          fixture.homeTeamId != pcTeamId &&
          fixture.awayTeamId != pcTeamId) {
        
        // AI 경기 시뮬레이션 (간단한 랜덤)
        final aiHomeScore = random.nextInt(4); // 0-3 골
        final aiAwayScore = random.nextInt(4);

        // 경기 결과 업데이트
        updatedFixtures[i] = fixture.copyWith(
          isPlayed: true,
          homeScore: aiHomeScore,
          awayScore: aiAwayScore,
        );

        // 순위표 업데이트
        updatedStandings = updatedStandings.map((row) {
          if (row.teamId == fixture.homeTeamId) {
            return row.copyWith(
              played: row.played + 1,
              won: row.won + (aiHomeScore > aiAwayScore ? 1 : 0),
              drawn: row.drawn + (aiHomeScore == aiAwayScore ? 1 : 0),
              lost: row.lost + (aiHomeScore < aiAwayScore ? 1 : 0),
              goalsFor: row.goalsFor + aiHomeScore,
              goalsAgainst: row.goalsAgainst + aiAwayScore,
            );
          } else if (row.teamId == fixture.awayTeamId) {
            return row.copyWith(
              played: row.played + 1,
              won: row.won + (aiAwayScore > aiHomeScore ? 1 : 0),
              drawn: row.drawn + (aiHomeScore == aiAwayScore ? 1 : 0),
              lost: row.lost + (aiAwayScore < aiHomeScore ? 1 : 0),
              goalsFor: row.goalsFor + aiAwayScore,
              goalsAgainst: row.goalsAgainst + aiHomeScore,
            );
          }
          return row;
        }).toList();
      }
    }

    // 다음 라운드로
    final nextRound = state!.season.currentRound + 1;

    state = state!.copyWith(
      gameState: GameState.postMatch,
      activeMatch: match.copyWith(phase: MatchPhase.summary),
      pc: state!.pc.copyWith(career: career),
      season: state!.season.copyWith(
        standings: updatedStandings,
        fixtures: updatedFixtures,
        currentRound: nextRound,
      ),
      weeklyActionsRemaining: 3, // 주간 행동 리셋
      savedAt: DateTime.now(),
    );
  }

  /// 홈으로 돌아가기
  void returnToHome() {
    if (state == null) return;

    state = state!.copyWith(
      gameState: GameState.home,
      activeMatch: null,
      savedAt: DateTime.now(),
    );
  }

  /// 훈련 화면으로
  void goToTraining() {
    if (state == null) return;

    state = state!.copyWith(
      gameState: GameState.training,
      savedAt: DateTime.now(),
    );
  }
}
