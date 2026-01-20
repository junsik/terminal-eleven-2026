// 훈련 이벤트 모델

import 'package:freezed_annotation/freezed_annotation.dart';

part 'training_event.freezed.dart';
part 'training_event.g.dart';

/// 훈련 이벤트 타입
enum TrainingEventType {
  @JsonValue('coachGuidance')
  coachGuidance, // 코치 특별 지도 - 스탯 보너스

  @JsonValue('rivalCompetition')
  rivalCompetition, // 라이벌 경쟁 - 성공 시 큰 보너스, 실패 시 페널티

  @JsonValue('teamTactics')
  teamTactics, // 팀 전술 훈련 - 신뢰도 상승

  @JsonValue('perfectForm')
  perfectForm, // 최고의 컨디션 - 피로 증가 감소

  @JsonValue('minorSetback')
  minorSetback, // 작은 차질 - 효과 감소
}

/// 훈련 이벤트 확장
extension TrainingEventTypeX on TrainingEventType {
  String get displayName {
    switch (this) {
      case TrainingEventType.coachGuidance:
        return '코치 특별 지도';
      case TrainingEventType.rivalCompetition:
        return '라이벌과의 경쟁';
      case TrainingEventType.teamTactics:
        return '팀 전술 훈련';
      case TrainingEventType.perfectForm:
        return '최고의 컨디션';
      case TrainingEventType.minorSetback:
        return '작은 차질';
    }
  }

  String get description {
    switch (this) {
      case TrainingEventType.coachGuidance:
        return '코치가 1:1 지도를 해줍니다. 훈련 효과 +50%';
      case TrainingEventType.rivalCompetition:
        return '팀 내 라이벌과 경쟁합니다. 승리 시 자신감 +1';
      case TrainingEventType.teamTactics:
        return '팀 전체 전술 훈련에 참여합니다. 감독 신뢰도 +5';
      case TrainingEventType.perfectForm:
        return '몸이 가볍습니다. 피로 증가 -50%';
      case TrainingEventType.minorSetback:
        return '컨디션이 좋지 않습니다. 훈련 효과 -30%';
    }
  }

  String get emoji {
    switch (this) {
      case TrainingEventType.coachGuidance:
        return '📋';
      case TrainingEventType.rivalCompetition:
        return '⚔️';
      case TrainingEventType.teamTactics:
        return '🤝';
      case TrainingEventType.perfectForm:
        return '✨';
      case TrainingEventType.minorSetback:
        return '😓';
    }
  }

  bool get isPositive {
    return this != TrainingEventType.minorSetback;
  }
}

/// 훈련 이벤트 결과
@freezed
class TrainingEventResult with _$TrainingEventResult {
  const factory TrainingEventResult({
    required TrainingEventType eventType,
    @Default(1.0) double statMultiplier, // 스탯 증가 배율
    @Default(1.0) double fatigueMultiplier, // 피로 증가 배율
    @Default(0) int confidenceChange, // 자신감 변화
    @Default(0) int trustChange, // 신뢰도 변화
    String? message, // 이벤트 메시지
  }) = _TrainingEventResult;

  factory TrainingEventResult.fromJson(Map<String, dynamic> json) =>
      _$TrainingEventResultFromJson(json);
}
