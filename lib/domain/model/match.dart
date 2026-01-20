// 도메인 모델 - 경기 관련

import 'package:freezed_annotation/freezed_annotation.dart';

part 'match.freezed.dart';
part 'match.g.dart';

/// 경기 단계
enum MatchPhase {
  @JsonValue('intro')
  intro, // 경기 시작
  @JsonValue('highlightPresent')
  highlightPresent, // 하이라이트 상황 제시
  @JsonValue('highlightResolve')
  highlightResolve, // 결과 계산 중
  @JsonValue('highlightResult')
  highlightResult, // 결과 출력
  @JsonValue('fullTime')
  fullTime, // 경기 종료
  @JsonValue('summary')
  summary, // 요약
}

/// 경기장 구역
enum FieldZone {
  @JsonValue('def')
  def, // 수비 지역
  @JsonValue('mid')
  mid, // 미드필드
  @JsonValue('att')
  att, // 공격 지역
  @JsonValue('box')
  box, // 페널티 박스
}

/// 스코어 상황
enum ScoreContext {
  @JsonValue('leading')
  leading, // 앞서고 있음
  @JsonValue('draw')
  draw, // 동점
  @JsonValue('trailing')
  trailing, // 뒤지고 있음
}

/// 하이라이트 이벤트 종류
enum HighlightType {
  @JsonValue('runInBehind')
  runInBehind, // 뒷공간 침투
  @JsonValue('receiveAndTurn')
  receiveAndTurn, // 등지고 받아 턴
  @JsonValue('oneOnOne')
  oneOnOne, // 키퍼와 1:1
  @JsonValue('edgeOfBoxShot')
  edgeOfBoxShot, // 박스 앞 중거리
  @JsonValue('quickCounter')
  quickCounter, // 역습 전개
  @JsonValue('pressing')
  pressing, // 전방 압박
  @JsonValue('defensiveCover')
  defensiveCover, // 수비 커버
  @JsonValue('looseBall')
  looseBall, // 세컨볼 경합
  @JsonValue('setPieceRebound')
  setPieceRebound, // 세트피스 세컨 찬스
  @JsonValue('fatigueMoment')
  fatigueMoment, // 피로 구간
  @JsonValue('mentalPressure')
  mentalPressure, // 멘탈 압박
  @JsonValue('coachFeedback')
  coachFeedback, // 코치 피드백
  @JsonValue('penaltyKick')
  penaltyKick, // 페널티킥
  @JsonValue('clutchChance')
  clutchChance, // 클러치 찬스 (막판 결정적 기회)
}

/// 하이라이트 이벤트
@freezed
class HighlightEvent with _$HighlightEvent {
  const factory HighlightEvent({
    required int minute, // 경기 시간 (1-90+)
    required HighlightType type, // 이벤트 종류
    required FieldZone zone, // 경기장 구역
    @Default(1) int pressure, // 압박 레벨 (0-3)
    required ScoreContext scoreContext, // 스코어 상황
    required List<String> choices, // 선택지 목록
    String? selectedChoice, // 선택한 커맨드
    HighlightResult? result, // 결과
  }) = _HighlightEvent;

  factory HighlightEvent.fromJson(Map<String, dynamic> json) =>
      _$HighlightEventFromJson(json);
}

/// 하이라이트 결과
@freezed
class HighlightResult with _$HighlightResult {
  const factory HighlightResult({
    required bool success, // 성공 여부
    @Default(false) bool isGoal, // 득점 여부
    @Default(false) bool isAssist, // 어시스트 여부
    @Default(false) bool isYellowCard, // 경고
    @Default(false) bool isRedCard, // 퇴장
    @Default(false) bool isInjury, // 부상
    @Default(0.0) double ratingChange, // 평점 변화
    @Default(0) int fatigueChange, // 피로 변화
    @Default(0) int confidenceChange, // 자신감 변화
    @Default(0) int momentumChange, // 모멘텀 변화
    required String description, // 결과 설명
  }) = _HighlightResult;

  factory HighlightResult.fromJson(Map<String, dynamic> json) =>
      _$HighlightResultFromJson(json);
}

/// 로그 타입
enum LogType {
  @JsonValue('commentary')
  commentary, // 중계
  @JsonValue('result')
  result, // 결과
  @JsonValue('system')
  system, // 시스템
}

