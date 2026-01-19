// 리그 시뮬레이션 엔진
// AI 경기 결과 및 선수 스탯 시뮬레이션

import 'dart:math';
import '../model/models.dart';

/// 리그 시뮬레이터
class LeagueSimulator {
  final Random _random;

  LeagueSimulator({int? seed}) : _random = Random(seed);

  /// 시즌 시작 시 AI 선수 생성
  LeagueStats initializeLeague(List<Team> teams, String pcId, String pcTeamId) {
    final players = <VirtualPlayer>[];
    var nameIndex = 0;

    for (final team in teams) {
      // 팀당 3명의 AI 공격수 생성 (PC 팀 제외하고 생성)
      for (var i = 0; i < 3; i++) {
        if (team.id == pcTeamId && i == 0) {
          continue; // PC가 있는 팀은 2명만 생성
        }
        
        final name = kKoreanPlayerNames[nameIndex % kKoreanPlayerNames.length];
        nameIndex++;
        
        players.add(VirtualPlayer(
          id: '${team.id}_player_$i',
          name: name,
          teamId: team.id,
        ));
      }
    }

    return LeagueStats(players: players);
  }

  /// AI 경기 시뮬레이션 (득점자, 어시스트 선정)
  LeagueStats simulateMatch({
    required LeagueStats stats,
    required String homeTeamId,
    required String awayTeamId,
    required int homeGoals,
    required int awayGoals,
  }) {
    var updatedPlayers = [...stats.players];

    // 홈팀 득점자 선정
    _assignGoalsAndAssists(
      players: updatedPlayers,
      teamId: homeTeamId,
      goals: homeGoals,
    );

    // 원정팀 득점자 선정
    _assignGoalsAndAssists(
      players: updatedPlayers,
      teamId: awayTeamId,
      goals: awayGoals,
    );

    // 모든 출전 선수 경기 수 증가 및 평점 부여
    updatedPlayers = updatedPlayers.map((p) {
      if (p.teamId == homeTeamId || p.teamId == awayTeamId) {
        final rating = 5.5 + _random.nextDouble() * 3.0; // 5.5 ~ 8.5
        return p.copyWith(
          matchesPlayed: p.matchesPlayed + 1,
          ratings: [...p.ratings, rating],
        );
      }
      return p;
    }).toList();

    return stats.copyWith(players: updatedPlayers);
  }

  /// 득점 및 어시스트 분배
  void _assignGoalsAndAssists({
    required List<VirtualPlayer> players,
    required String teamId,
    required int goals,
  }) {
    final teamPlayers = players.where((p) => p.teamId == teamId).toList();
    if (teamPlayers.isEmpty) return;

    for (var i = 0; i < goals; i++) {
      // 득점자 선정 (랜덤)
      final scorerIndex = _random.nextInt(teamPlayers.length);
      final scorer = teamPlayers[scorerIndex];
      
      // 득점자 업데이트
      final playerIndex = players.indexWhere((p) => p.id == scorer.id);
      if (playerIndex >= 0) {
        players[playerIndex] = players[playerIndex].copyWith(
          goals: players[playerIndex].goals + 1,
        );
      }

      // 어시스트 (70% 확률)
      if (_random.nextDouble() < 0.7 && teamPlayers.length > 1) {
        var assisterIndex = _random.nextInt(teamPlayers.length);
        // 득점자와 다른 선수
        while (assisterIndex == scorerIndex) {
          assisterIndex = _random.nextInt(teamPlayers.length);
        }
        final assister = teamPlayers[assisterIndex];
        
        final assisterPlayerIndex = players.indexWhere((p) => p.id == assister.id);
        if (assisterPlayerIndex >= 0) {
          players[assisterPlayerIndex] = players[assisterPlayerIndex].copyWith(
            assists: players[assisterPlayerIndex].assists + 1,
          );
        }
      }
    }
  }

  /// PC 스탯을 리그에 추가/업데이트
  LeagueStats updatePCStats({
    required LeagueStats stats,
    required String pcId,
    required String pcName,
    required String pcTeamId,
    required int goals,
    required int assists,
    required int matchesPlayed,
    required List<double> ratings,
  }) {
    final updatedPlayers = [...stats.players];
    
    // PC 찾기
    final pcIndex = updatedPlayers.indexWhere((p) => p.id == pcId);
    
    final pcPlayer = VirtualPlayer(
      id: pcId,
      name: pcName,
      teamId: pcTeamId,
      goals: goals,
      assists: assists,
      matchesPlayed: matchesPlayed,
      ratings: ratings,
    );

    if (pcIndex >= 0) {
      updatedPlayers[pcIndex] = pcPlayer;
    } else {
      updatedPlayers.add(pcPlayer);
    }

    return stats.copyWith(players: updatedPlayers);
  }
}
