/// 훈련 엔진
///
/// 훈련 관련 로직만 담당하는 순수 함수 엔진
/// - 스탯 변경 계산
/// - 피로도 계산
/// - 부상 체크
/// - 특별 훈련 이벤트

import 'dart:math';
import 'base_engine.dart';
import '../config/balance_config.dart';
import '../state/game_state.dart';
import '../action/game_action.dart';
import '../model/player.dart';
import '../model/game_snapshot.dart' show TrainingType, TrainingIntensity;
import '../model/training_event.dart';

/// 훈련 엔진
class TrainingEngine extends GameEngine<TrainingAction> {
  @override
  bool canHandle(GameAction action) => action is TrainingAction;

  @override
  GameState process(GameState state, TrainingAction action, int seed) {
    return switch (action) {
      ExecuteTraining(:final type, :final intensity) =>
        _executeTraining(state, type, intensity, seed),
    };
  }

  /// 훈련 실행
  GameState _executeTraining(
    GameState state,
    TrainingType type,
    TrainingIntensity intensity,
    int seed,
  ) {
    final random = Random(seed);
    final player = state.player;
    final character = player.character;

    // 행동 가능 여부 체크
    if (!player.canTakeAction) {
      return state; // 변경 없이 반환
    }

    // 특별 이벤트 체크 (휴식/재활 제외)
    final event = _checkForEvent(type, random);

    // 훈련 효과 계산 (이벤트 적용)
    final result = _calculateTrainingEffect(
      type: type,
      intensity: intensity,
      currentStats: character.stats,
      currentStatus: character.status,
      random: random,
      event: event,
    );

    // 부상 체크
    final injuryResult = _checkInjury(
      type: type,
      intensity: intensity,
      fatigue: result.newStatus.fatigue,
      random: random,
    );

    // 최종 상태 적용
    var finalStatus = injuryResult.hasInjury
        ? result.newStatus.copyWith(
            injury: injuryResult.injury!,
            injuryWeeksRemaining: injuryResult.weeks!,
          )
        : result.newStatus;

    // 이벤트에 의한 자신감 변화 적용
    if (event != null) {
      finalStatus = finalStatus.copyWith(
        confidence: (finalStatus.confidence + event.confidenceChange).clamp(-3, 3),
      );
    }

    // 커리어 데이터 업데이트 (이벤트에 의한 신뢰도 변화)
    var newCareer = character.career;
    if (event != null && event.trustChange != 0) {
      newCareer = newCareer.copyWith(
        trust: (newCareer.trust + event.trustChange).clamp(0, 100),
      );
    }

    // 새 상태 반환
    return state.copyWith(
      player: player.copyWith(
        character: character.copyWith(
          stats: result.newStats,
          status: finalStatus,
          career: newCareer,
        ),
        weeklyActionsRemaining: player.weeklyActionsRemaining - 1,
        lastTrainingEvent: event,
      ),
      meta: state.meta.copyWith(savedAt: DateTime.now()),
    );
  }

  /// 특별 이벤트 체크
  TrainingEventResult? _checkForEvent(TrainingType type, Random random) {
    // 휴식/재활은 이벤트 없음
    if (_isRestType(type)) return null;

    // 이벤트 발생 확률 체크
    if (random.nextDouble() > TrainingConfig.eventProbability) return null;

    // 랜덤 이벤트 선택
    final events = TrainingEventType.values;
    final selectedEvent = events[random.nextInt(events.length)];

    return _createEventResult(selectedEvent, random);
  }

