/// 게임 밸런스 설정
///
/// 하드코딩된 밸런스 값들을 한 곳에서 관리
/// 게임 튜닝 시 이 파일만 수정하면 됨

// =============================================================================
// 훈련 관련 설정
// =============================================================================

/// 훈련 설정
class TrainingConfig {
  /// 스탯 증가량 (min ~ max)
  static const int statGainMin = 1;
  static const int statGainMax = 2;

  /// 훈련별 피로도 증가
  static const int fatigueDefault = 15;
  static const int fatigueStamina = 18;
  static const int fatigueComposure = 12;

  /// 휴식 효과
  static const int restFatigueRecovery = 20;
  static const int restConfidenceGain = 1;

  /// 재활 효과
  static const int rehabFatigueRecovery = 10;
  static const int rehabWeeksRecovery = 1;

  /// 부상 확률 (피로 70 이상일 때)
  static const int injuryFatigueThreshold = 70;
  static const double injuryProbability = 0.15;
  static const int injuryWeeksMin = 1;
  static const int injuryWeeksMax = 2;

  /// 훈련 강도 배율
  static const double lightIntensityStatMultiplier = 0.7;
  static const double lightIntensityFatigueMultiplier = 0.7;
  static const double lightIntensityInjuryMultiplier = 0.3;

  static const double normalIntensityStatMultiplier = 1.0;
  static const double normalIntensityFatigueMultiplier = 1.0;
  static const double normalIntensityInjuryMultiplier = 1.0;

  static const double intenseIntensityStatMultiplier = 1.5;
  static const double intenseIntensityFatigueMultiplier = 1.5;
  static const double intenseIntensityInjuryMultiplier = 2.0;

  /// 특별 훈련 이벤트 확률
  static const double eventProbability = 0.25; // 25% 확률로 이벤트 발생

  /// 이벤트별 효과
  static const double coachGuidanceStatBonus = 1.5; // 코치 지도: 스탯 +50%
  static const double rivalWinConfidence = 1; // 라이벌 승리: 자신감 +1
  static const double rivalLoseConfidence = -1; // 라이벌 패배: 자신감 -1
  static const int teamTacticsTrustBonus = 5; // 팀 전술: 신뢰도 +5
  static const double perfectFormFatigueMultiplier = 0.5; // 최고 컨디션: 피로 50%
  static const double minorSetbackStatMultiplier = 0.7; // 작은 차질: 스탯 70%

  /// 컨디션 기반 훈련 효율
  /// 피로도가 높으면 훈련 효율 감소
  static const int fatigueEfficiencyThreshold = 50; // 피로 50 이상부터 효율 감소
  static const double fatigueEfficiencyPenaltyRate = 0.01; // 피로 1당 효율 -1%
  static const double maxFatigueEfficiencyPenalty = 0.3; // 최대 30% 감소

  /// 자신감 기반 훈련 효율
  /// 자신감이 높으면 훈련 효율 증가
  static const double confidenceEfficiencyRate = 0.05; // 자신감 1당 효율 +-5%
}

// =============================================================================
// 경기 관련 설정
// =============================================================================

/// 피로 페널티 설정
class FatigueConfig {
  /// 피로 임계값
  static const int lowThreshold = 60;
  static const int highThreshold = 80;

  /// 피로 페널티 계수
  static const double lowPenaltyRate = 0.003; // 60~80 구간
  static const double highPenaltyBase = 0.06; // 80 이상 기본
  static const double highPenaltyRate = 0.006; // 80 이상 추가

  /// 피로 70 이상 시 추가 피로 증가
  static const int extraFatigueThreshold = 70;
  static const double extraFatigueAmount = 2;
}

/// 모멘텀 변화 설정 (New)
class MomentumConfig {
  static const int successGain = 1;
  static const int failureLoss = -1;
  static const int goalGain = 3; // 득점 시
  static const int assistGain = 2;
  static const int keyPassGain = 2;
  static const int defenseSuccessGain = 2; // 태클/인터셉트 성공

  static const int bigChanceMissLoss = -2; // 1:1 실패 등
  static const int possessionLostLoss = -1;

  static const int maxMomentum = 3;
  static const int minMomentum = -3;
}

/// 전술 외침 설정 (New)
class ShoutConfig {
  static const int encourageMomentumGain = 1;
  static const int demandMomentumGain = 2; // 강한 반등
  static const int demandConfidenceCost = -2; // 대신 자신감 하락 위험
  static const int calmMomentumRestoration = 2; // 음수일 때 회복량
}

