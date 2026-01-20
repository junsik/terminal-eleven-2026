# 밸런스 설정

## 개요

게임의 모든 밸런스 수치는 `lib/domain/config/balance_config.dart`에서 중앙 관리됩니다.

## 훈련 설정 (TrainingConfig)

```dart
class TrainingConfig {
  static const int fatigueDefault = 15;      // 기본 피로 증가
  static const int fatigueStamina = 18;      // 체력 훈련 피로
  static const int fatigueMental = 12;       // 멘탈 훈련 피로
  static const int restFatigueRecovery = 20; // 휴식 피로 감소
}
```

## 확률 설정 (ProbabilityConfig)

```dart
class ProbabilityConfig {
  static const double statBonusRate = 0.005;    // 스탯 보너스 계수
  static const double fatigueThreshold = 50.0;  // 피로 페널티 기준
  static const double fatiguePenaltyRate = 0.003; // 피로 페널티 계수
}
```

## 멘탈 설정 (MentalConfig)

```dart
class MentalConfig {
  // 자신감 보너스
  static const double confidenceRate = 0.02;  // ±6%

  // 모멘텀 보너스
  static const double momentumRate = 0.04;    // ±12%

  // HOT/COLD 상태
  static const int hotStreakThreshold = 3;    // 3연속 성공
  static const double hotStreakBonus = 0.08;  // +8%

  static const int coldStreakThreshold = 2;   // 2연속 실패
  static const double coldStreakPenalty = 0.05; // -5%
}
```

## 커맨드 설정 (CommandConfig)

```dart
class CommandConfig {
  static const double safePlayBonus = 0.15;   // 안전한 플레이 +15%
  static const double riskyPlayPenalty = 0.10; // 위험한 플레이 -10%
}
```

## 보상 설정 (RewardConfig)

```dart
class RewardConfig {
  // 평점 변화
  static const double goalRating = 2.0;
  static const double assistRating = 1.5;
  static const double normalSuccessRating = 0.5;
  static const double failureRating = -0.5;

  // 피로 변화
  static const int pressingFatigueGain = 3;
}
```

## 모멘텀 설정 (MomentumConfig)

```dart
class MomentumConfig {
  static const int minMomentum = -3;
  static const int maxMomentum = 3;

  // 변화량
  static const int goalGain = 2;
  static const int successGain = 1;
  static const int defenseSuccessGain = 1;
  static const int failureLoss = -1;
  static const int clutchSuccessGain = 3;
}
```

## 전술 외침 설정 (ShoutConfig)

```dart
class ShoutConfig {
  static const int encourageMomentumGain = 1;  // 격려
  static const int demandMomentumGain = 2;     // 요구
  static const int calmMomentumLoss = -1;      // 진정
}
```

## 상대 난이도 설정 (OpponentConfig)

```dart
class OpponentConfig {
  static const int baseRating = 50;          // 기준 레이팅
  static const double difficultyDivisor = 100.0; // 난이도 계수
}
```

## 시뮬레이션 설정 (SimulationConfig)

AI 팀 간 경기 시뮬레이션:

```dart
class SimulationConfig {
  static const double attackDivisor = 50.0;
  static const double defenseDivisor = 100.0;
  static const double homeAdvantage = 1.15;  // 홈 어드밴티지 +15%
  static const double randomBase = 0.7;
  static const double randomVariance = 0.6;
  static const int maxGoals = 4;
}
```

## 밸런스 조정 가이드

### 난이도 조절
- `ProbabilityConfig.statBonusRate` 증가 → 쉬워짐
- `OpponentConfig.difficultyDivisor` 증가 → 쉬워짐

### 모멘텀 영향력 조절
- `MentalConfig.momentumRate` 증가 → 모멘텀 효과 강화
- `MentalConfig.hotStreakBonus` 조절 → HOT 상태 보너스

### 위험 플레이 보상
- `CommandConfig.riskyPlayPenalty` 감소 → 위험한 선택 매력도 증가

---

[[홈으로|Home]]
