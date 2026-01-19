// 경기 엔진 - 확률 계산 및 결과 해결

import 'dart:math';
import '../model/models.dart';
import '../text/commentary.dart';

/// 확률 계산 규칙
class ProbabilityRules {
  /// 피로 페널티 계산
  static double fatiguePenalty(int fatigue) {
    if (fatigue <= 60) return 0;
    if (fatigue <= 80) return (fatigue - 60) * 0.003;
    return 0.06 + (fatigue - 80) * 0.006;
  }

  /// 자신감 보너스 계산
  static double confidenceBonus(int confidence) {
    return confidence * 0.02; // -0.06 ~ +0.06
  }

  /// 모멘텀 보너스 계산
  static double momentumBonus(int momentum, int consecutiveSuccess) {
    double bonus = momentum * 0.02; // -0.06 ~ +0.06
    // 연속 성공 시 추가 보너스
    if (consecutiveSuccess >= 3) {
      bonus += 0.05; // HOT 상태
    }
    return bonus;
  }

  /// 부상 확률 계산
  static double injuryProbability({
    required double baseRisk,
    required int fatigue,
    required int opponentPressure,
  }) {
    return baseRisk * (1 + fatigue / 100) * (1 + opponentPressure * 0.1);
  }
}

/// 이벤트별 기본 확률 및 스탯 가중치
class EventProbability {
  final double base;
  final Map<String, double> statWeights;
  final double injuryRisk;
  final double riskMultiplier; // 위험한 선택 시 보상 배율

  const EventProbability({
    required this.base,
    required this.statWeights,
    this.injuryRisk = 0,
    this.riskMultiplier = 1.0,
  });

  static const Map<HighlightType, EventProbability> defaults = {
    HighlightType.runInBehind: EventProbability(
      base: 0.40,
      statWeights: {'pace': 0.5, 'positioning': 0.3, 'composure': 0.2},
    ),
    HighlightType.receiveAndTurn: EventProbability(
      base: 0.45,
      statWeights: {'ballControl': 0.5, 'composure': 0.3, 'passing': 0.2},
    ),
    HighlightType.oneOnOne: EventProbability(
      base: 0.35,
      statWeights: {'shooting': 0.5, 'composure': 0.3, 'ballControl': 0.2},
      riskMultiplier: 1.5,
    ),
    HighlightType.edgeOfBoxShot: EventProbability(
      base: 0.30,
      statWeights: {'shooting': 0.6, 'composure': 0.2, 'passing': 0.2},
    ),
    HighlightType.quickCounter: EventProbability(
      base: 0.45,
      statWeights: {'pace': 0.3, 'passing': 0.4, 'ballControl': 0.3},
    ),
    HighlightType.pressing: EventProbability(
      base: 0.50,
      statWeights: {'stamina': 0.3, 'pace': 0.2, 'composure': 0.2, 'positioning': 0.3},
      injuryRisk: 0.02,
    ),
    HighlightType.defensiveCover: EventProbability(
      base: 0.60,
      statWeights: {'positioning': 0.6, 'stamina': 0.4},
    ),
    HighlightType.looseBall: EventProbability(
      base: 0.45,
      statWeights: {'ballControl': 0.3, 'stamina': 0.3, 'pace': 0.2, 'composure': 0.2},
      injuryRisk: 0.03,
    ),
    HighlightType.setPieceRebound: EventProbability(
      base: 0.35,
      statWeights: {'shooting': 0.5, 'positioning': 0.3, 'composure': 0.2},
    ),
    HighlightType.fatigueMoment: EventProbability(
      base: 0.50,
      statWeights: {'stamina': 0.5, 'composure': 0.5},
    ),
    HighlightType.mentalPressure: EventProbability(
      base: 0.55,
      statWeights: {'composure': 0.7, 'positioning': 0.3},
    ),
    HighlightType.coachFeedback: EventProbability(
      base: 1.0,
      statWeights: {},
    ),
    // 새로운 이벤트들
    HighlightType.penaltyKick: EventProbability(
      base: 0.75, // 페널티킥은 높은 성공률
      statWeights: {'shooting': 0.4, 'composure': 0.6},
      riskMultiplier: 2.0, // 성공 시 큰 보상
    ),
    HighlightType.clutchChance: EventProbability(
      base: 0.30, // 클러치는 어려움
      statWeights: {'shooting': 0.4, 'composure': 0.4, 'positioning': 0.2},
      riskMultiplier: 2.5, // 성공 시 극대화된 보상
    ),
  };
}

/// 하이라이트 결과 해결자
class HighlightResolver {
  final Random _random;
  late final Commentary _commentary;

  HighlightResolver({int? seed}) : _random = Random(seed) {
    _commentary = Commentary(seed: seed);
  }

