// 도메인 모델 - 선수 관련
// Freezed 코드 생성 후 *.freezed.dart, *.g.dart 파일 생성됨

import 'package:freezed_annotation/freezed_annotation.dart';

part 'player.freezed.dart';
part 'player.g.dart';

/// 선수 프로필 정보
@freezed
class PlayerProfile with _$PlayerProfile {
  const factory PlayerProfile({
    required String id,
    required String name,
    required int age,
    required PlayerArchetype archetype,
    required String teamId,
    required PlayerPosition position,
  }) = _PlayerProfile;

  factory PlayerProfile.fromJson(Map<String, dynamic> json) =>
      _$PlayerProfileFromJson(json);
}

/// 선수 아키타입
enum PlayerArchetype {
  @JsonValue('poacher')
  poacher, // 포처 - 득점에 특화
  @JsonValue('speedster')
  speedster, // 스피드스터 - 빠른 돌파
  @JsonValue('pressingForward')
  pressingForward, // 프레싱 포워드 - 압박과 활동량
  @JsonValue('targetMan')
  targetMan, // 타겟맨 - 피지컬과 공중볼
  
  // Midfielder
  @JsonValue('creator')
  creator, // 크리에이터 - 패스와 찬스 메이킹
  @JsonValue('boxToBox')
  boxToBox, // 박스 투 박스 - 공수 밸런스
  @JsonValue('ballWinning')
  ballWinning, // 볼 위닝 - 수비적 미드필더
  
  // Defender
  @JsonValue('stopper')
  stopper, // 스토퍼 - 대인 방어
  @JsonValue('sweeper')
  sweeper, // 스위퍼 - 공간 커버
  @JsonValue('fullBack')
  fullBack, // 풀백 - 측면 수비 및 공격 가담
}

/// 선수 포지션
enum PlayerPosition {
  @JsonValue('forward')
  forward,
  @JsonValue('midfielder')
  midfielder,
  @JsonValue('defender')
  defender,
  @JsonValue('goalkeeper')
  goalkeeper,
}

extension PlayerPositionX on PlayerPosition {
  String get label {
    switch (this) {
      case PlayerPosition.forward:
        return '공격수 (FW)';
      case PlayerPosition.midfielder:
        return '미드필더 (MF)';
      case PlayerPosition.defender:
        return '수비수 (DF)';
      case PlayerPosition.goalkeeper:
        return '골키퍼 (GK)';
    }
  }

  List<PlayerArchetype> get archetypes {
    switch (this) {
      case PlayerPosition.forward:
        return [
          PlayerArchetype.poacher,
          PlayerArchetype.speedster,
          PlayerArchetype.pressingForward,
          PlayerArchetype.targetMan,
        ];
      case PlayerPosition.midfielder:
        return [
          PlayerArchetype.creator,
          PlayerArchetype.boxToBox,
          PlayerArchetype.ballWinning,
        ];
      case PlayerPosition.defender:
        return [
          PlayerArchetype.stopper,
          PlayerArchetype.sweeper,
          PlayerArchetype.fullBack,
        ];
      case PlayerPosition.goalkeeper:
        return []; // GK archetypes not implemented yet
    }
  }
}

extension PlayerArchetypeX on PlayerArchetype {
  String get label {
    switch (this) {
      case PlayerArchetype.poacher:
        return '포처';
      case PlayerArchetype.speedster:
        return '스피드스터';
      case PlayerArchetype.pressingForward:
        return '프레싱 FW';
      case PlayerArchetype.targetMan:
        return '타겟맨';
      case PlayerArchetype.creator:
        return '크리에이터';
      case PlayerArchetype.boxToBox:
        return '박스 투 박스';
      case PlayerArchetype.ballWinning:
        return '볼 위닝';
      case PlayerArchetype.stopper:
        return '스토퍼';
      case PlayerArchetype.sweeper:
        return '스위퍼';
      case PlayerArchetype.fullBack:
        return '풀백';
    }
  }

  String get description {
    switch (this) {
      case PlayerArchetype.poacher:
        return '뛰어난 득점 감각과 위치 선정';
      case PlayerArchetype.speedster:
        return '빠른 스피드로 수비 라인 침투';
      case PlayerArchetype.pressingForward:
        return '전방 압박과 왕성한 활동량';
      case PlayerArchetype.targetMan:
        return '제공권 장악과 포스트 플레이';
      case PlayerArchetype.creator:
        return '킬러 패스와 경기 조율 능력';
      case PlayerArchetype.boxToBox:
        return '공수를 오가는 지칠 줄 모르는 체력';
      case PlayerArchetype.ballWinning:
        return '거친 태클과 중원 장악력';
      case PlayerArchetype.stopper:
        return '강력한 대인 마크와 수비력';
      case PlayerArchetype.sweeper:
        return '지능적인 수비 조율과 커버링';
      case PlayerArchetype.fullBack:
        return '측면 수비와 적극적인 오버래핑';
    }
  }
}

/// 선수 능력치 (0-100)
@freezed
class PlayerStats with _$PlayerStats {
  const factory PlayerStats({
    @Default(50) int pace, // 속도
    @Default(50) int shooting, // 슈팅
    @Default(50) int passing, // 패스
    @Default(50) int ballControl, // 볼 컨트롤
    @Default(50) int positioning, // 위치 선정
    @Default(50) int stamina, // 체력
    @Default(50) int composure, // 침착성
    @Default(50) int defending, // 수비력
  }) = _PlayerStats;

  factory PlayerStats.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatsFromJson(json);
}

/// 부상 상태
enum InjuryStatus {
  @JsonValue('none')
  none, // 부상 없음
  @JsonValue('minor')
  minor, // 경미 (1-2 경기)
  @JsonValue('moderate')
  moderate, // 중간 (3-5 경기)
  @JsonValue('severe')
  severe, // 심각 (6+ 경기)
}

