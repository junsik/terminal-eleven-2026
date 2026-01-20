// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'training_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrainingEventResultImpl _$$TrainingEventResultImplFromJson(
  Map<String, dynamic> json,
) => _$TrainingEventResultImpl(
  eventType: $enumDecode(_$TrainingEventTypeEnumMap, json['eventType']),
  statMultiplier: (json['statMultiplier'] as num?)?.toDouble() ?? 1.0,
  fatigueMultiplier: (json['fatigueMultiplier'] as num?)?.toDouble() ?? 1.0,
  confidenceChange: (json['confidenceChange'] as num?)?.toInt() ?? 0,
  trustChange: (json['trustChange'] as num?)?.toInt() ?? 0,
  message: json['message'] as String?,
);

Map<String, dynamic> _$$TrainingEventResultImplToJson(
  _$TrainingEventResultImpl instance,
) => <String, dynamic>{
  'eventType': _$TrainingEventTypeEnumMap[instance.eventType]!,
  'statMultiplier': instance.statMultiplier,
  'fatigueMultiplier': instance.fatigueMultiplier,
  'confidenceChange': instance.confidenceChange,
  'trustChange': instance.trustChange,
  'message': instance.message,
};

const _$TrainingEventTypeEnumMap = {
  TrainingEventType.coachGuidance: 'coachGuidance',
  TrainingEventType.rivalCompetition: 'rivalCompetition',
  TrainingEventType.teamTactics: 'teamTactics',
  TrainingEventType.perfectForm: 'perfectForm',
  TrainingEventType.minorSetback: 'minorSetback',
};