/// 자신감/모멘텀 보너스 설정
class MentalConfig {
  /// 자신감 보너스 계수 (confidence * rate)
  /// confidence 범위: -3 ~ +3
  /// 결과: -0.06 ~ +0.06
  static const double confidenceRate = 0.02;

  /// 모멘텀 보너스 계수
  /// momentum 범위: -3 ~ +3
  /// 결과: -0.12 ~ +0.12 (체감 가능한 수준)
  static const double momentumRate = 0.04;

  /// HOT 상태 (연속 성공) 설정
  static const int hotStreakThreshold = 3;
  static const double hotStreakBonus = 0.08;

  /// COLD 상태 (연속 실패) 설정
  static const int coldStreakThreshold = 2;
  static const double coldStreakPenalty = 0.05;
}

/// 커맨드 보정 설정
class CommandConfig {
  /// 안전한 플레이 보너스
  static const double safePlayBonus = 0.15;

  /// 위험한 플레이 페널티
  static const double riskyPlayPenalty = 0.10;

  /// 침착성 낮을 때 클러치 페널티
  static const int lowComposureThreshold = 50;
  static const double lowComposurePenalty = 0.10;

  /// 부상 상태 페널티
  static const double injuryPenalty = 0.10;
}

/// 상대 난이도 설정
class OpponentConfig {
  /// 상대 레이팅 기준점
  static const int baseRating = 50;

  /// 난이도 계수 (rating 차이 / divisor)
  static const double difficultyDivisor = 400;
}

/// 결과 보상 설정
class RewardConfig {
  /// 골 평점 보너스
  static const double goalRating = 8.0;

  /// 어시스트 평점 보너스
  static const double assistRating = 5.0;

  /// 일반 성공 평점
  static const double normalSuccessRating = 2.0;

  /// 좋은 성공 평점 (드리블 등)
  static const double goodSuccessRating = 3.0;

  /// 실패 평점 페널티
  static const double failurePenalty = -2.0;

  /// 큰 기회 실패 페널티 (1:1 등)
  static const double bigChanceFailurePenalty = -4.0;

  /// 페널티킥 실패 페널티
  static const double penaltyMissPenalty = -8.0;

  /// 클러치 실패 페널티
  static const double clutchMissPenalty = -6.0;

  /// 어시스트 확률 (패스 성공 시)
  static const double assistProbability = 0.6;

  /// 클러치 어시스트 확률
  static const double clutchAssistProbability = 0.7;

  /// 옐로카드 확률 (태클 실패 시)
  static const double yellowCardProbability = 0.25;
  static const double yellowCardPenalty = -3.0;

  /// 기본 피로 증가
  static const int baseFatigueGain = 3;

  /// 프레싱 피로 증가
  static const int pressingFatigueGain = 5;

  /// 페널티킥 피로
  static const int penaltyFatigueGain = 1;
}

/// 자신감 변화 설정
class ConfidenceConfig {
  /// 골 득점 시
  static const int goalConfidence = 1;

  /// 페널티 성공 시
  static const int penaltySuccessConfidence = 2;

  /// 클러치 골 시
  static const int clutchGoalConfidence = 3;

  /// 클러치 어시스트 시
  static const int clutchAssistConfidence = 2;

  /// 1:1 실패 시
  static const int bigChanceFailureConfidence = -1;

  /// 페널티 실패 시
  static const int penaltyMissConfidence = -2;

  /// 클러치 실패 시
  static const int clutchMissConfidence = -2;
}

/// 부상 확률 설정
class InjuryConfig {
  /// 부상 확률 계산: baseRisk * (1 + fatigue/100) * (1 + pressure * rate)
  static const double pressureRate = 0.1;
}

/// 확률 범위 설정
class ProbabilityConfig {
  /// 최소/최대 성공 확률
  static const double minProbability = 0.05;
  static const double maxProbability = 0.95;

  /// 스탯 보너스 계수
  static const double statBonusRate = 0.3;
}

/// 팀 경기 시뮬레이션 설정
class SimulationConfig {
  /// 공격력 나누기 계수 (attackRating / x)
  static const double attackDivisor = 40.0;

  /// 수비력 보정 계수 ((100 - defense) / x)
  static const double defenseDivisor = 50.0;

  /// 홈 어드밴티지 계수
  static const double homeAdvantage = 1.1;

  /// 랜덤성 최소 계수
  static const double randomBase = 0.7;

  /// 랜덤성 변동 폭
  static const double randomVariance = 0.6;

  /// 최대 골 수 제한
  static const int maxGoals = 4;
}
