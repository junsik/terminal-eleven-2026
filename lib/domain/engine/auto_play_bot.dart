// AutoPlay Bot - 밸런스 검증용 자동 플레이어

import 'dart:math';
import '../model/models.dart';
import 'engine.dart';

/// 자동 플레이 정책
enum AutoPlayPolicy {
  /// 안전 우선: SAFE_PLAY 선호, 찬스에서만 공격
  safe,

  /// 공격적: SHOOT/DRIBBLE 선호
  aggressive,

  /// 균형: 상황에 따라 선택
  balanced,
}

/// 시뮬레이션 결과
class SimulationResult {
  final int totalMatches;
  final int totalGoals;
  final int totalAssists;
  final double averageRating;
  final int injuries;
  final int yellowCards;
  final int redCards;
  final List<double> ratingDistribution;
  final Map<int, int> goalsPerMatch; // 경기당 골 분포

  const SimulationResult({
    required this.totalMatches,
    required this.totalGoals,
    required this.totalAssists,
    required this.averageRating,
    required this.injuries,
    required this.yellowCards,
    required this.redCards,
    required this.ratingDistribution,
    required this.goalsPerMatch,
  });

  double get goalsPerMatch_ => totalGoals / totalMatches;
  double get assistsPerMatch => totalAssists / totalMatches;

  @override
  String toString() {
    return '''
=== 시뮬레이션 결과 ($totalMatches 경기) ===
평균 평점: ${averageRating.toStringAsFixed(2)}
경기당 골: ${goalsPerMatch_.toStringAsFixed(2)}
경기당 어시: ${assistsPerMatch.toStringAsFixed(2)}
총 골: $totalGoals
총 어시: $totalAssists
부상: $injuries
경고: $yellowCards
퇴장: $redCards
===================================
''';
  }
}

/// 자동 플레이 봇
class AutoPlayBot {
  final AutoPlayPolicy policy;
  final Random _random;

  AutoPlayBot({
    this.policy = AutoPlayPolicy.balanced,
    int? seed,
  }) : _random = Random(seed);

  /// 하이라이트에서 커맨드 선택
  CommandType selectCommand(HighlightEvent event, PlayerStatus status) {
    final choices = event.choices;
    if (choices.isEmpty) return CommandType.safePlay;

    switch (policy) {
      case AutoPlayPolicy.safe:
        return _selectSafe(choices, event.type);
      case AutoPlayPolicy.aggressive:
        return _selectAggressive(choices, event.type);
      case AutoPlayPolicy.balanced:
        return _selectBalanced(choices, event.type, status);
    }
  }

  CommandType _selectSafe(List<String> choices, HighlightType type) {
    // SAFE_PLAY 우선
    if (choices.contains('safePlay')) {
      return CommandType.safePlay;
    }
    // 다음으로 PASS 선호
    if (choices.contains('pass')) {
      return CommandType.pass;
    }
    // 그 외 첫 번째 선택
    return commandTypeFromString(choices.first) ?? CommandType.safePlay;
  }

  CommandType _selectAggressive(List<String> choices, HighlightType type) {
    // 득점 가능 상황에서 SHOOT 우선
    if (type == HighlightType.oneOnOne ||
        type == HighlightType.edgeOfBoxShot ||
        type == HighlightType.setPieceRebound) {
      if (choices.contains('shoot')) {
        return CommandType.shoot;
      }
    }
    // DRIBBLE 선호
    if (choices.contains('dribble')) {
      return CommandType.dribble;
    }
    return commandTypeFromString(choices.first) ?? CommandType.shoot;
  }

  CommandType _selectBalanced(
    List<String> choices,
    HighlightType type,
    PlayerStatus status,
  ) {
    // 피로도 높으면 안전하게
    if (status.fatigue > 70) {
      return _selectSafe(choices, type);
    }

    // 득점 찬스에서는 공격적으로
    if (type == HighlightType.oneOnOne ||
        type == HighlightType.edgeOfBoxShot) {
      if (choices.contains('shoot')) {
        return CommandType.shoot;
      }
    }

    // 역습 상황에서는 패스
    if (type == HighlightType.quickCounter) {
      if (choices.contains('pass')) {
        return CommandType.pass;
      }
    }

    // 압박 상황에서는 상황에 따라
    if (type == HighlightType.pressing) {
      if (status.fatigue < 50 && choices.contains('press')) {
        return CommandType.press;
      }
      if (choices.contains('contain')) {
        return CommandType.contain;
      }
    }

    // 코치 피드백은 수용
    if (type == HighlightType.coachFeedback) {
      if (choices.contains('accept')) {
        return CommandType.accept;
      }
    }

    // 기본: 랜덤 선택
    final idx = _random.nextInt(choices.length);
    return commandTypeFromString(choices[idx]) ?? CommandType.safePlay;
  }