  /// 하이라이트 결과 계산
  HighlightResult resolve({
    required HighlightEvent event,
    required CommandType command,
    required PlayerStats stats,
    required PlayerStatus status,
    required int opponentRating,
    int momentum = 0,
    int consecutiveSuccess = 0,
  }) {
    final eventProb = EventProbability.defaults[event.type] ??
        const EventProbability(base: 0.5, statWeights: {});

    // 성공 확률 계산
    final probability = _calculateProbability(
      base: eventProb.base,
      statWeights: eventProb.statWeights,
      stats: stats,
      status: status,
      command: command,
      opponentRating: opponentRating,
      momentum: momentum,
      consecutiveSuccess: consecutiveSuccess,
      isClutch: event.type == HighlightType.clutchChance,
    );

    final roll = _random.nextDouble();
    final success = roll < probability;

    // 결과 생성
    return _generateResult(
      success: success,
      event: event,
      command: command,
      eventProb: eventProb,
      status: status,
    );
  }

  /// 성공 확률 계산
  double _calculateProbability({
    required double base,
    required Map<String, double> statWeights,
    required PlayerStats stats,
    required PlayerStatus status,
    required CommandType command,
    required int opponentRating,
    required int momentum,
    required int consecutiveSuccess,
    required bool isClutch,
  }) {
    double p = base;

    // 스탯 보너스
    final statsMap = {
      'pace': stats.pace,
      'shooting': stats.shooting,
      'passing': stats.passing,
      'ballControl': stats.ballControl,
      'positioning': stats.positioning,
      'stamina': stats.stamina,
      'composure': stats.composure,
    };

    double statBonus = 0;
    for (final entry in statWeights.entries) {
      final statValue = statsMap[entry.key] ?? 50;
      statBonus += (statValue / 100) * entry.value;
    }
    p += statBonus * 0.3;

    // 피로 페널티
    p -= ProbabilityRules.fatiguePenalty(status.fatigue);

    // 자신감 보너스
    p += ProbabilityRules.confidenceBonus(status.confidence);

    // 모멘텀 보너스
    p += ProbabilityRules.momentumBonus(momentum, consecutiveSuccess);

    // 상대 난이도
    p -= (opponentRating - 50) / 400;

    // 커맨드별 보정
    if (command == CommandType.safePlay) {
      p += 0.15; // 안전하게 하면 성공률 상승
    } else if (command.isRisky) {
      p -= 0.10; // 위험한 플레이는 성공률 하락
    }

    // 클러치 상황 긴장감
    if (isClutch) {
      // 침착성이 낮으면 더 큰 페널티
      if (stats.composure < 50) {
        p -= 0.10;
      }
    }

    // 부상 상태 페널티
    if (status.injury != InjuryStatus.none) {
      p -= 0.1;
    }

    return p.clamp(0.05, 0.95);
  }

