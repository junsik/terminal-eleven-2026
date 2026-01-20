// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TrainingEventResult _$TrainingEventResultFromJson(Map<String, dynamic> json) {
  return _TrainingEventResult.fromJson(json);
}

/// @nodoc
mixin _$TrainingEventResult {
  TrainingEventType get eventType => throw _privateConstructorUsedError;
  double get statMultiplier => throw _privateConstructorUsedError; // 스탯 증가 배율
  double get fatigueMultiplier =>
      throw _privateConstructorUsedError; // 피로 증가 배율
  int get confidenceChange => throw _privateConstructorUsedError; // 자신감 변화
  int get trustChange => throw _privateConstructorUsedError; // 신뢰도 변화
  String? get message => throw _privateConstructorUsedError;

  /// Serializes this TrainingEventResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TrainingEventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TrainingEventResultCopyWith<TrainingEventResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingEventResultCopyWith<$Res> {
  factory $TrainingEventResultCopyWith(
    TrainingEventResult value,
    $Res Function(TrainingEventResult) then,
  ) = _$TrainingEventResultCopyWithImpl<$Res, TrainingEventResult>;
  @useResult
  $Res call({
    TrainingEventType eventType,
    double statMultiplier,
    double fatigueMultiplier,
    int confidenceChange,
    int trustChange,
    String? message,
  });
}

/// @nodoc
class _$TrainingEventResultCopyWithImpl<$Res, $Val extends TrainingEventResult>
    implements $TrainingEventResultCopyWith<$Res> {
  _$TrainingEventResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TrainingEventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventType = null,
    Object? statMultiplier = null,
    Object? fatigueMultiplier = null,
    Object? confidenceChange = null,
    Object? trustChange = null,
    Object? message = freezed,
  }) {
    return _then(
      _value.copyWith(
            eventType: null == eventType
                ? _value.eventType
                : eventType // ignore: cast_nullable_to_non_nullable
                      as TrainingEventType,
            statMultiplier: null == statMultiplier
                ? _value.statMultiplier
                : statMultiplier // ignore: cast_nullable_to_non_nullable
                      as double,
            fatigueMultiplier: null == fatigueMultiplier
                ? _value.fatigueMultiplier
                : fatigueMultiplier // ignore: cast_nullable_to_non_nullable
                      as double,
            confidenceChange: null == confidenceChange
                ? _value.confidenceChange
                : confidenceChange // ignore: cast_nullable_to_non_nullable
                      as int,
            trustChange: null == trustChange
                ? _value.trustChange
                : trustChange // ignore: cast_nullable_to_non_nullable
                      as int,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TrainingEventResultImplCopyWith<$Res>
    implements $TrainingEventResultCopyWith<$Res> {
  factory _$$TrainingEventResultImplCopyWith(
    _$TrainingEventResultImpl value,
    $Res Function(_$TrainingEventResultImpl) then,
  ) = __$$TrainingEventResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    TrainingEventType eventType,
    double statMultiplier,
    double fatigueMultiplier,
    int confidenceChange,
    int trustChange,
    String? message,
  });
}

/// @nodoc
class __$$TrainingEventResultImplCopyWithImpl<$Res>
    extends _$TrainingEventResultCopyWithImpl<$Res, _$TrainingEventResultImpl>
    implements _$$TrainingEventResultImplCopyWith<$Res> {
  __$$TrainingEventResultImplCopyWithImpl(
    _$TrainingEventResultImpl _value,
    $Res Function(_$TrainingEventResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TrainingEventResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventType = null,
    Object? statMultiplier = null,
    Object? fatigueMultiplier = null,
    Object? confidenceChange = null,
    Object? trustChange = null,
    Object? message = freezed,
  }) {
    return _then(
      _$TrainingEventResultImpl(
        eventType: null == eventType
            ? _value.eventType
            : eventType // ignore: cast_nullable_to_non_nullable
                  as TrainingEventType,
        statMultiplier: null == statMultiplier
            ? _value.statMultiplier
            : statMultiplier // ignore: cast_nullable_to_non_nullable
                  as double,
        fatigueMultiplier: null == fatigueMultiplier
            ? _value.fatigueMultiplier
            : fatigueMultiplier // ignore: cast_nullable_to_non_nullable
                  as double,
        confidenceChange: null == confidenceChange
            ? _value.confidenceChange
            : confidenceChange // ignore: cast_nullable_to_non_nullable
                  as int,
        trustChange: null == trustChange
            ? _value.trustChange
            : trustChange // ignore: cast_nullable_to_non_nullable
                  as int,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TrainingEventResultImpl implements _TrainingEventResult {
  const _$TrainingEventResultImpl({
    required this.eventType,
    this.statMultiplier = 1.0,
    this.fatigueMultiplier = 1.0,
    this.confidenceChange = 0,
    this.trustChange = 0,
    this.message,
  });

  factory _$TrainingEventResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$TrainingEventResultImplFromJson(json);

  @override
  final TrainingEventType eventType;
  @override
  @JsonKey()
  final double statMultiplier;
  // 스탯 증가 배율
  @override
  @JsonKey()
  final double fatigueMultiplier;
  // 피로 증가 배율
  @override
  @JsonKey()
  final int confidenceChange;
  // 자신감 변화
  @override
  @JsonKey()
  final int trustChange;
  // 신뢰도 변화
  @override
  final String? message;

  @override
  String toString() {
    return 'TrainingEventResult(eventType: $eventType, statMultiplier: $statMultiplier, fatigueMultiplier: $fatigueMultiplier, confidenceChange: $confidenceChange, trustChange: $trustChange, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TrainingEventResultImpl &&
            (identical(other.eventType, eventType) ||
                other.eventType == eventType) &&
            (identical(other.statMultiplier, statMultiplier) ||
                other.statMultiplier == statMultiplier) &&
            (identical(other.fatigueMultiplier, fatigueMultiplier) ||
                other.fatigueMultiplier == fatigueMultiplier) &&
            (identical(other.confidenceChange, confidenceChange) ||
                other.confidenceChange == confidenceChange) &&
            (identical(other.trustChange, trustChange) ||
                other.trustChange == trustChange) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    eventType,
    statMultiplier,
    fatigueMultiplier,
    confidenceChange,
    trustChange,
    message,
  );

  /// Create a copy of TrainingEventResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TrainingEventResultImplCopyWith<_$TrainingEventResultImpl> get copyWith =>
      __$$TrainingEventResultImplCopyWithImpl<_$TrainingEventResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TrainingEventResultImplToJson(this);
  }
}

abstract class _TrainingEventResult implements TrainingEventResult {
  const factory _TrainingEventResult({
    required final TrainingEventType eventType,
    final double statMultiplier,
    final double fatigueMultiplier,
    final int confidenceChange,
    final int trustChange,
    final String? message,
  }) = _$TrainingEventResultImpl;

  factory _TrainingEventResult.fromJson(Map<String, dynamic> json) =
      _$TrainingEventResultImpl.fromJson;

  @override
  TrainingEventType get eventType;
  @override
  double get statMultiplier; // 스탯 증가 배율
  @override
  double get fatigueMultiplier; // 피로 증가 배율
  @override
  int get confidenceChange; // 자신감 변화
  @override
  int get trustChange; // 신뢰도 변화
  @override
  String? get message;

  /// Create a copy of TrainingEventResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TrainingEventResultImplCopyWith<_$TrainingEventResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