  /// 이벤트 결과 생성
  TrainingEventResult _createEventResult(TrainingEventType type, Random random) {
    switch (type) {
      case TrainingEventType.coachGuidance:
        return TrainingEventResult(
          eventType: type,
          statMultiplier: TrainingConfig.coachGuidanceStatBonus,
          message: '코치가 직접 1:1 지도를 해주었습니다!',
        );

      case TrainingEventType.rivalCompetition:
        // 50% 확률로 승리/패배
        final won = random.nextBool();
        return TrainingEventResult(
          eventType: type,
          confidenceChange: won
              ? TrainingConfig.rivalWinConfidence.toInt()
              : TrainingConfig.rivalLoseConfidence.toInt(),
          message: won ? '라이벌과의 경쟁에서 승리했습니다!' : '라이벌에게 졌습니다...',
        );

      case TrainingEventType.teamTactics:
        return TrainingEventResult(
          eventType: type,
          trustChange: TrainingConfig.teamTacticsTrustBonus,
          message: '팀 전술 훈련에 적극적으로 참여했습니다!',
        );

      case TrainingEventType.perfectForm:
        return TrainingEventResult(
          eventType: type,
          fatigueMultiplier: TrainingConfig.perfectFormFatigueMultiplier,
          message: '오늘따라 몸이 가볍습니다!',
        );

      case TrainingEventType.minorSetback:
        return TrainingEventResult(
          eventType: type,
          statMultiplier: TrainingConfig.minorSetbackStatMultiplier,
          message: '컨디션이 좋지 않아 훈련 효과가 떨어졌습니다.',
        );
    }
  }

  /// 훈련 효과 계산 (순수 함수)
  TrainingResult _calculateTrainingEffect({
    required TrainingType type,
    required TrainingIntensity intensity,
    required PlayerStats currentStats,
    required PlayerStatus currentStatus,
    required Random random,
    TrainingEventResult? event,
  }) {
    var newStats = currentStats;
    var newStatus = currentStatus;

    // 강도별 배율 가져오기
    final (statMult, fatigueMult) = _getIntensityMultipliers(intensity);

    // 이벤트 배율 적용
    final eventStatMult = event?.statMultiplier ?? 1.0;
    final eventFatigueMult = event?.fatigueMultiplier ?? 1.0;

    // 컨디션 기반 효율 (피로, 자신감)
    final conditionEfficiency = _getConditionEfficiency(
      currentStatus.fatigue,
      currentStatus.confidence,
    );

    // 스탯 증가량 (Config 기반 + 강도 배율 + 이벤트 배율 + 컨디션 효율)
    final statGainRange =
        TrainingConfig.statGainMax - TrainingConfig.statGainMin + 1;
    final baseStatGain =
        TrainingConfig.statGainMin + random.nextInt(statGainRange);
    final statGain =
        (baseStatGain * statMult * eventStatMult * conditionEfficiency).round();

    // 최종 피로 배율
    final finalFatigueMult = fatigueMult * eventFatigueMult;

    switch (type) {
      case TrainingType.shooting:
        newStats = newStats.copyWith(
          shooting: (newStats.shooting + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue +
                  (TrainingConfig.fatigueDefault * finalFatigueMult).round())
              .clamp(0, 100),
        );

      case TrainingType.passing:
        newStats = newStats.copyWith(
          passing: (newStats.passing + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue +
                  (TrainingConfig.fatigueDefault * finalFatigueMult).round())
              .clamp(0, 100),
        );

      case TrainingType.dribbling:
        newStats = newStats.copyWith(
          ballControl: (newStats.ballControl + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue +
                  (TrainingConfig.fatigueDefault * finalFatigueMult).round())
              .clamp(0, 100),
        );

      case TrainingType.positioning:
        newStats = newStats.copyWith(
          positioning: (newStats.positioning + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue +
                  (TrainingConfig.fatigueDefault * finalFatigueMult).round())
              .clamp(0, 100),
        );

      case TrainingType.stamina:
        newStats = newStats.copyWith(
          stamina: (newStats.stamina + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue +
                  (TrainingConfig.fatigueStamina * finalFatigueMult).round())
              .clamp(0, 100),
        );

      case TrainingType.composure:
        newStats = newStats.copyWith(
          composure: (newStats.composure + statGain).clamp(0, 100),
        );
        newStatus = newStatus.copyWith(
          fatigue: (newStatus.fatigue +
                  (TrainingConfig.fatigueComposure * finalFatigueMult).round())
              .clamp(0, 100),
        );

      case TrainingType.rest:
        // 휴식은 강도 영향 없음
        newStatus = newStatus.copyWith(
          fatigue:
              (newStatus.fatigue - TrainingConfig.restFatigueRecovery).clamp(0, 100),
          confidence:
              (newStatus.confidence + TrainingConfig.restConfidenceGain).clamp(-3, 3),
        );

      case TrainingType.rehab:
        // 재활도 강도 영향 없음
        newStatus = newStatus.copyWith(
          fatigue:
              (newStatus.fatigue - TrainingConfig.rehabFatigueRecovery).clamp(0, 100),
          injuryWeeksRemaining:
              (newStatus.injuryWeeksRemaining - TrainingConfig.rehabWeeksRecovery)
                  .clamp(0, 10),
        );
        // 부상 완치 체크
        if (newStatus.injuryWeeksRemaining == 0) {
          newStatus = newStatus.copyWith(injury: InjuryStatus.none);
        }
    }

    return TrainingResult(newStats: newStats, newStatus: newStatus);
  }