  /// 결과 생성
  HighlightResult _generateResult({
    required bool success,
    required HighlightEvent event,
    required CommandType command,
    required EventProbability eventProb,
    required PlayerStatus status,
  }) {
    double ratingChange = 0;
    int fatigueChange = 3;
    int confidenceChange = 0;
    bool isGoal = false;
    bool isAssist = false;
    bool isYellowCard = false;
    bool isRedCard = false;
    bool isInjury = false;

    final isClutch = event.type == HighlightType.clutchChance;
    final isPenalty = event.type == HighlightType.penaltyKick;
    final multiplier = eventProb.riskMultiplier;

    if (success) {
      switch (event.type) {
        case HighlightType.oneOnOne:
        case HighlightType.edgeOfBoxShot:
        case HighlightType.setPieceRebound:
          if (command == CommandType.shoot) {
            isGoal = true;
            ratingChange = 8.0 * multiplier;
            confidenceChange = 1;
          } else if (command == CommandType.pass) {
            isAssist = _random.nextDouble() < 0.6;
            ratingChange = isAssist ? 5.0 : 3.0;
          } else {
            ratingChange = 2.0;
          }
          break;

        case HighlightType.penaltyKick:
          isGoal = true;
          ratingChange = 8.0 * multiplier; // 16점!
          confidenceChange = 2;
          fatigueChange = 1;
          break;

        case HighlightType.clutchChance:
          if (command == CommandType.shoot) {
            isGoal = true;
            ratingChange = 8.0 * multiplier; // 20점!
            confidenceChange = 3; // 최대 자신감
          } else if (command == CommandType.pass) {
            isAssist = _random.nextDouble() < 0.7;
            ratingChange = isAssist ? 10.0 : 5.0;
            confidenceChange = 2;
          } else {
            ratingChange = 3.0;
          }
          break;

        case HighlightType.runInBehind:
        case HighlightType.quickCounter:
          if (command == CommandType.dribble) {
            ratingChange = 3.0;
          } else {
            ratingChange = 2.0;
          }
          break;

        case HighlightType.pressing:
          ratingChange = 2.0;
          fatigueChange = 5;
          break;

        default:
          ratingChange = 1.5;
      }
    } else {
      // 실패 시 결과
      switch (event.type) {
        case HighlightType.oneOnOne:
        case HighlightType.setPieceRebound:
          ratingChange = -4.0;
          confidenceChange = -1;
          break;

        case HighlightType.penaltyKick:
          ratingChange = -8.0; // 실축은 큰 타격
          confidenceChange = -2;
          break;

        case HighlightType.clutchChance:
          ratingChange = -6.0;
          confidenceChange = -2;
          break;

        case HighlightType.pressing:
        case HighlightType.looseBall:
          if (command == CommandType.tackle) {
            if (_random.nextDouble() < 0.25) {
              isYellowCard = true;
              ratingChange = -3.0;
            } else {
              ratingChange = -2.0;
            }
          } else {
            ratingChange = -2.0;
          }
          break;

        default:
          ratingChange = -2.0;
      }
    }

    // 부상 체크
    if (eventProb.injuryRisk > 0) {
      final injuryProb = ProbabilityRules.injuryProbability(
        baseRisk: eventProb.injuryRisk,
        fatigue: status.fatigue,
        opponentPressure: event.pressure,
      );
      isInjury = _random.nextDouble() < injuryProb;
    }

    // 피로도에 따른 추가 피로
    if (status.fatigue > 70) {
      fatigueChange += 2;
    }

    // 새 코멘터리 시스템 사용
    final description = _generateRichDescription(
      success: success,
      event: event,
      command: command,
      isGoal: isGoal,
      isAssist: isAssist,
      isYellowCard: isYellowCard,
      isClutch: isClutch,
      isPenalty: isPenalty,
    );

    return HighlightResult(
      success: success,
      isGoal: isGoal,
      isAssist: isAssist,
      isYellowCard: isYellowCard,
      isRedCard: isRedCard,
      isInjury: isInjury,
      ratingChange: ratingChange,
      fatigueChange: fatigueChange,
      confidenceChange: confidenceChange,
      description: description,
    );
  }

  /// 풍부한 결과 설명 생성
  String _generateRichDescription({
    required bool success,
    required HighlightEvent event,
    required CommandType command,
    required bool isGoal,
    required bool isAssist,
    required bool isYellowCard,
    required bool isClutch,
    required bool isPenalty,
  }) {
    // 특수 상황 처리
    if (isGoal) {
      return _commentary.getSuccessText(
        event.type,
        command,
        '선수', // 실제로는 선수 이름
        isGoal: true,
        isClutch: isClutch,
      );
    }

    if (isAssist) {
      return _commentary.getSuccessText(
        event.type,
        command,
        '선수',
        isAssist: true,
      );
    }

    if (isYellowCard) {
      return _yellowCardDescriptions[_random.nextInt(_yellowCardDescriptions.length)];
    }

    // 페널티킥 실패 (특수 처리)
    if (isPenalty && !success) {
      return _penaltyMissDescriptions[_random.nextInt(_penaltyMissDescriptions.length)];
    }

    // 클러치 실패 (특수 처리)
    if (isClutch && !success) {
      return _clutchMissDescriptions[_random.nextInt(_clutchMissDescriptions.length)];
    }

    if (success) {
      return _commentary.getSuccessText(event.type, command, '선수');
    } else {
      return _commentary.getFailureText(event.type, command, '선수');
    }
  }

  static const _yellowCardDescriptions = [
    '⚠️ 거친 태클로 경고를 받았다.',
    '⚠️ 주심이 옐로카드를 꺼내든다!',
    '⚠️ 조심해야 한다. 경고 1장.',
  ];

  static const _penaltyMissDescriptions = [
    '💔 아아... 키퍼가 막았다!!!',
    '💔 골대 위로... 하늘을 향해 날아갔다!',
    '💔 골포스트! 믿을 수 없다...',
    '💔 키퍼의 신들린 선방! 실축의 아픔...',
    '💔 놓쳤다... 가장 쉬운 기회를...',
  ];

  static const _clutchMissDescriptions = [
    '💔 아... 아쉽다! 마지막 기회였는데!',
    '💔 운명의 장난인가... 놓쳤다.',
    '💔 하늘도 야속하다... 아깝다!',
    '💔 끝... 역전의 꿈이 사라졌다.',
    '💔 너무 아쉽다... 이게 축구다.',
  ];
}
