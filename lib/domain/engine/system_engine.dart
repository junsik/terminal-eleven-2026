// 시스템 엔진
//
// 시스템 관련 로직만 담당하는 순수 함수 엔진
// - 새 게임 시작
// - 게임 로드/저장

import 'package:uuid/uuid.dart';
import 'base_engine.dart';
import '../state/game_state.dart';
import '../action/game_action.dart';
import '../model/player.dart';
import '../model/models.dart' show LeagueData;
import '../engine/league_simulator.dart';

const _uuid = Uuid();

/// 시스템 엔진
class SystemEngine extends GameEngine<SystemAction> {
  @override
  bool canHandle(GameAction action) => action is SystemAction;

  @override
  GameState process(GameState state, SystemAction action, int seed) {
    return switch (action) {
      StartNewGame(
        :final playerName,
        :final archetype,
        :final teamId
      ) =>
        _startNewGame(playerName, archetype, teamId, seed),
      LoadGame() => state, // 외부에서 처리 (GameStateStore.initialize)
      SaveGame() => state, // 자동 저장으로 처리
    };
  }

  /// 새 게임 시작
  GameState _startNewGame(
    String playerName,
    String archetypeStr,
    String teamId,
    int seed,
  ) {
    // 팀 데이터 생성
    final teams = LeagueData.createDefaultTeams();
    final teamMap = {for (final t in teams) t.id: t};
    final fixtures = LeagueData.createFixtures(teams);
    final standings = LeagueData.createInitialStandings(teams);

    // 아키타입 파싱
    final archetype = PlayerArchetype.values.firstWhere(
      (a) => a.name == archetypeStr,
      orElse: () => PlayerArchetype.poacher,
    );

    // 플레이어 생성
    final pc = PlayerCharacter.create(
      id: _uuid.v4(),
      name: playerName,
      position: PlayerPosition.forward, // 기본값
      archetype: archetype,
      teamId: teamId,
    );

    // 리그 스탯 초기화 (AI 선수 생성)
    final leagueSimulator = LeagueSimulator(seed: seed);
    final leagueStats = leagueSimulator.initializeLeague(
      teams,
      pc.profile.id,
      teamId,
    );

    return GameState(
      player: PlayerState(
        character: pc,
        weeklyActionsRemaining: 3,
      ),
      season: SeasonState(
        id: _uuid.v4(),
        year: DateTime.now().year,
        currentRound: 1,
        teams: teamMap,
        fixtures: fixtures,
        standings: standings,
        leagueStats: leagueStats,
      ),
      ui: const UIScreenState(
        screen: UIScreen.home,
      ),
      meta: MetaState(
        version: 1,
        savedAt: DateTime.now(),
      ),
    );
  }
}