  /// 강도별 배율 반환 (스탯배율, 피로배율)
  (double, double) _getIntensityMultipliers(TrainingIntensity intensity) {
    return switch (intensity) {
      TrainingIntensity.light => (
          TrainingConfig.lightIntensityStatMultiplier,
          TrainingConfig.lightIntensityFatigueMultiplier,
        ),
      TrainingIntensity.normal => (
          TrainingConfig.normalIntensityStatMultiplier,
          TrainingConfig.normalIntensityFatigueMultiplier,
        ),
      TrainingIntensity.intense => (
          TrainingConfig.intenseIntensityStatMultiplier,
          TrainingConfig.intenseIntensityFatigueMultiplier,
        ),
    };
  }

  /// 컨디션 기반 효율 배율 계산
  double _getConditionEfficiency(int fatigue, int confidence) {
    double efficiency = 1.0;

    // 피로도 패널티 (50 이상부터 효율 감소)
    if (fatigue > TrainingConfig.fatigueEfficiencyThreshold) {
      final fatigueOver = fatigue - TrainingConfig.fatigueEfficiencyThreshold;
      final penalty = (fatigueOver * TrainingConfig.fatigueEfficiencyPenaltyRate)
          .clamp(0.0, TrainingConfig.maxFatigueEfficiencyPenalty);
      efficiency -= penalty;
    }

    // 자신감 보너스/패널티 (-3 ~ +3)
    efficiency += confidence * TrainingConfig.confidenceEfficiencyRate;

    // 최소 50% 효율 보장
    return efficiency.clamp(0.5, 1.5);
  }

  /// 부상 체크 (순수 함수)
  InjuryCheckResult _checkInjury({
    required TrainingType type,
    required TrainingIntensity intensity,
    required int fatigue,
    required Random random,
  }) {
    // 휴식/재활은 부상 위험 없음
    if (_isRestType(type)) {
      return const InjuryCheckResult.none();
    }

    // 강도별 부상 확률 배율
    final injuryMult = switch (intensity) {
      TrainingIntensity.light => TrainingConfig.lightIntensityInjuryMultiplier,
      TrainingIntensity.normal => TrainingConfig.normalIntensityInjuryMultiplier,
      TrainingIntensity.intense => TrainingConfig.intenseIntensityInjuryMultiplier,
    };

    // 피로 임계값 이상일 때 부상 확률 체크 (Config 기반 + 강도 배율)
    final adjustedProbability = TrainingConfig.injuryProbability * injuryMult;
    if (fatigue > TrainingConfig.injuryFatigueThreshold &&
        random.nextDouble() < adjustedProbability) {
      final weeksRange =
          TrainingConfig.injuryWeeksMax - TrainingConfig.injuryWeeksMin + 1;
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
