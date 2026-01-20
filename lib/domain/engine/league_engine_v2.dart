/// 리그 엔진
///
/// 리그/순위표 관련 로직만 담당하는 순수 함수 엔진
/// - 순위표 업데이트
/// - AI 경기 시뮬레이션
/// - 라운드 진행
/// - 주간 액션 리셋
///
/// 🔑 중복 로직 통합: finishMatch, spectateMatch의 AI 시뮬 로직을 하나로

import 'dart:math';
import 'base_engine.dart';
import '../state/game_state.dart';
import '../action/game_action.dart';
import '../model/team.dart';
import 'league_simulator.dart';

/// 리그 엔진
class LeagueEngineV2 extends GameEngine<LeagueAction> {
  @override
  bool canHandle(GameAction action) => action is LeagueAction;

  @override
  GameState process(GameState state, LeagueAction action, int seed) {
    return switch (action) {
      UpdateStandings(:final result) => _updateStandings(state, result),
      SimulateAIMatches(:final round) => _simulateAIMatches(state, round, seed),
      AdvanceRound() => _advanceRound(state),
      ResetWeeklyActions() => _resetWeeklyActions(state),
      UpdateFixture(:final fixtureId, :final homeScore, :final awayScore) =>
          _updateFixture(state, fixtureId, homeScore, awayScore),
      RecordPCMatchResult() => state, // TODO: 구현 필요
    };
  }

  /// 픽스처 결과 업데이트 (강제)
  GameState _updateFixture(
    GameState state,
    String fixtureId,
    int homeScore,
    int awayScore,
  ) {
    final updatedFixtures = state.season.fixtures.map((f) {
      if (f.id == fixtureId) {
        return f.copyWith(
          isPlayed: true,
          homeScore: homeScore,
          awayScore: awayScore,
        );
      }
      return f;
    }).toList();

    return state.copyWith(
      season: state.season.copyWith(fixtures: updatedFixtures),
    );
  }

  /// 순위표 업데이트 (단일 경기)
  ///
  /// 순수 함수: 경기 결과를 받아 순위표만 업데이트
  GameState _updateStandings(GameState state, MatchResultData result) {
    final season = state.season;

    // 순위표 업데이트
    final updatedStandings = season.standings.map((row) {
      if (row.teamId == result.homeTeamId) {
        return _applyMatchResult(row, result.homeScore, result.awayScore, true);
      } else if (row.teamId == result.awayTeamId) {
        return _applyMatchResult(row, result.awayScore, result.homeScore, false);
      }
      return row;
    }).toList();

    return state.copyWith(
      season: season.copyWith(standings: updatedStandings),
    );
  }

  /// 경기 결과를 순위 행에 적용 (순수 함수)
  StandingRow _applyMatchResult(
    StandingRow row,
    int scored,
    int conceded,
    bool isHome,
  ) {
    final won = scored > conceded;
    final drawn = scored == conceded;
    final lost = scored < conceded;

    return row.copyWith(
      played: row.played + 1,
      won: row.won + (won ? 1 : 0),
      drawn: row.drawn + (drawn ? 1 : 0),
      lost: row.lost + (lost ? 1 : 0),
      goalsFor: row.goalsFor + scored,
      goalsAgainst: row.goalsAgainst + conceded,
    );
  }

  /// AI 경기 시뮬레이션 (해당 라운드의 모든 미완료 경기)
  ///
  /// 🔑 finishMatch, spectateMatch에서 중복되던 로직을 통합
  /// 🔑 개인 스탯(LeagueStats)도 함께 업데이트
  GameState _simulateAIMatches(GameState state, int round, int seed) {
    final random = Random(seed);
    final season = state.season;
    final pcTeamId = state.player.teamId;
    final simulator = LeagueSimulator(seed: seed);

    var updatedFixtures = [...season.fixtures];
    var updatedStandings = [...season.standings];
    var updatedLeagueStats = season.leagueStats;

    // 해당 라운드의 미완료 경기 처리
    for (var i = 0; i < updatedFixtures.length; i++) {
      final fixture = updatedFixtures[i];

      // 조건: 해당 라운드 + 미완료 + PC 팀 경기 아님
      final shouldSimulate = fixture.round == round &&
          !fixture.isPlayed &&
          fixture.homeTeamId != pcTeamId &&
          fixture.awayTeamId != pcTeamId;

      if (!shouldSimulate) continue;

      // 경기 시뮬레이션
      final homeScore = _simulateGoals(
        season.teams[fixture.homeTeamId],
        season.teams[fixture.awayTeamId],
        true,
        random,
      );
      final awayScore = _simulateGoals(
        season.teams[fixture.awayTeamId],
        season.teams[fixture.homeTeamId],
        false,
        random,
      );

      // 픽스처 업데이트
      updatedFixtures[i] = fixture.copyWith(
        isPlayed: true,
        homeScore: homeScore,
        awayScore: awayScore,
      );

      // 순위표 업데이트
      updatedStandings = updatedStandings.map((row) {
        if (row.teamId == fixture.homeTeamId) {
          return _applyMatchResult(row, homeScore, awayScore, true);
        } else if (row.teamId == fixture.awayTeamId) {
          return _applyMatchResult(row, awayScore, homeScore, false);
        }
        return row;
      }).toList();

      // 🔑 개인 스탯 업데이트 (득점자, 어시스트, 평점)
      if (updatedLeagueStats != null) {
        updatedLeagueStats = simulator.simulateMatch(
          stats: updatedLeagueStats,
          homeTeamId: fixture.homeTeamId,
          awayTeamId: fixture.awayTeamId,
          homeGoals: homeScore,
          awayGoals: awayScore,
        );
      }
    }

    return state.copyWith(
      season: season.copyWith(
        fixtures: updatedFixtures,
        standings: updatedStandings,
        leagueStats: updatedLeagueStats,
      ),
    );
  }

  /// 골 시뮬레이션 (팀 스탯 기반)
  int _simulateGoals(Team? team, Team? opponent, bool isHome, Random random) {
    if (team == null || opponent == null) {
      return random.nextInt(4); // 기본값
    }

    // 기본 기대골 = 공격력/40 (50 → 1.25, 75 → 1.875)
    double expectedGoals = team.attackRating / 40;

    // 상대 수비력 감소 (50 기준, 높을수록 감소)
    expectedGoals *= (100 - opponent.defenseRating) / 50;

    // 홈 어드밴티지
    if (isHome) expectedGoals *= 1.1;

    // 랜덤 요소 (±30%)
    expectedGoals *= 0.7 + random.nextDouble() * 0.6;

    // 0-4 범위로 제한
    return expectedGoals.round().clamp(0, 4);
  }

  /// 라운드 진행
  GameState _advanceRound(GameState state) {
    return state.copyWith(
      season: state.season.copyWith(
        currentRound: state.season.currentRound + 1,
      ),
    );
  }

  /// 주간 액션 리셋
  GameState _resetWeeklyActions(GameState state) {
    return state.copyWith(
      player: state.player.copyWith(weeklyActionsRemaining: 3),
    );
  }
}
