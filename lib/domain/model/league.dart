// 도메인 모델 - 리그 스탯

import 'package:freezed_annotation/freezed_annotation.dart';

part 'league.freezed.dart';
part 'league.g.dart';

/// AI 선수 (가상 선수)
@freezed
class VirtualPlayer with _$VirtualPlayer {
  const factory VirtualPlayer({
    required String id,
    required String name,
    required String teamId,
    @Default(0) int goals,
    @Default(0) int assists,
    @Default(0) int matchesPlayed,
    @Default([]) List<double> ratings, // 경기별 평점
  }) = _VirtualPlayer;

  factory VirtualPlayer.fromJson(Map<String, dynamic> json) =>
      _$VirtualPlayerFromJson(json);
}

/// 가상 선수 확장
extension VirtualPlayerX on VirtualPlayer {
  /// 평균 평점
  double get avgRating {
    if (ratings.isEmpty) return 0.0;
    return ratings.reduce((a, b) => a + b) / ratings.length;
  }
}

/// 리그 통계
@freezed
class LeagueStats with _$LeagueStats {
  const factory LeagueStats({
    @Default([]) List<VirtualPlayer> players, // 모든 AI 선수
  }) = _LeagueStats;

  factory LeagueStats.fromJson(Map<String, dynamic> json) =>
      _$LeagueStatsFromJson(json);
}

/// 리그 통계 확장
extension LeagueStatsX on LeagueStats {
  /// 득점 순위 (상위 N명)
  List<VirtualPlayer> goalRanking([int top = 10]) {
    final sorted = [...players]..sort((a, b) => b.goals.compareTo(a.goals));
    return sorted.take(top).toList();
  }

  /// 도움 순위 (상위 N명)
  List<VirtualPlayer> assistRanking([int top = 10]) {
    final sorted = [...players]..sort((a, b) => b.assists.compareTo(a.assists));
    return sorted.take(top).toList();
  }

  /// 평점 순위 (상위 N명, 최소 3경기 출전)
  List<VirtualPlayer> ratingRanking([int top = 10]) {
    final qualified = players.where((p) => p.matchesPlayed >= 3).toList();
    qualified.sort((a, b) => b.avgRating.compareTo(a.avgRating));
    return qualified.take(top).toList();
  }

  /// PC 득점 순위 찾기
  int findGoalRank(String playerId) {
    final sorted = [...players]..sort((a, b) => b.goals.compareTo(a.goals));
    for (var i = 0; i < sorted.length; i++) {
      if (sorted[i].id == playerId) return i + 1;
    }
    return -1;
  }

  /// PC 도움 순위 찾기
  int findAssistRank(String playerId) {
    final sorted = [...players]..sort((a, b) => b.assists.compareTo(a.assists));
    for (var i = 0; i < sorted.length; i++) {
      if (sorted[i].id == playerId) return i + 1;
    }
    return -1;
  }
}

/// 한국 축구선수 이름 생성용
const kKoreanPlayerNames = [
  '김민수', '이준호', '박성진', '정우진', '최영훈',
  '강동혁', '윤재민', '임태현', '한승우', '오지훈',
  '서준영', '조민기', '신동현', '송현우', '유승호',
  '장현석', '권진우', '황민재', '안정환', '배기성',
  '문선민', '홍철', '김승대', '이동국', '박주영',
  '기성용', '손흥민', '황희찬', '이강인', '김민재',
  '조현우', '김승규', '정우영', '황인범', '이재성',
  '권창훈', '나상호', '조규성', '송민규', '이영재',
];
