/// 커리어 엔진
///
/// 선수 커리어 관련 로직만 담당하는 순수 함수 엔진
/// - XP/레벨업 처리
/// - 신뢰도 업데이트
/// - 평판 업데이트
/// - 경기 기록 저장

import 'base_engine.dart';
import '../state/game_state.dart';
import '../action/game_action.dart';
import '../model/player.dart';

/// 커리어 엔진
class CareerEngine extends GameEngine<CareerAction> {
  @override
  bool canHandle(GameAction action) => action is CareerAction;

  @override
  GameState process(GameState state, CareerAction action, int seed) {
    return switch (action) {
      AddXP(:final amount) => _addXP(state, amount),
      LevelUp() => _levelUp(state),
      UpdateTrust(:final delta) => _updateTrust(state, delta),
      UpdateReputation(:final delta) => _updateReputation(state, delta),
      RecordMatchStats(:final rating, :final goals, :final assists) =>
        _recordMatchStats(state, rating, goals, assists),
    };
  }

  /// XP 추가
  GameState _addXP(GameState state, int amount) {
    final career = state.player.career;
    var newXP = career.xp + amount;
    var newLevel = career.level;

    // 레벨업 체크 (연속 레벨업 처리)
    while (newXP >= _xpNeededForLevel(newLevel)) {
      newXP -= _xpNeededForLevel(newLevel);
      newLevel++;
    }

    return _updateCareer(state, career.copyWith(
      xp: newXP,
      level: newLevel,
    ));
  }

  /// 레벨업에 필요한 XP
  int _xpNeededForLevel(int level) => level * 100;

  /// 레벨업 (수동)
  GameState _levelUp(GameState state) {
    final career = state.player.career;
    final xpNeeded = _xpNeededForLevel(career.level);

    if (career.xp < xpNeeded) {
      return state; // XP 부족
    }

    return _updateCareer(state, career.copyWith(
      level: career.level + 1,
      xp: career.xp - xpNeeded,
    ));
  }

  /// 신뢰도 업데이트
  GameState _updateTrust(GameState state, int delta) {
    final career = state.player.career;
    final newTrust = (career.trust + delta).clamp(0, 100);

    return _updateCareer(state, career.copyWith(trust: newTrust));
  }

  /// 평판 업데이트
  GameState _updateReputation(GameState state, int delta) {
    final career = state.player.career;
    final newReputation = (career.reputation + delta).clamp(0, 100);

    return _updateCareer(state, career.copyWith(reputation: newReputation));
  }

  /// 경기 기록 저장
  GameState _recordMatchStats(
    GameState state,
    double rating,
    int goals,
    int assists,
  ) {
    final career = state.player.career;

    // 최근 평점 업데이트 (최대 10경기)
    final newRatings = [...career.lastRatings, rating];
    if (newRatings.length > 10) {
      newRatings.removeAt(0);
    }

    // XP 계산 (평점 * 10)
    final xpGain = (rating * 10).toInt();

    // 신뢰도 변화 ((평점 - 6.0) * 4)
    final trustDelta = ((rating - 6.0) * 4).toInt();

    // 새 커리어 계산
    var newCareer = career.copyWith(
      matchesPlayed: career.matchesPlayed + 1,
      totalGoals: career.totalGoals + goals,
      totalAssists: career.totalAssists + assists,
      lastRatings: newRatings,
      xp: career.xp + xpGain,
      trust: (career.trust + trustDelta).clamp(0, 100),
    );

    // 레벨업 체크
    while (newCareer.xp >= _xpNeededForLevel(newCareer.level)) {
      newCareer = newCareer.copyWith(
        level: newCareer.level + 1,
        xp: newCareer.xp - _xpNeededForLevel(newCareer.level - 1),
      );
    }

    return _updateCareer(state, newCareer);
  }

  /// 커리어 상태 업데이트 헬퍼
  GameState _updateCareer(GameState state, PlayerCareer newCareer) {
    return state.copyWith(
      player: state.player.copyWith(
        character: state.player.character.copyWith(career: newCareer),
      ),
    );
  }
}

/// 커리어 관련 유틸리티
class CareerUtils {
  /// 평점에서 XP 계산
  static int calculateXP(double rating) => (rating * 10).toInt();

  /// 평점에서 신뢰도 변화 계산
  static int calculateTrustDelta(double rating) => ((rating - 6.0) * 4).toInt();

  /// 폼 트렌드 계산 (최근 3경기 평균)
  static FormTrend calculateFormTrend(List<double> lastRatings) {
    if (lastRatings.isEmpty) return FormTrend.average;

    final recent = lastRatings.length >= 3
        ? lastRatings.sublist(lastRatings.length - 3)
        : lastRatings;
    final avg = recent.reduce((a, b) => a + b) / recent.length;

    if (avg >= 7.5) return FormTrend.excellent;
    if (avg >= 6.5) return FormTrend.good;
    if (avg >= 5.5) return FormTrend.average;
    return FormTrend.poor;
  }
}