/// 로그 라인
@freezed
class LogLine with _$LogLine {
  const factory LogLine({
    int? minute, // 경기 시간
    required LogType type, // 로그 타입
    required String text, // 텍스트
    @Default({}) Map<String, String> tags, // 태그
  }) = _LogLine;

  factory LogLine.fromJson(Map<String, dynamic> json) =>
      _$LogLineFromJson(json);
}

/// 스코어
@freezed
class Score with _$Score {
  const factory Score({
    @Default(0) int home,
    @Default(0) int away,
  }) = _Score;

  factory Score.fromJson(Map<String, dynamic> json) => _$ScoreFromJson(json);
}

/// 평점 누적기
@freezed
class RatingAccumulator with _$RatingAccumulator {
  const factory RatingAccumulator({
    @Default(0) int goals, // 득점
    @Default(0) int assists, // 어시스트
    @Default(0) int shotsOnTarget, // 유효슈팅
    @Default(0) int keyPasses, // 키패스
    @Default(0) int successfulPresses, // 압박 성공
    @Default(0) int chanceMissed, // 결정적 찬스 실패
    @Default(0) int possessionLost, // 소유권 상실
    @Default(0) int yellowCards, // 경고
    @Default(0) int redCards, // 퇴장
  }) = _RatingAccumulator;

  factory RatingAccumulator.fromJson(Map<String, dynamic> json) =>
      _$RatingAccumulatorFromJson(json);
}

/// 평점 계산 확장
extension RatingAccumulatorX on RatingAccumulator {
  /// 총 점수 계산
  double get totalScore {
    double sum = 0;

    // 긍정
    sum += goals * 8.0;
    sum += assists * 5.0;
    sum += shotsOnTarget * 3.0;
    sum += keyPasses * 3.0;
    sum += successfulPresses * 2.0;

    // 부정
    sum -= chanceMissed * 4.0;
    sum -= possessionLost * 2.0;
    sum -= yellowCards * 3.0;
    sum -= redCards * 8.0;

    return sum;
  }

  /// 최종 평점 계산 (0.0 - 10.0)
  double get finalRating {
    final raw = 6.0 + (totalScore / 10.0);
    return raw.clamp(0.0, 10.0);
  }
}

/// 경기 세션
@freezed
class MatchSession with _$MatchSession {
  const factory MatchSession({
    required String id,
    required String fixtureId,
    required String homeTeamId,
    required String awayTeamId,
    required bool isHome, // PC 팀이 홈인지
    @Default(MatchPhase.intro) MatchPhase phase, // 현재 단계
    @Default(0) int minute, // 현재 시간
    @Default(Score()) Score score, // 스코어
    @Default([]) List<HighlightEvent> highlights, // 하이라이트 목록
    @Default(0) int currentHighlightIndex, // 현재 하이라이트 인덱스
    @Default([]) List<LogLine> log, // 경기 로그
    @Default(RatingAccumulator()) RatingAccumulator ratingAccumulator, // 평점 누적
    required int rngSeed, // 랜덤 시드
    @Default(0) int momentum, // 모멘텀 (-3 ~ +3)
    @Default(0) int consecutiveSuccess, // 연속 성공 횟수
    @Default(0) int consecutiveFailure, // 연속 실패 횟수
    @Default(-1) int lastShoutIndex, // 마지막 전술 외침 하이라이트 인덱스
  }) = _MatchSession;

  factory MatchSession.fromJson(Map<String, dynamic> json) =>
      _$MatchSessionFromJson(json);
}

/// 경기 세션 확장
extension MatchSessionX on MatchSession {
  /// 현재 하이라이트 가져오기
  HighlightEvent? get currentHighlight {
    if (currentHighlightIndex < highlights.length) {
      return highlights[currentHighlightIndex];
    }
    return null;
  }

  /// 모든 하이라이트 완료 여부
  bool get isAllHighlightsComplete =>
      currentHighlightIndex >= highlights.length;

  /// PC 팀 스코어
  int get pcScore => isHome ? score.home : score.away;

  /// 상대 팀 스코어
  int get opponentScore => isHome ? score.away : score.home;

  /// 스코어 상황
  ScoreContext get scoreContext {
    if (pcScore > opponentScore) return ScoreContext.leading;
    if (pcScore < opponentScore) return ScoreContext.trailing;
    return ScoreContext.draw;
  }

  /// 클러치 타임 여부 (80분 이후 & 1점차 이내 승부)
  bool get isClutchTime {
    if (minute < 80) return false;
    final diff = (score.home - score.away).abs();
    return diff <= 1;
  }
}
