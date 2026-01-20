/// 훈련 엔진
///
/// 훈련 관련 로직만 담당하는 순수 함수 엔진
/// - 스탯 변경 계산
/// - 피로도 계산
/// - 부상 체크

import 'dart:math';
import 'base_engine.dart';
import '../config/balance_config.dart';
import '../state/game_state.dart';
import '../action/game_action.dart';
import '../model/player.dart';
import '../model/game_snapshot.dart' show TrainingType;

/// 훈련 엔진
class TrainingEngine extends GameEngine<TrainingAction> {
  @override
  bool canHandle(GameAction action) => action is TrainingAction;

  @override
  GameState process(GameState state, TrainingAction action, int seed) {
    return switch (action) {
      ExecuteTraining(:final type) => _executeTraining(state, type, seed),
    };
  }

  /// 훈련 실행
  GameState _executeTraining(GameState state, TrainingType type, int seed) {
    final random = Random(seed);
    final player = state.player;
    final character = player.character;

    // 행동 가능 여부 체크
    if (!player.canTakeAction) {
      return state; // 변경 없이 반환
    }

    // 훈련 효과 계산
    final result = _calculateTrainingEffect(
      type: type,
      currentStats: character.stats,
      currentStatus: character.status,
      random: random,
    );

    // 부상 체크
    final injuryResult = _checkInjury(
      type: type,
      fatigue: result.newStatus.fatigue,
      random: random,
    );

    // 최종 상태 적용
    final finalStatus = injuryResult.hasInjury
        ? result.newStatus.copyWith(
            injury: injuryResult.injury!,
            injuryWeeksRemaining: injuryResult.weeks!,
          )
        : result.newStatus;

    // 새 상태 반환
    return state.copyWith(
      player: player.copyWith(
        character: character.copyWith(
          stats: result.newStats,
          status: finalStatus,
        ),
        weeklyActionsRemaining: player.weeklyActionsRemaining - 1,
      ),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }

  /// 훈련 효과 계산 (순수 함수)
  TrainingResult _calculateTrainingEffect({
    required TrainingType type,
    required PlayerStats currentStats,
    required PlayerStatus currentStatus,
    required Random random,
  }) {
    var newStats = currentStats;
    var newStatus = currentStatus;

    // 스탯 증가량 (Config 기반)
    final statGainRange = TrainingConfig.statGainMax - TrainingConfig.statGainMin + 1;
    final statGain = TrainingConfig.statGainMin + random.nextInt(statGainRange);

    switch (type) {
      case TrainingType.shooting:
        newStats = newStats.copyWith(
          shooting: (newStats.shooting + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue + TrainingConfig.fatigueDefault).clamp(0, 100),
        );

      case TrainingType.passing:
        newStats = newStats.copyWith(
          passing: (newStats.passing + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue + TrainingConfig.fatigueDefault).clamp(0, 100),
        );

      case TrainingType.dribbling:
        newStats = newStats.copyWith(
          ballControl: (newStats.ballControl + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue + TrainingConfig.fatigueDefault).clamp(0, 100),
        );

      case TrainingType.positioning:
        newStats = newStats.copyWith(
          positioning: (newStats.positioning + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue + TrainingConfig.fatigueDefault).clamp(0, 100),
        );

      case TrainingType.stamina:
        newStats = newStats.copyWith(
          stamina: (newStats.stamina + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue + TrainingConfig.fatigueStamina).clamp(0, 100),
        );

      case TrainingType.composure:
        newStats = newStats.copyWith(
          composure: (newStats.composure + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue + TrainingConfig.fatigueComposure).clamp(0, 100),
        );

      case TrainingType.rest:
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue - TrainingConfig.restFatigueRecovery).clamp(0, 100),
          confidence: (newStatus.confidence + TrainingConfig.restConfidenceGain).clamp(-3, 3),
        );

      case TrainingType.rehab:
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue - TrainingConfig.rehabFatigueRecovery).clamp(0, 100),
          injuryWeeksRemaining: (newStatus.injuryWeeksRemaining - TrainingConfig.rehabWeeksRecovery).clamp(0, 10),
        );
        // 부상 완치 체크
        if (newStatus.injuryWeeksRemaining == 0) {
          newStatus = newStatus.copyWith(injury: InjuryStatus.none);
        }
    }

    return TrainingResult(newStats: newStats, newStatus: newStatus);
  }

  /// 부상 체크 (순수 함수)
  InjuryCheckResult _checkInjury({
    required TrainingType type,
    required int fatigue,
    required Random random,
  }) {
    // 휴식/재활은 부상 위험 없음
    if (_isRestType(type)) {
      return const InjuryCheckResult.none();
    }

    // 피로 임계값 이상일 때 부상 확률 체크 (Config 기반)
    if (fatigue > TrainingConfig.injuryFatigueThreshold &&
        random.nextDouble() < TrainingConfig.injuryProbability) {
      final weeksRange = TrainingConfig.injuryWeeksMax - TrainingConfig.injuryWeeksMin + 1;
      final weeks = TrainingConfig.injuryWeeksMin + random.nextInt(weeksRange);
      return InjuryCheckResult.injured(InjuryStatus.minor, weeks);
    }

    return const InjuryCheckResult.none();
  }

  /// 휴식/재활 타입 체크
  bool _isRestType(TrainingType type) {
    return type == TrainingType.rest || type == TrainingType.rehab;
  }
}

/// 훈련 결과 (스탯 + 상태)
class TrainingResult {
  final PlayerStats newStats;
  final PlayerStatus newStatus;

  const TrainingResult({
    required this.newStats,
    required this.newStatus,
  });
}

/// 부상 체크 결과
class InjuryCheckResult {
  final bool hasInjury;
  final InjuryStatus? injury;
  final int? weeks;

  const InjuryCheckResult.none()
      : hasInjury = false,
        injury = null,
        weeks = null;

  const InjuryCheckResult.injured(this.injury, this.weeks) : hasInjury = true;
}
