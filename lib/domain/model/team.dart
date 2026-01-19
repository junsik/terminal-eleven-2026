// 도메인 모델 - 팀 및 시즌 관련

import 'package:freezed_annotation/freezed_annotation.dart';

part 'team.freezed.dart';
part 'team.g.dart';

/// 팀 정보
@freezed
class Team with _$Team {
  const factory Team({
    required String id,
    required String name,
    @Default(50) int attackRating, // 공격력 (30-90)
    @Default(50) int defenseRating, // 수비력 (30-90)
    @Default(50) int overallRating, // 종합 레이팅
  }) = _Team;

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);
}

/// 리그 순위표 행
@freezed
class StandingRow with _$StandingRow {
  const factory StandingRow({
    required String teamId,
    required String teamName,
    @Default(0) int played, // 경기 수
    @Default(0) int won, // 승
    @Default(0) int drawn, // 무
    @Default(0) int lost, // 패
    @Default(0) int goalsFor, // 득점
    @Default(0) int goalsAgainst, // 실점
  }) = _StandingRow;

  factory StandingRow.fromJson(Map<String, dynamic> json) =>
      _$StandingRowFromJson(json);
}

/// 확장 메서드
extension StandingRowX on StandingRow {
  /// 승점
  int get points => won * 3 + drawn;

  /// 골득실
  int get goalDifference => goalsFor - goalsAgainst;
}

/// 경기 일정
@freezed
class Fixture with _$Fixture {
  const factory Fixture({
    required String id,
    required int round, // 라운드 번호 (1-18)
    required String homeTeamId,
    required String awayTeamId,
    @Default(false) bool isPlayed, // 경기 완료 여부
    int? homeScore,
    int? awayScore,
  }) = _Fixture;

  factory Fixture.fromJson(Map<String, dynamic> json) =>
      _$FixtureFromJson(json);
}

/// 시즌 정보
@freezed
class Season with _$Season {
  const factory Season({
    required String id,
    required int year, // 시즌 연도
    @Default(1) int currentRound, // 현재 라운드
    required Map<String, Team> teams, // 팀 맵
    required List<Fixture> fixtures, // 전체 경기 일정
    required List<StandingRow> standings, // 순위표
  }) = _Season;

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);
}

/// 시즌 확장 메서드
extension SeasonX on Season {
  /// 정렬된 순위표 반환 (승점 > 골득실 > 득점)
  List<StandingRow> get sortedStandings {
    final sorted = [...standings];
    sorted.sort((a, b) {
      // 1순위: 승점
      final pointsCompare = b.points.compareTo(a.points);
      if (pointsCompare != 0) return pointsCompare;

      // 2순위: 골득실
      final gdCompare = b.goalDifference.compareTo(a.goalDifference);
      if (gdCompare != 0) return gdCompare;

      // 3순위: 득점
      return b.goalsFor.compareTo(a.goalsFor);
    });
    return sorted;
  }

  /// 다음 경기 가져오기
  Fixture? getNextFixture(String teamId) {
    return fixtures.firstWhere(
      (f) =>
          !f.isPlayed &&
          (f.homeTeamId == teamId || f.awayTeamId == teamId),
      orElse: () => fixtures.first,
    );
  }

  /// 특정 라운드 경기 목록
  List<Fixture> getFixturesForRound(int round) {
    return fixtures.where((f) => f.round == round).toList();
  }
}

/// 기본 리그 데이터 생성
class LeagueData {
  /// 10팀 기본 리그 생성
  static List<Team> createDefaultTeams() {
    return [
      const Team(
        id: 'team_1',
        name: 'FC 서울',
        attackRating: 75,
        defenseRating: 70,
        overallRating: 73,
      ),
      const Team(
        id: 'team_2',
        name: '수원 블루윙즈',
        attackRating: 70,
        defenseRating: 72,
        overallRating: 71,
      ),
      const Team(
        id: 'team_3',
        name: '전북 현대',
        attackRating: 78,
        defenseRating: 75,
        overallRating: 77,
      ),
      const Team(
        id: 'team_4',
        name: '울산 현대',
        attackRating: 76,
        defenseRating: 74,
        overallRating: 75,
      ),
      const Team(
        id: 'team_5',
        name: '포항 스틸러스',
        attackRating: 68,
        defenseRating: 70,
        overallRating: 69,
      ),
      const Team(
        id: 'team_6',
        name: '대구 FC',
        attackRating: 65,
        defenseRating: 67,
        overallRating: 66,
      ),
      const Team(
        id: 'team_7',
        name: '인천 유나이티드',
        attackRating: 62,
        defenseRating: 65,
        overallRating: 64,
      ),
      const Team(
        id: 'team_8',
        name: '강원 FC',
        attackRating: 60,
        defenseRating: 62,
        overallRating: 61,
      ),
      const Team(
        id: 'team_9',
        name: '제주 유나이티드',
        attackRating: 64,
        defenseRating: 63,
        overallRating: 64,
      ),
      const Team(
        id: 'team_10',
        name: '광주 FC',
        attackRating: 58,
        defenseRating: 60,
        overallRating: 59,
      ),
    ];
  }

  /// 더블 라운드 로빈 일정 생성 (18라운드)
  static List<Fixture> createFixtures(List<Team> teams) {
    final fixtures = <Fixture>[];
    final teamIds = teams.map((t) => t.id).toList();
    var fixtureId = 0;

    // 첫 번째 라운드 (홈)
    for (var round = 1; round <= 9; round++) {
      for (var i = 0; i < teamIds.length ~/ 2; i++) {
        final home = teamIds[i];
        final away = teamIds[teamIds.length - 1 - i];
        fixtures.add(Fixture(
          id: 'fixture_${fixtureId++}',
          round: round,
          homeTeamId: home,
          awayTeamId: away,
        ));
      }
      // 팀 순환 (첫 번째 팀 고정)
      final last = teamIds.removeLast();
      teamIds.insert(1, last);
    }

    // 두 번째 라운드 (원정) - 홈/어웨이 반전
    final firstHalfFixtures = List<Fixture>.from(fixtures);
    for (final f in firstHalfFixtures) {
      fixtures.add(Fixture(
        id: 'fixture_${fixtureId++}',
        round: f.round + 9,
        homeTeamId: f.awayTeamId,
        awayTeamId: f.homeTeamId,
      ));
    }

    return fixtures;
  }

  /// 초기 순위표 생성
  static List<StandingRow> createInitialStandings(List<Team> teams) {
    return teams
        .map((t) => StandingRow(teamId: t.id, teamName: t.name))
        .toList();
  }
}
