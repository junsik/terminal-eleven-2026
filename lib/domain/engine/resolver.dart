// 경기 엔진 - 확률 계산 및 결과 해결

import 'dart:math';
import '../model/models.dart';

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

  const EventProbability({
    required this.base,
    required this.statWeights,
    this.injuryRisk = 0,
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
      base: 1.0, // 항상 성공 (신뢰도 영향)
      statWeights: {},
    ),
  };
}

/// 하이라이트 결과 해결자
class HighlightResolver {
  final Random _random;

  HighlightResolver({int? seed}) : _random = Random(seed);

  /// 하이라이트 결과 계산
  HighlightResult resolve({
    required HighlightEvent event,
    required CommandType command,
    required PlayerStats stats,
    required PlayerStatus status,
    required int opponentRating,
  }) {
    final eventProb = EventProbability.defaults[event.type]!;

    // 성공 확률 계산
    final probability = _calculateProbability(
      base: eventProb.base,
      statWeights: eventProb.statWeights,
      stats: stats,
      status: status,
      command: command,
      opponentRating: opponentRating,
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

    // 상대 난이도
    p -= (opponentRating - 50) / 400;

    // 커맨드별 보정
    if (command == CommandType.safePlay) {
      p += 0.15; // 안전하게 하면 성공률 상승
    } else if (command.isRisky) {
      p -= 0.10; // 위험한 플레이는 성공률 하락
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
    int fatigueChange = 3; // 기본 피로 증가
    int confidenceChange = 0;
    bool isGoal = false;
    bool isAssist = false;
    bool isYellowCard = false;
    bool isRedCard = false;
    bool isInjury = false;

    if (success) {
      // 성공 시 결과
      switch (event.type) {
        case HighlightType.oneOnOne:
        case HighlightType.edgeOfBoxShot:
        case HighlightType.setPieceRebound:
          if (command == CommandType.shoot) {
            isGoal = true;
            ratingChange = 8.0;
            confidenceChange = 1;
          } else if (command == CommandType.pass) {
            isAssist = _random.nextDouble() < 0.6;
            ratingChange = isAssist ? 5.0 : 3.0;
          } else {
            ratingChange = 2.0;
          }
          break;

        case HighlightType.runInBehind:
        case HighlightType.quickCounter:
          if (command == CommandType.dribble) {
            // 1:1 상황 생성 가능
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
          ratingChange = -4.0; // 결정적 찬스 실패
          confidenceChange = -1;
          break;

        case HighlightType.pressing:
        case HighlightType.looseBall:
          if (command == CommandType.tackle) {
            // 태클 실패 시 카드 위험
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

    final description = _generateDescription(
      success: success,
      event: event,
      command: command,
      isGoal: isGoal,
      isAssist: isAssist,
      isYellowCard: isYellowCard,
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

  /// 결과 설명 생성 (한국어)
  String _generateDescription({
    required bool success,
    required HighlightEvent event,
    required CommandType command,
    required bool isGoal,
    required bool isAssist,
    required bool isYellowCard,
  }) {
    if (isGoal) {
      return _goalDescriptions[_random.nextInt(_goalDescriptions.length)];
    }

    if (isAssist) {
      return _assistDescriptions[_random.nextInt(_assistDescriptions.length)];
    }

    if (isYellowCard) {
      return _yellowCardDescriptions[_random.nextInt(_yellowCardDescriptions.length)];
    }

    if (success) {
      return _successDescriptions[event.type]?[_random.nextInt(
              _successDescriptions[event.type]?.length ?? 1)] ??
          '좋은 플레이!';
    } else {
      return _failureDescriptions[event.type]?[_random.nextInt(
              _failureDescriptions[event.type]?.length ?? 1)] ??
          '아쉬운 장면...';
    }
  }

  static const _goalDescriptions = [
    '골! 멋진 마무리!',
    '골!!! 네트가 흔들린다!',
    '골! 침착한 마무리!',
    '골! 환상적인 슈팅!',
    '골! 골키퍼가 손도 못 댔다!',
  ];

  static const _assistDescriptions = [
    '완벽한 패스! 어시스트!',
    '결정적인 패스가 득점으로 이어졌다!',
    '환상적인 스루패스! 어시스트 기록!',
  ];

  static const _yellowCardDescriptions = [
    '거친 태클로 경고를 받았다.',
    '주심이 옐로카드를 꺼내든다!',
    '조심해야 한다. 경고 1장.',
  ];

  static const _successDescriptions = <HighlightType, List<String>>{
    HighlightType.runInBehind: [
      '수비 라인 뒤로 침투 성공!',
      '타이밍 좋게 빠져나갔다!',
      '오프사이드 라인을 뚫었다!',
    ],
    HighlightType.receiveAndTurn: [
      '등지고 받아 멋지게 턴!',
      '수비수를 등지고 몸을 틀었다!',
      '화려한 터닝으로 공간 창출!',
    ],
    HighlightType.pressing: [
      '날카로운 압박! 볼을 빼앗았다!',
      '전방 압박 성공! 찬스 창출!',
      '끈질긴 압박이 결실을 맺었다!',
    ],
    HighlightType.quickCounter: [
      '빠른 역습 전개!',
      '순식간에 상대 진영을 향해 질주!',
      '카운터 어택!',
    ],
    HighlightType.looseBall: [
      '세컨볼 경합 승리!',
      '순발력 있게 공을 잡았다!',
      '볼 경합에서 이겼다!',
    ],
  };

  static const _failureDescriptions = <HighlightType, List<String>>{
    HighlightType.oneOnOne: [
      '1대1 상황에서 놓쳤다...',
      '골키퍼에게 막혔다!',
      '결정적 찬스를 날렸다...',
    ],
    HighlightType.runInBehind: [
      '오프사이드!',
      '침투 타이밍을 놓쳤다.',
      '수비에 읽혔다.',
    ],
    HighlightType.pressing: [
      '압박이 뚫렸다.',
      '상대가 여유롭게 빠져나갔다.',
      '체력 소모만 했다.',
    ],
    HighlightType.edgeOfBoxShot: [
      '슛이 빗나갔다!',
      '골대를 벗어났다.',
      '힘없는 슈팅...',
    ],
  };
}
