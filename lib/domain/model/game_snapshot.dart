// 도메인 모델 - 게임 스냅샷 (저장용)

import 'package:freezed_annotation/freezed_annotation.dart';
import 'player.dart';
import 'team.dart';
import 'match.dart';
import 'league.dart';

part 'game_snapshot.freezed.dart';
part 'game_snapshot.g.dart';

/// 전역 게임 상태
enum GameState {
  @JsonValue('boot')
  boot, // 로드/세이브 선택
  @JsonValue('home')
  home, // 홈 화면
  @JsonValue('training')
  training, // 훈련 선택
  @JsonValue('preMatch')
  preMatch, // 경기 전
  @JsonValue('match')
  match, // 경기 중
  @JsonValue('postMatch')
  postMatch, // 경기 후
}

/// 훈련 타입
enum TrainingType {
  @JsonValue('shooting')
  shooting, // 슈팅 훈련
  @JsonValue('passing')
  passing, // 패스 훈련
  @JsonValue('dribbling')
  dribbling, // 드리블 훈련
  @JsonValue('positioning')
  positioning, // 위치 선정 훈련
  @JsonValue('stamina')
  stamina, // 체력 훈련
  @JsonValue('composure')
  composure, // 멘탈 훈련
  @JsonValue('rest')
  rest, // 휴식
  @JsonValue('rehab')
  rehab, // 재활
}

/// 훈련 타입 확장
extension TrainingTypeX on TrainingType {
  /// 한국어 이름
  String get displayName {
    switch (this) {
      case TrainingType.shooting:
        return '슈팅 훈련';
      case TrainingType.passing:
        return '패스 훈련';
      case TrainingType.dribbling:
        return '드리블 훈련';
      case TrainingType.positioning:
        return '위치 선정 훈련';
      case TrainingType.stamina:
        return '체력 훈련';
      case TrainingType.composure:
        return '멘탈 훈련';
      case TrainingType.rest:
        return '휴식';
      case TrainingType.rehab:
        return '재활';
    }
  }

  /// 훈련 설명
  String get description {
    switch (this) {
      case TrainingType.shooting:
        return '슈팅 능력 향상 (+1~2), 피로 +15';
      case TrainingType.passing:
        return '패스 능력 향상 (+1~2), 피로 +15';
      case TrainingType.dribbling:
        return '볼 컨트롤 향상 (+1~2), 피로 +15';
      case TrainingType.positioning:
        return '위치 선정 향상 (+1~2), 피로 +15';
      case TrainingType.stamina:
        return '체력 향상 (+1~2), 피로 +18';
      case TrainingType.composure:
        return '침착성 향상 (+1~2), 피로 +12';
      case TrainingType.rest:
        return '피로 회복 (-20), 자신감 +1';
      case TrainingType.rehab:
        return '부상 회복 가속, 피로 -10';
    }
  }

  /// 강도가 높은 훈련인지
  bool get isIntensive =>
      this == TrainingType.stamina ||
      this == TrainingType.shooting ||
      this == TrainingType.dribbling;

  /// 휴식/재활인지
  bool get isRest =>
      this == TrainingType.rest || this == TrainingType.rehab;
}

/// 게임 스냅샷 (저장 루트)
@freezed
class GameSnapshot with _$GameSnapshot {
  const factory GameSnapshot({
    @Default(1) int version, // 스냅샷 버전
    required DateTime savedAt, // 저장 시간
    @Default(GameState.boot) GameState gameState, // 현재 게임 상태
    required PlayerCharacter pc, // 플레이어 캐릭터
    required Season season, // 현재 시즌
    MatchSession? activeMatch, // 진행 중인 경기 (있을 경우)
    @Default(3) int weeklyActionsRemaining, // 이번 주 남은 행동 횟수
    LeagueStats? leagueStats, // 개인 순위용 리그 통계
  }) = _GameSnapshot;

  factory GameSnapshot.fromJson(Map<String, dynamic> json) =>
      _$GameSnapshotFromJson(json);
}

/// 게임 스냅샷 확장
extension GameSnapshotX on GameSnapshot {
  /// 다음 경기 가져오기
  Fixture? get nextFixture => season.getNextFixture(pc.profile.teamId);

  /// PC 팀 가져오기
  Team? get pcTeam => season.teams[pc.profile.teamId];

  /// 다음 상대 팀 가져오기
  Team? get nextOpponent {
    final fixture = nextFixture;
    if (fixture == null) return null;

    final opponentId = fixture.homeTeamId == pc.profile.teamId
        ? fixture.awayTeamId
        : fixture.homeTeamId;
    return season.teams[opponentId];
  }

  /// PC 순위 가져오기
  int get pcRank {
    final sorted = season.sortedStandings;
    return sorted.indexWhere((s) => s.teamId == pc.profile.teamId) + 1;
  }

  /// 행동 가능 여부
  bool get canTakeAction => weeklyActionsRemaining > 0;
}
