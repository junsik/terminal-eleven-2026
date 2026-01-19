// 경기 엔진 - 하이라이트 생성기

import 'dart:math';
import '../model/models.dart';

/// 하이라이트 생성기
class HighlightGenerator {
  final Random _random;

  HighlightGenerator({int? seed}) : _random = Random(seed);

  /// 경기 시작 시 하이라이트 목록 생성
  List<HighlightEvent> generateHighlights({
    required int trust,
    required int opponentDefenseRating,
    required ScoreContext initialContext,
  }) {
    // 신뢰도에 따른 하이라이트 수 결정
    final baseCount = _getHighlightCount(trust);
    final highlights = <HighlightEvent>[];

    // 시간대별 분포
    final distribution = _getTimeDistribution(baseCount);

    var currentMinute = 0;
    for (var i = 0; i < distribution.length; i++) {
      final (startMin, endMin, count) = distribution[i];

      for (var j = 0; j < count; j++) {
        // 시간대 내 랜덤 분
        currentMinute = startMin + _random.nextInt(endMin - startMin);
        if (currentMinute <= 0) currentMinute = 1;

        // 이벤트 타입 결정
        final eventType = _selectEventType(
          minute: currentMinute,
          opponentDefenseRating: opponentDefenseRating,
          scoreContext: initialContext,
        );

        // 선택지 생성
        final choices = _getChoicesForEvent(eventType);

        highlights.add(HighlightEvent(
          minute: currentMinute,
          type: eventType,
          zone: _getZoneForEvent(eventType),
          pressure: _random.nextInt(4),
          scoreContext: initialContext,
          choices: choices,
        ));
      }
    }

    // 페널티킥: 낮은 확률로 발생 (5%)
    if (_random.nextDouble() < 0.05) {
      final pkMinute = 30 + _random.nextInt(60);
      highlights.add(HighlightEvent(
        minute: pkMinute,
        type: HighlightType.penaltyKick,
        zone: FieldZone.box,
        pressure: 3,
        scoreContext: initialContext,
        choices: ['shoot'],
      ));
    }

    // 클러치 찬스: 마지막에 지고 있을 때 추가
    if (initialContext == ScoreContext.trailing || _random.nextDouble() < 0.3) {
      highlights.add(HighlightEvent(
        minute: 88 + _random.nextInt(5), // 88-92분
        type: HighlightType.clutchChance,
        zone: FieldZone.box,
        pressure: 3,
        scoreContext: ScoreContext.trailing,
        choices: ['shoot', 'dribble', 'pass'],
      ));
    }

    // 시간순 정렬
    highlights.sort((a, b) => a.minute.compareTo(b.minute));

    return highlights;
  }

  /// 신뢰도에 따른 하이라이트 수
  int _getHighlightCount(int trust) {
    if (trust <= 35) {
      return 8 + _random.nextInt(3); // 8-10
    } else if (trust <= 70) {
      return 10 + _random.nextInt(3); // 10-12
    } else {
      return 12 + _random.nextInt(3); // 12-14
    }
  }

  /// 시간대별 분포 (시작분, 종료분, 하이라이트수)
  List<(int, int, int)> _getTimeDistribution(int totalCount) {
    // 전반 초반, 전반 후반, 후반 초반, 후반 후반
    final ratio = [0.15, 0.25, 0.35, 0.25];
    final timeRanges = [
      (1, 15),
      (16, 45),
      (46, 75),
      (76, 90),
    ];

    final distribution = <(int, int, int)>[];
    var remaining = totalCount;

    for (var i = 0; i < ratio.length; i++) {
      final count = i == ratio.length - 1
          ? remaining
          : (totalCount * ratio[i]).round();
      remaining -= count;
      distribution.add((timeRanges[i].$1, timeRanges[i].$2, count));
    }

    return distribution;
  }

  /// 이벤트 타입 선택
  HighlightType _selectEventType({
    required int minute,
    required int opponentDefenseRating,
    required ScoreContext scoreContext,
  }) {
    // 상대 수비가 강하면 공격 이벤트 비율 감소
    final defenseModifier = (opponentDefenseRating - 50) / 100;
    
    // 지고 있고 후반이면 공격 이벤트 증가
    final isTrailingLate = scoreContext == ScoreContext.trailing && minute > 60;
    final urgencyBonus = isTrailingLate ? 0.05 : 0.0;

    // 가중치 맵
    final weights = <HighlightType, double>{
      HighlightType.runInBehind: 0.12 - defenseModifier * 0.05 + urgencyBonus,
      HighlightType.receiveAndTurn: 0.10,
      HighlightType.oneOnOne: 0.08 - defenseModifier * 0.03 + urgencyBonus,
      HighlightType.edgeOfBoxShot: 0.12 + urgencyBonus,
      HighlightType.quickCounter: 0.10,
      HighlightType.pressing: 0.12 + defenseModifier * 0.05,
      HighlightType.defensiveCover: 0.08,
      HighlightType.looseBall: 0.10,
      HighlightType.setPieceRebound: 0.06,
      HighlightType.fatigueMoment: minute > 60 ? 0.08 : 0.02,
      HighlightType.mentalPressure: 0.04,
    };

    // 가중치 기반 랜덤 선택
    final total = weights.values.reduce((a, b) => a + b);
    var roll = _random.nextDouble() * total;

    for (final entry in weights.entries) {
      roll -= entry.value;
      if (roll <= 0) return entry.key;
    }

    return HighlightType.looseBall;
  }

  /// 이벤트별 선택지 생성
  List<String> _getChoicesForEvent(HighlightType type) {
    switch (type) {
      case HighlightType.runInBehind:
        return ['callForBall', 'safePlay', 'dribble'];
      case HighlightType.receiveAndTurn:
        return ['dribble', 'pass', 'safePlay'];
      case HighlightType.oneOnOne:
        return ['shoot', 'dribble', 'pass'];
      case HighlightType.edgeOfBoxShot:
        return ['shoot', 'pass', 'safePlay'];
      case HighlightType.quickCounter:
        return ['dribble', 'pass', 'safePlay'];
      case HighlightType.pressing:
        return ['press', 'contain', 'tackle'];
      case HighlightType.defensiveCover:
        return ['fallBack', 'contain'];
      case HighlightType.looseBall:
        return ['tackle', 'dribble', 'safePlay'];
      case HighlightType.setPieceRebound:
        return ['shoot', 'pass', 'safePlay'];
      case HighlightType.fatigueMoment:
        return ['safePlay', 'forcePlay'];
      case HighlightType.mentalPressure:
        return ['compose', 'callForBall', 'safePlay'];
      case HighlightType.coachFeedback:
        return ['accept', 'askRole', 'ignore'];
      case HighlightType.penaltyKick:
        return ['shoot'];
      case HighlightType.clutchChance:
        return ['shoot', 'dribble', 'pass'];
    }
  }

  /// 이벤트별 필드 구역
  FieldZone _getZoneForEvent(HighlightType type) {
    switch (type) {
      case HighlightType.oneOnOne:
      case HighlightType.setPieceRebound:
      case HighlightType.penaltyKick:
      case HighlightType.clutchChance:
        return FieldZone.box;
      case HighlightType.runInBehind:
      case HighlightType.edgeOfBoxShot:
        return FieldZone.att;
      case HighlightType.quickCounter:
      case HighlightType.receiveAndTurn:
      case HighlightType.looseBall:
      case HighlightType.pressing:
        return FieldZone.mid;
      case HighlightType.defensiveCover:
        return FieldZone.def;
      default:
        return FieldZone.mid;
    }
  }
}