  /// N 경기 시뮬레이션 실행
  SimulationResult simulate({
    required int matchCount,
    required PlayerStats initialStats,
    int opponentRating = 50,
  }) {
    int totalGoals = 0;
    int totalAssists = 0;
    int injuries = 0;
    int yellowCards = 0;
    int redCards = 0;
    final ratings = <double>[];
    final goalsPerMatch = <int, int>{};

    for (int i = 0; i < matchCount; i++) {
      final result = _simulateOneMatch(
        stats: initialStats,
        opponentRating: opponentRating,
      );

      totalGoals += result.goals;
      totalAssists += result.assists;
      if (result.injury) injuries++;
      yellowCards += result.yellowCards;
      if (result.redCard) redCards++;
      ratings.add(result.rating);

      // 골 분포 기록
      goalsPerMatch[result.goals] = (goalsPerMatch[result.goals] ?? 0) + 1;
    }

    final avgRating = ratings.reduce((a, b) => a + b) / ratings.length;

    return SimulationResult(
      totalMatches: matchCount,
      totalGoals: totalGoals,
      totalAssists: totalAssists,
      averageRating: avgRating,
      injuries: injuries,
      yellowCards: yellowCards,
      redCards: redCards,
      ratingDistribution: ratings,
      goalsPerMatch: goalsPerMatch,
    );
  }

  _MatchResult _simulateOneMatch({
    required PlayerStats stats,
    required int opponentRating,
  }) {
    final seed = _random.nextInt(1000000);
    final generator = HighlightGenerator(seed: seed);
    final resolver = HighlightResolver(seed: seed);

    var status = const PlayerStatus();
    var accumulator = const RatingAccumulator();

    // 하이라이트 생성
    final highlights = generator.generateHighlights(
      trust: 50,
      opponentDefenseRating: opponentRating,
      initialContext: ScoreContext.draw,
    );

    int goals = 0;
    int assists = 0;
    bool injury = false;
    int yellows = 0;
    bool redCard = false;

    // 각 하이라이트 처리
    for (final highlight in highlights) {
      final command = selectCommand(highlight, status);

      final result = resolver.resolve(
        event: highlight,
        command: command,
        stats: stats,
        status: status,
        opponentRating: opponentRating,
      );

      // 결과 누적
      if (result.isGoal) {
        goals++;
        accumulator = accumulator.copyWith(goals: accumulator.goals + 1);
      }
      if (result.isAssist) {
        assists++;
        accumulator = accumulator.copyWith(assists: accumulator.assists + 1);
      }
      if (result.isYellowCard) {
        yellows++;
        accumulator = accumulator.copyWith(yellowCards: accumulator.yellowCards + 1);
        if (yellows >= 2) redCard = true;
      }
      if (result.isInjury) {
        injury = true;
      }

      // 상태 업데이트
      status = status.copyWith(
        fatigue: (status.fatigue + result.fatigueChange).clamp(0, 100),
        confidence: (status.confidence + result.confidenceChange).clamp(-3, 3),
      );

      // 기타 누적
      if (result.success) {
        if (command == CommandType.shoot) {
          accumulator = accumulator.copyWith(
              shotsOnTarget: accumulator.shotsOnTarget + 1);
        }
        if (command == CommandType.pass) {
          accumulator = accumulator.copyWith(
              keyPasses: accumulator.keyPasses + 1);
        }
      } else {
        if (highlight.type == HighlightType.oneOnOne) {
          accumulator = accumulator.copyWith(
              chanceMissed: accumulator.chanceMissed + 1);
        }
      }
    }

    return _MatchResult(
      goals: goals,
      assists: assists,
      injury: injury,
      yellowCards: yellows,
      redCard: redCard,
      rating: accumulator.finalRating,
    );
  }
}

class _MatchResult {
  final int goals;
  final int assists;
  final bool injury;
  final int yellowCards;
  final bool redCard;
  final double rating;

  _MatchResult({
    required this.goals,
    required this.assists,
    required this.injury,
    required this.yellowCards,
    required this.redCard,
    required this.rating,
  });
}
