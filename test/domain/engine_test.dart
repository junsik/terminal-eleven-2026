// 경기 엔진 유닛 테스트

import 'package:flutter_test/flutter_test.dart';
import 'package:mud_soccer_player/domain/model/models.dart';
import 'package:mud_soccer_player/domain/engine/engine.dart';

void main() {
  group('HighlightGenerator', () {
    test('should generate highlights with consistent seed', () {
      final gen1 = HighlightGenerator(seed: 12345);
      final gen2 = HighlightGenerator(seed: 12345);

      final h1 = gen1.generateHighlights(
        trust: 50,
        opponentDefenseRating: 50,
        initialContext: ScoreContext.draw,
      );

      final h2 = gen2.generateHighlights(
        trust: 50,
        opponentDefenseRating: 50,
        initialContext: ScoreContext.draw,
      );

      expect(h1.length, h2.length);
      for (int i = 0; i < h1.length; i++) {
        expect(h1[i].type, h2[i].type);
        expect(h1[i].minute, h2[i].minute);
      }
    });

    test('higher trust should generate more highlights', () {
      final genLow = HighlightGenerator(seed: 100);
      final genHigh = HighlightGenerator(seed: 100);

      final lowTrust = genLow.generateHighlights(
        trust: 20,
        opponentDefenseRating: 50,
        initialContext: ScoreContext.draw,
      );

      final highTrust = genHigh.generateHighlights(
        trust: 90,
        opponentDefenseRating: 50,
        initialContext: ScoreContext.draw,
      );

      expect(highTrust.length, greaterThanOrEqualTo(lowTrust.length));
    });

    test('highlights should be sorted by minute', () {
      final gen = HighlightGenerator(seed: 999);
      final highlights = gen.generateHighlights(
        trust: 50,
        opponentDefenseRating: 50,
        initialContext: ScoreContext.draw,
      );

      for (int i = 1; i < highlights.length; i++) {
        expect(highlights[i].minute, greaterThanOrEqualTo(highlights[i - 1].minute));
      }
    });

    test('highlights should have valid choices', () {
      final gen = HighlightGenerator(seed: 777);
      final highlights = gen.generateHighlights(
        trust: 50,
        opponentDefenseRating: 50,
        initialContext: ScoreContext.draw,
      );

      for (final h in highlights) {
        expect(h.choices.isNotEmpty, true);
        expect(h.choices.length, lessThanOrEqualTo(4));
      }
    });
  });

  group('HighlightResolver', () {
    late HighlightResolver resolver;
    late PlayerStats stats;
    late PlayerStatus status;

    setUp(() {
      resolver = HighlightResolver(seed: 42);
      stats = const PlayerStats(
        pace: 60,
        shooting: 70,
        passing: 65,
        ballControl: 60,
        positioning: 55,
        stamina: 70,
        composure: 60,
      );
      status = const PlayerStatus();
    });

    test('resolve should return consistent results with same seed', () {
      final r1 = HighlightResolver(seed: 42);
      final r2 = HighlightResolver(seed: 42);

      const event = HighlightEvent(
        minute: 30,
        type: HighlightType.oneOnOne,
        zone: FieldZone.box,
        scoreContext: ScoreContext.draw,
        choices: ['shoot', 'dribble', 'pass'],
      );

      final result1 = r1.resolve(
        event: event,
        command: CommandType.shoot,
        stats: stats,
        status: status,
        opponentRating: 50,
      );

      final result2 = r2.resolve(
        event: event,
        command: CommandType.shoot,
        stats: stats,
        status: status,
        opponentRating: 50,
      );

      expect(result1.success, result2.success);
      expect(result1.isGoal, result2.isGoal);
    });

    test('fatigue should decrease success probability', () {
      int successWithLowFatigue = 0;
      int successWithHighFatigue = 0;

      const event = HighlightEvent(
        minute: 80,
        type: HighlightType.edgeOfBoxShot,
        zone: FieldZone.att,
        scoreContext: ScoreContext.draw,
        choices: ['shoot', 'pass'],
      );

      for (int i = 0; i < 100; i++) {
        final r1 = HighlightResolver(seed: i);
        final r2 = HighlightResolver(seed: i);

        final lowFatigue = r1.resolve(
          event: event,
          command: CommandType.shoot,
          stats: stats,
          status: const PlayerStatus(fatigue: 10),
          opponentRating: 50,
        );

        final highFatigue = r2.resolve(
          event: event,
          command: CommandType.shoot,
          stats: stats,
          status: const PlayerStatus(fatigue: 90),
          opponentRating: 50,
        );

        if (lowFatigue.success) successWithLowFatigue++;
        if (highFatigue.success) successWithHighFatigue++;
      }

      expect(successWithLowFatigue, greaterThan(successWithHighFatigue));
    });

    test('result should have valid description', () {
      const event = HighlightEvent(
        minute: 45,
        type: HighlightType.pressing,
        zone: FieldZone.mid,
        scoreContext: ScoreContext.draw,
        choices: ['press', 'contain'],
      );

      final result = resolver.resolve(
        event: event,
        command: CommandType.press,
        stats: stats,
        status: status,
        opponentRating: 50,
      );

      expect(result.description, isNotEmpty);
    });
  });

}
