// Riverpod Providers

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/model/models.dart';
import 'game_controller.dart';

/// 게임 컨트롤러 Provider
final gameControllerProvider =
    StateNotifierProvider<GameController, GameSnapshot?>((ref) {
  return GameController();
});

/// 현재 게임 상태 Provider
final gameStateProvider = Provider<GameState?>((ref) {
  return ref.watch(gameControllerProvider)?.gameState;
});

/// PC Provider
final playerCharacterProvider = Provider<PlayerCharacter?>((ref) {
  return ref.watch(gameControllerProvider)?.pc;
});

/// 현재 시즌 Provider
final seasonProvider = Provider<Season?>((ref) {
  return ref.watch(gameControllerProvider)?.season;
});

/// 활성 경기 Provider
final activeMatchProvider = Provider<MatchSession?>((ref) {
  return ref.watch(gameControllerProvider)?.activeMatch;
});

/// 다음 경기 Provider
final nextFixtureProvider = Provider<Fixture?>((ref) {
  final snapshot = ref.watch(gameControllerProvider);
  return snapshot?.nextFixture;
});

/// 다음 상대 Provider
final nextOpponentProvider = Provider<Team?>((ref) {
  final snapshot = ref.watch(gameControllerProvider);
  return snapshot?.nextOpponent;
});

/// 순위표 Provider (정렬됨)
final standingsProvider = Provider<List<StandingRow>>((ref) {
  final season = ref.watch(seasonProvider);
  return season?.sortedStandings ?? [];
});

/// PC 순위 Provider
final pcRankProvider = Provider<int>((ref) {
  final snapshot = ref.watch(gameControllerProvider);
  return snapshot?.pcRank ?? 0;
});

/// 주간 남은 행동 Provider
final weeklyActionsProvider = Provider<int>((ref) {
  return ref.watch(gameControllerProvider)?.weeklyActionsRemaining ?? 0;
});

/// 현재 하이라이트 Provider
final currentHighlightProvider = Provider<HighlightEvent?>((ref) {
  return ref.watch(activeMatchProvider)?.currentHighlight;
});

/// 경기 로그 Provider
final matchLogProvider = Provider<List<LogLine>>((ref) {
  return ref.watch(activeMatchProvider)?.log ?? [];
});

/// 평점 Provider
final matchRatingProvider = Provider<double>((ref) {
  final match = ref.watch(activeMatchProvider);
  return match?.ratingAccumulator.finalRating ?? 6.0;
});