/// 폼 트렌드 (최근 3경기 기반)
enum FormTrend {
  @JsonValue('excellent')
  excellent, // 7.5+
  @JsonValue('good')
  good, // 6.5-7.5
  @JsonValue('average')
  average, // 5.5-6.5
  @JsonValue('poor')
  poor, // < 5.5
}

/// 선수 상태 (동적)
@freezed
class PlayerStatus with _$PlayerStatus {
  const factory PlayerStatus({
    @Default(0) int fatigue, // 피로도 (0-100)
    @Default(0) int confidence, // 자신감 (-3 ~ +3)
    @Default(InjuryStatus.none) InjuryStatus injury, // 부상 상태
    @Default(0) int injuryWeeksRemaining, // 잔여 부상 기간
    @Default(FormTrend.average) FormTrend form, // 폼 트렌드
  }) = _PlayerStatus;

  factory PlayerStatus.fromJson(Map<String, dynamic> json) =>
      _$PlayerStatusFromJson(json);
}

/// 선수 커리어 정보
@freezed
class PlayerCareer with _$PlayerCareer {
  const factory PlayerCareer({
    @Default(1) int level, // 레벨
    @Default(0) int xp, // 경험치
    @Default(30) int trust, // 감독 신뢰도 (0-100)
    @Default(0) int reputation, // 평판 (0-100)
    @Default([]) List<double> lastRatings, // 최근 10경기 평점
    @Default(0) int totalGoals, // 통산 득점
    @Default(0) int totalAssists, // 통산 어시스트
    @Default(0) int matchesPlayed, // 출전 경기 수
  }) = _PlayerCareer;

  factory PlayerCareer.fromJson(Map<String, dynamic> json) =>
      _$PlayerCareerFromJson(json);
}

/// 플레이어 캐릭터 (PC)
@freezed
class PlayerCharacter with _$PlayerCharacter {
  const factory PlayerCharacter({
    required PlayerProfile profile,
    required PlayerStats stats,
    required PlayerStatus status,
    required PlayerCareer career,
  }) = _PlayerCharacter;

  factory PlayerCharacter.fromJson(Map<String, dynamic> json) =>
      _$PlayerCharacterFromJson(json);

  /// 새 커리어 시작 시 기본 선수 생성
  factory PlayerCharacter.create({
    required String id,
    required String name,
    required PlayerPosition position,
    required PlayerArchetype archetype,
    required String teamId,
  }) {
    // 아키타입별 초기 스탯 설정
    final stats = _getInitialStats(archetype);

    return PlayerCharacter(
      profile: PlayerProfile(
        id: id,
        name: name,
        age: 18,
        position: position,
        archetype: archetype,
        teamId: teamId,
      ),
      stats: stats,
      status: const PlayerStatus(),
      career: const PlayerCareer(),
    );
  }
}

/// 아키타입별 초기 스탯
PlayerStats _getInitialStats(PlayerArchetype archetype) {
  switch (archetype) {
    case PlayerArchetype.poacher:
      return const PlayerStats(
        pace: 55,
        shooting: 65, // 강점
        passing: 45,
        ballControl: 50,
        positioning: 60, // 강점
        stamina: 50,
        composure: 55,
      );
    case PlayerArchetype.speedster:
      return const PlayerStats(
        pace: 70, // 강점
        shooting: 50,
        passing: 50,
        ballControl: 55,
        positioning: 50,
        stamina: 55,
        composure: 45, // 약점
      );
    case PlayerArchetype.pressingForward:
      return const PlayerStats(
        pace: 55,
        shooting: 50,
        passing: 55,
        ballControl: 50,
        positioning: 50,
        stamina: 65, // 강점
        composure: 50,
      );
    case PlayerArchetype.targetMan:
      return const PlayerStats(
        pace: 45, // 약점
        shooting: 55,
        passing: 50,
        ballControl: 55,
        positioning: 60,
        stamina: 55,
        composure: 60, // 강점
        defending: 40,
      );
    case PlayerArchetype.creator:
      return const PlayerStats(
        pace: 55,
        shooting: 50,
        passing: 70, // 핵심
        ballControl: 65, // 강점
        positioning: 55,
        stamina: 50,
        composure: 60,
        defending: 45,
      );
    case PlayerArchetype.boxToBox:
      return const PlayerStats(
        pace: 60,
        shooting: 55,
        passing: 60,
        ballControl: 55,
        positioning: 60,
        stamina: 75, // 핵심
        composure: 55,
        defending: 60, // 강점
      );
    case PlayerArchetype.ballWinning:
      return const PlayerStats(
        pace: 55,
        shooting: 45,
        passing: 55,
        ballControl: 50,
        positioning: 65, // 강점
        stamina: 65,
        composure: 55,
        defending: 70, // 핵심
      );
    case PlayerArchetype.stopper:
      return const PlayerStats(
        pace: 50,
        shooting: 40,
        passing: 45,
        ballControl: 45,
        positioning: 65,
        stamina: 60,
        composure: 55,
        defending: 75, // 핵심
      );
    case PlayerArchetype.sweeper:
      return const PlayerStats(
        pace: 60, // 강점
        shooting: 40,
        passing: 55,
        ballControl: 55,
        positioning: 70, // 핵심
        stamina: 55,
        composure: 65,
        defending: 65,
      );
    case PlayerArchetype.fullBack:
      return const PlayerStats(
        pace: 70, // 핵심
        shooting: 45,
        passing: 60, // 강점
        ballControl: 55,
        positioning: 55,
        stamina: 65,
        composure: 50,
        defending: 60,
      );
  }
}
