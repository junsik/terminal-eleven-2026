// 도메인 모델 유닛 테스트

import 'package:flutter_test/flutter_test.dart';
import 'package:mud_soccer_player/domain/model/models.dart';

void main() {
  group('PlayerCharacter', () {
    test('create() should generate player with valid stats', () {
      final player = PlayerCharacter.create(
        id: 'test-id',
        name: '테스트선수',
        archetype: PlayerArchetype.poacher,
        teamId: 'team_1',
      );

      expect(player.profile.name, '테스트선수');
      expect(player.profile.archetype, PlayerArchetype.poacher);
      expect(player.stats.shooting, greaterThanOrEqualTo(0));
      expect(player.stats.shooting, lessThanOrEqualTo(100));
      expect(player.career.level, 1);
      expect(player.career.trust, 30); // Default trust value
    });

    test('different archetypes should have valid stats', () {
      final poacher = PlayerCharacter.create(
        id: '1',
        name: 'Poacher',
        archetype: PlayerArchetype.poacher,
        teamId: 'team_1',
      );

      final speedster = PlayerCharacter.create(
        id: '2',
        name: 'Speedster',
        archetype: PlayerArchetype.speedster,
        teamId: 'team_1',
      );

      // All stats should be in valid range 0-100
      expect(poacher.stats.shooting, inInclusiveRange(0, 100));
      expect(speedster.stats.pace, inInclusiveRange(0, 100));
    });
  });

  group('PlayerStatus', () {
    test('default values should be correct', () {
      const status = PlayerStatus();

      expect(status.fatigue, 0);
      expect(status.confidence, 0);
      expect(status.injury, InjuryStatus.none);
      expect(status.form, FormTrend.average);
    });

    test('copyWith should update values correctly', () {
      const status = PlayerStatus();
      final updated = status.copyWith(fatigue: 50, confidence: 2);

      expect(updated.fatigue, 50);
      expect(updated.confidence, 2);
      expect(updated.injury, InjuryStatus.none);
    });
  });

  group('StandingRow', () {
    test('points calculation should be correct', () {
      const row = StandingRow(
        teamId: 'team_1',
        teamName: 'Test FC',
        played: 10,
        won: 6,
        drawn: 2,
        lost: 2,
        goalsFor: 20,
        goalsAgainst: 10,
      );

      expect(row.points, 20); // 6*3 + 2*1 = 20
      expect(row.goalDifference, 10); // 20 - 10
    });
  });

  group('LeagueData', () {
    test('createDefaultTeams should create 10 teams', () {
      final teams = LeagueData.createDefaultTeams();
      expect(teams.length, 10);
    });

    test('createFixtures should create 18 rounds', () {
      final teams = LeagueData.createDefaultTeams();
      final fixtures = LeagueData.createFixtures(teams);
      
      // 10팀 더블 라운드 로빈 = 90경기
      expect(fixtures.length, 90);
    });

    test('standings should be sorted by points', () {
      final standings = [
        const StandingRow(teamId: '1', teamName: 'A', played: 1, won: 0, drawn: 1, lost: 0, goalsFor: 1, goalsAgainst: 1),
        const StandingRow(teamId: '2', teamName: 'B', played: 1, won: 1, drawn: 0, lost: 0, goalsFor: 2, goalsAgainst: 0),
        const StandingRow(teamId: '3', teamName: 'C', played: 1, won: 0, drawn: 0, lost: 1, goalsFor: 0, goalsAgainst: 2),
      ];

      standings.sort((a, b) {
        if (a.points != b.points) return b.points.compareTo(a.points);
        return b.goalDifference.compareTo(a.goalDifference);
      });

      expect(standings[0].teamName, 'B'); // 3 points
      expect(standings[1].teamName, 'A'); // 1 point
      expect(standings[2].teamName, 'C'); // 0 points
    });
  });

  group('Command', () {
    test('CommandType displayName should be in Korean', () {
      expect(CommandType.shoot.displayName, '슈팅');
      expect(CommandType.pass.displayName, '패스');
      expect(CommandType.dribble.displayName, '드리블');
    });

    test('isOffensive should correctly identify offensive commands', () {
      expect(CommandType.shoot.isOffensive, true);
      expect(CommandType.pass.isOffensive, true);
      expect(CommandType.press.isOffensive, false);
    });
  });

  group('TrainingType', () {
    test('displayName should be in Korean', () {
      expect(TrainingType.shooting.displayName, '슈팅 훈련');
      expect(TrainingType.rest.displayName, '휴식');
    });

    test('isRest should correctly identify rest types', () {
      expect(TrainingType.rest.isRest, true);
      expect(TrainingType.rehab.isRest, true);
      expect(TrainingType.shooting.isRest, false);
    });
  });

  group('RatingAccumulator', () {
    test('finalRating should start at 6.0', () {
      const acc = RatingAccumulator();
      expect(acc.finalRating, closeTo(6.0, 0.1));
    });

    test('goals should increase rating', () {
      const acc = RatingAccumulator(goals: 1);
      expect(acc.finalRating, greaterThan(6.0));
    });

    test('multiple stats should combine correctly', () {
      const acc = RatingAccumulator(
        goals: 2,
        assists: 1,
        shotsOnTarget: 3,
      );
      expect(acc.finalRating, greaterThan(7.0));
    });
  });

  group('GameSnapshot', () {
    test('canTakeAction should respect weeklyActionsRemaining', () {
      final pc = PlayerCharacter.create(
        id: 'test',
        name: 'Test',
        archetype: PlayerArchetype.poacher,
        teamId: 'team_1',
      );

      final teams = LeagueData.createDefaultTeams();
      final season = Season(
        id: 'season1',
        year: 2024,
        teams: {for (final t in teams) t.id: t},
        fixtures: LeagueData.createFixtures(teams),
        standings: LeagueData.createInitialStandings(teams),
      );

      final snapshot = GameSnapshot(
        savedAt: DateTime.now(),
        pc: pc,
        season: season,
        weeklyActionsRemaining: 3,
      );

      expect(snapshot.canTakeAction, true);

      final noActions = snapshot.copyWith(weeklyActionsRemaining: 0);
      expect(noActions.canTakeAction, false);
    });
  });
}
