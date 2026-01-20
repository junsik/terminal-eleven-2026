// 게임 오케스트레이터
//
// 엔진들을 조합하고 상태를 관리하는 중앙 제어 클래스
// - 액션 디스패치
// - 엔진 라우팅
// - 복합 액션 처리

import 'dart:math';
import 'package:flutter/foundation.dart';
import '../domain/state/game_state.dart';
import '../domain/action/game_action.dart';
import '../domain/engine/base_engine.dart';
import '../domain/engine/training_engine.dart';
import '../domain/engine/league_engine_v2.dart';
import '../domain/engine/career_engine.dart';
import '../domain/engine/ui_engine.dart';
import '../domain/engine/match_engine.dart';
import '../domain/engine/system_engine.dart';
import '../domain/engine/inbox_engine.dart';
import '../domain/engine/inbox_message_factory.dart';
import '../data/storage/hive_store.dart';
import '../domain/model/game_snapshot.dart' show TrainingType, TrainingIntensity;
import '../domain/model/match.dart'; // RatingAccumulatorX extension
import '../domain/model/command.dart'; // CommandType
import '../domain/model/player.dart'; // PlayerCharacter, PlayerPosition, PlayerArchetype

// 기존 TrainingType import를 위한 re-export
export '../domain/model/game_snapshot.dart' show TrainingType;

/// 게임 상태 저장소 (Single Source of Truth)
class GameStateStore extends ChangeNotifier {
  GameState? _state;

  GameState? get state => _state;

  /// 상태 업데이트 (유일한 변경 지점)
  void update(GameState newState) {
    if (_state == newState) return; // 변경 없으면 무시

    _state = newState;
    notifyListeners();

    // 자동 저장
    _autoSave(newState);
  }

  /// 초기 상태 설정
  void initialize(GameState initialState) {
    _state = initialState;
    notifyListeners();
  }

  /// 상태 초기화 (로그아웃 등)
  void clear() {
    _state = null;
    notifyListeners();
  }

  /// 자동 저장
  Future<void> _autoSave(GameState state) async {
    try {
      final snapshot = state.toSnapshot();
      await gameStorage.saveSnapshot(snapshot);
    } catch (e) {
      debugPrint('Auto-save failed: $e');
    }
  }
}

/// 게임 오케스트레이터
///
/// 액션을 받아서 적절한 엔진에 라우팅하고
/// 결과 상태를 Store에 업데이트
class GameOrchestrator {
  final GameStateStore _store;
  final List<GameEngine> _engines;
  final Random _random;

  GameOrchestrator({
    required GameStateStore store,
    int? seed,
  })  : _store = store,
        _random = Random(seed ?? DateTime.now().millisecondsSinceEpoch),
        _engines = [
          TrainingEngine(),
          LeagueEngineV2(),
          CareerEngine(),
          UIEngine(),
          MatchEngine(),
          SystemEngine(),
          InboxEngine(),
        ];

  /// 현재 상태 (읽기 전용)
  GameState? get state => _store.state;

  /// 액션 디스패치
  void dispatch(GameAction action) {
    final currentState = _store.state;
    if (currentState == null) {
      debugPrint('Cannot dispatch action: state is null');
      return;
    }

    final seed = _random.nextInt(1 << 31);

    // 적절한 엔진 찾기
    final engine = _engines.firstWhere(
      (e) => e.canHandle(action),
      orElse: () => throw UnhandledActionException(action),
    );

    // 새 상태 계산 (순수 함수)
    final newState = engine.process(currentState, action, seed);

    // 상태 업데이트
    _store.update(newState);
  }

  /// 여러 액션 순차 디스패치
  void dispatchAll(List<GameAction> actions) {
    for (final action in actions) {
      dispatch(action);
    }
  }

  /// 훈련 실행 (편의 메서드)
  void executeTraining(
    TrainingType type, {
    TrainingIntensity intensity = TrainingIntensity.normal,
  }) {
    dispatch(ExecuteTraining(type, intensity: intensity));
  }

