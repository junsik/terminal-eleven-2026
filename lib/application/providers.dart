// Riverpod Providers
//
// 새 엔진 아키텍처 전용 Provider
// - Single Source of Truth: GameStateStore
// - 액션 기반 상태 변경: GameOrchestrator

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/model/models.dart';
import '../domain/state/game_state.dart' as engine;
import 'orchestrator.dart';

// ============================================================================
// Core Providers (Single Source of Truth)
// ============================================================================

/// 게임 상태 저장소 Provider (Single Source of Truth)
final gameStateStoreProvider = ChangeNotifierProvider<GameStateStore>((ref) {
  return GameStateStore();
});

/// 게임 오케스트레이터 Provider
final orchestratorProvider = Provider<GameOrchestrator>((ref) {
  final store = ref.watch(gameStateStoreProvider);
  return GameOrchestrator(store: store);
});

// ============================================================================
// State Providers (읽기 전용)
// ============================================================================

/// 전체 게임 상태 Provider
final engineStateProvider = Provider<engine.GameState?>((ref) {
  return ref.watch(gameStateStoreProvider).state;
});

/// 플레이어 상태 Provider
final enginePlayerProvider = Provider<engine.PlayerState?>((ref) {
  return ref.watch(engineStateProvider)?.player;
});

/// 시즌 상태 Provider
final engineSeasonProvider = Provider<engine.SeasonState?>((ref) {
  return ref.watch(engineStateProvider)?.season;
});

/// UI 상태 Provider
final engineUIProvider = Provider<engine.UIScreenState?>((ref) {
  return ref.watch(engineStateProvider)?.ui;
});

// ============================================================================
// Computed Providers (파생 데이터)
// ============================================================================

/// PC 캐릭터 Provider
final engineCharacterProvider = Provider<PlayerCharacter?>((ref) {
  return ref.watch(enginePlayerProvider)?.character;
});

/// 순위표 Provider (정렬됨)
final engineStandingsProvider = Provider<List<StandingRow>>((ref) {
  final season = ref.watch(engineSeasonProvider);
  return season?.sortedStandings ?? [];
});

/// PC 순위 Provider
final enginePcRankProvider = Provider<int>((ref) {
  final season = ref.watch(engineSeasonProvider);
  final player = ref.watch(enginePlayerProvider);
  if (season == null || player == null) return 0;
  return season.getRank(player.teamId);
});

/// 다음 경기 Provider
final engineNextFixtureProvider = Provider<Fixture?>((ref) {
  final season = ref.watch(engineSeasonProvider);
  final player = ref.watch(enginePlayerProvider);
  if (season == null || player == null) return null;
  return season.getNextFixture(player.teamId);
});

/// 다음 상대 Provider
final engineNextOpponentProvider = Provider<Team?>((ref) {
  final season = ref.watch(engineSeasonProvider);
  final player = ref.watch(enginePlayerProvider);
  final fixture = ref.watch(engineNextFixtureProvider);
  if (season == null || player == null || fixture == null) return null;

  final opponentId = fixture.homeTeamId == player.teamId
      ? fixture.awayTeamId
      : fixture.homeTeamId;
  return season.getTeam(opponentId);
});

/// 활성 경기 Provider
final engineActiveMatchProvider = Provider<MatchSession?>((ref) {
  return ref.watch(engineUIProvider)?.activeMatch;
});

/// 현재 하이라이트 Provider
final engineCurrentHighlightProvider = Provider<HighlightEvent?>((ref) {
  return ref.watch(engineActiveMatchProvider)?.currentHighlight;
});

/// 경기 로그 Provider
final engineMatchLogProvider = Provider<List<LogLine>>((ref) {
  return ref.watch(engineActiveMatchProvider)?.log ?? [];
});

/// 경기 평점 Provider
final engineMatchRatingProvider = Provider<double>((ref) {
  final match = ref.watch(engineActiveMatchProvider);
  return match?.ratingAccumulator.finalRating ?? 6.0;
});

/// 주간 남은 행동 Provider
final engineWeeklyActionsProvider = Provider<int>((ref) {
  return ref.watch(enginePlayerProvider)?.weeklyActionsRemaining ?? 0;
});

/// 현재 화면 Provider
final engineCurrentScreenProvider = Provider<engine.UIScreen>((ref) {
  return ref.watch(engineUIProvider)?.screen ?? engine.UIScreen.boot;
});

/// 리그 스탯 Provider
final engineLeagueStatsProvider = Provider<LeagueStats?>((ref) {
  return ref.watch(engineSeasonProvider)?.leagueStats;
});
