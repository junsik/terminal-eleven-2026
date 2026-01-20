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
  static const int extraFatigueAmount = 2;
}

/// 자신감/모멘텀 보너스 설정
class MentalConfig {
  /// 자신감 보너스 계수 (confidence * rate)
  /// confidence 범위: -3 ~ +3
  /// 결과: -0.06 ~ +0.06
  static const double confidenceRate = 0.02;

  /// 모멘텀 보너스 계수
  static const double momentumRate = 0.02;

  /// HOT 상태 (연속 성공) 설정
  static const int hotStreakThreshold = 3;
  static const double hotStreakBonus = 0.05;
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