  /// 경기 종료 처리 (복합 액션)
  ///
  /// 여러 엔진이 순차적으로 처리해야 하는 복합 작업
  void finishMatch() {
    final currentState = state;
    if (currentState == null) return;

    final match = currentState.ui.activeMatch;
    if (match == null) return;

    final pcTeamId = currentState.player.teamId;
    final isHome = match.homeTeamId == pcTeamId;
    final isWin = isHome
        ? match.score.home > match.score.away
        : match.score.away > match.score.home;
    final isDraw = match.score.home == match.score.away;

    // 상대팀 이름 가져오기
    final opponentId = isHome ? match.awayTeamId : match.homeTeamId;
    final opponentName =
        currentState.season.teams[opponentId]?.name ?? '상대팀';

    // 경기 전 커리어 정보 저장 (마일스톤 체크용)
    final oldCareer = currentState.player.career;
    final oldForm = currentState.player.status.form;
    final oldTrust = currentState.player.career.trust;

    // 1. 커리어 업데이트 (평점, 골, 어시스트)
    dispatch(RecordMatchStats(
      rating: match.ratingAccumulator.finalRating,
      goals: match.ratingAccumulator.goals,
      assists: match.ratingAccumulator.assists,
    ));

    // 1.5 픽스처 결과 강제 업데이트 (버그 수정용)
    dispatch(UpdateFixture(
      fixtureId: match.fixtureId,
      homeScore: match.score.home,
      awayScore: match.score.away,
    ));

    // 2. 순위표 업데이트
    dispatch(UpdateStandings(MatchResultData(
      homeTeamId: match.homeTeamId,
      awayTeamId: match.awayTeamId,
      homeScore: match.score.home,
      awayScore: match.score.away,
    )));

    // 3. AI 경기 시뮬레이션
    dispatch(SimulateAIMatches(currentState.season.currentRound));

    // 4. 라운드 진행
    dispatch(const AdvanceRound());

    // 5. 주간 액션 리셋
    dispatch(const ResetWeeklyActions());

    // 6. 경기 결과 메시지
    dispatch(InboxMessageFactory.matchResult(
      isWin: isWin,
      isDraw: isDraw,
      homeScore: match.score.home,
      awayScore: match.score.away,
      rating: match.ratingAccumulator.finalRating,
      goals: match.ratingAccumulator.goals,
      assists: match.ratingAccumulator.assists,
      opponentName: opponentName,
      isHome: isHome,
    ));

    // 7. 마일스톤 메시지 (첫 골, 10골 등)
    final newState = _store.state;
    if (newState != null) {
      final newCareer = newState.player.career;
      final milestoneMsg = InboxMessageFactory.milestone(
        totalGoals: newCareer.totalGoals,
        totalAssists: newCareer.totalAssists,
        matchesPlayed: newCareer.matchesPlayed,
      );
      if (milestoneMsg != null &&
          (oldCareer.totalGoals != newCareer.totalGoals ||
              oldCareer.matchesPlayed != newCareer.matchesPlayed)) {
        dispatch(milestoneMsg);
      }

      // 8. 폼 변화 메시지
      final formMsg = InboxMessageFactory.formChange(
        oldForm,
        newState.player.status.form,
      );
      if (formMsg != null) {
        dispatch(formMsg);
      }

      // 9. 신뢰도 변화 메시지
      final trustMsg = InboxMessageFactory.trustChange(
        oldTrust,
        newState.player.career.trust,
      );
      if (trustMsg != null) {
        dispatch(trustMsg);
      }
    }

    // 10. 홈 화면으로
    dispatch(const GoToHome());
  }

  /// 경기 관전 (부상 시) - 복합 액션
  ///
  /// SpectateMatch 액션 후 리그/라운드 업데이트
  void spectateMatchComplete() {
    final currentState = state;
    if (currentState == null) return;

    // 1. 경기 관전 (MatchEngine에서 처리)
    dispatch(const SpectateMatch());

    // 2. PC 팀 순위표 업데이트
    final match = _store.state?.ui.activeMatch;
    if (match != null) {
      dispatch(UpdateStandings(MatchResultData(
        homeTeamId: match.homeTeamId,
        awayTeamId: match.awayTeamId,
        homeScore: match.score.home,
        awayScore: match.score.away,
      )));
    }

    // 3. AI 경기 시뮬레이션
    dispatch(SimulateAIMatches(currentState.season.currentRound));

    // 4. 라운드 진행
    dispatch(const AdvanceRound());

    // 5. 주간 액션 리셋
    dispatch(const ResetWeeklyActions());
  }

  // ===========================================================================
  // 편의 메서드 (UI에서 직접 호출)
  // ===========================================================================

  /// 경기 시작 (UI 호출용)
  void startMatch() {
    dispatch(const StartMatch());
  }

  /// 경기 인트로 → 첫 하이라이트
  void proceedFromIntro() {
    dispatch(const ProceedFromIntro());
  }

  /// 하이라이트 선택 처리
  void processHighlightChoice(CommandType command) {
    dispatch(ProcessHighlightChoice(command));
  }

  /// 전술 외침 실행
  void executeTacticalShout(CommandType shoutType) {
    dispatch(ExecuteTacticalShout(shoutType));
  }

  /// 다음 하이라이트로 진행
  void proceedToNextHighlight() {
    dispatch(const ProceedToNextHighlight());
  }

  /// 경기 종료 UI로 이동
  void goToPostMatch() {
    dispatch(const FinishMatch());
  }

  /// 홈 화면으로
  void returnToHome() {
    dispatch(const GoToHome());
  }

  /// 훈련 화면으로
  void goToTraining() {
    dispatch(const GoToTraining());
  }

  /// 경기 전 화면으로
  void goToPreMatch() {
    dispatch(const GoToPreMatch());
  }

  /// 새 게임 시작 (state가 null이어도 동작)
  void startNewCareer({
    required String playerName,
    required String archetype,
    required String teamId,
  }) {
    final seed = _random.nextInt(1 << 31);
    final systemEngine = SystemEngine();
    final action = StartNewGame(
      playerName: playerName,
      archetype: archetype,
      teamId: teamId,
    );

    // 빈 상태에서 시작 (SystemEngine이 새 상태를 생성)
    final dummyState = GameState(
      player: PlayerState(
        character: PlayerCharacter.create(
          id: '',
          name: '',
          position: PlayerPosition.forward,
          archetype: PlayerArchetype.poacher,
          teamId: '',
        ),
      ),
      season: SeasonState(
        id: '',
        year: 0,
        teams: {},
        fixtures: [],
        standings: [],
      ),
      ui: const UIScreenState(),
      meta: MetaState(savedAt: DateTime.now()),
    );

    final newState = systemEngine.process(dummyState, action, seed);
    _store.initialize(newState);

    // 환영 메시지 추가
    final teamName = newState.season.teams[teamId]?.name ?? teamId;
    dispatch(InboxMessageFactory.welcome(playerName, teamName));
  }

  /// 인박스 메시지 읽음 처리
  void markMessageAsRead(String messageId) {
    dispatch(MarkMessageAsRead(messageId));
  }

  /// 모든 메시지 읽음 처리
  void markAllMessagesAsRead() {
    dispatch(const MarkAllMessagesAsRead());
  }

  /// 메시지 삭제
  void deleteMessage(String messageId) {
    dispatch(DeleteInboxMessage(messageId));
  }
}
