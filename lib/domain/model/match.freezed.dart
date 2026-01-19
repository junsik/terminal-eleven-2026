// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'match.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

HighlightEvent _$HighlightEventFromJson(Map<String, dynamic> json) {
  return _HighlightEvent.fromJson(json);
}

/// @nodoc
mixin _$HighlightEvent {
  int get minute => throw _privateConstructorUsedError; // 경기 시간 (1-90+)
  HighlightType get type => throw _privateConstructorUsedError; // 이벤트 종류
  FieldZone get zone => throw _privateConstructorUsedError; // 경기장 구역
  int get pressure => throw _privateConstructorUsedError; // 압박 레벨 (0-3)
  ScoreContext get scoreContext => throw _privateConstructorUsedError; // 스코어 상황
  List<String> get choices => throw _privateConstructorUsedError; // 선택지 목록
  String? get selectedChoice => throw _privateConstructorUsedError; // 선택한 커맨드
  HighlightResult? get result => throw _privateConstructorUsedError;

  /// Serializes this HighlightEvent to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HighlightEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HighlightEventCopyWith<HighlightEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HighlightEventCopyWith<$Res> {
  factory $HighlightEventCopyWith(
    HighlightEvent value,
    $Res Function(HighlightEvent) then,
  ) = _$HighlightEventCopyWithImpl<$Res, HighlightEvent>;
  @useResult
  $Res call({
    int minute,
    HighlightType type,
    FieldZone zone,
    int pressure,
    ScoreContext scoreContext,
    List<String> choices,
    String? selectedChoice,
    HighlightResult? result,
  });

  $HighlightResultCopyWith<$Res>? get result;
}

/// @nodoc
class _$HighlightEventCopyWithImpl<$Res, $Val extends HighlightEvent>
    implements $HighlightEventCopyWith<$Res> {
  _$HighlightEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HighlightEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minute = null,
    Object? type = null,
    Object? zone = null,
    Object? pressure = null,
    Object? scoreContext = null,
    Object? choices = null,
    Object? selectedChoice = freezed,
    Object? result = freezed,
  }) {
    return _then(
      _value.copyWith(
            minute: null == minute
                ? _value.minute
                : minute // ignore: cast_nullable_to_non_nullable
                      as int,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as HighlightType,
            zone: null == zone
                ? _value.zone
                : zone // ignore: cast_nullable_to_non_nullable
                      as FieldZone,
            pressure: null == pressure
                ? _value.pressure
                : pressure // ignore: cast_nullable_to_non_nullable
                      as int,
            scoreContext: null == scoreContext
                ? _value.scoreContext
                : scoreContext // ignore: cast_nullable_to_non_nullable
                      as ScoreContext,
            choices: null == choices
                ? _value.choices
                : choices // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            selectedChoice: freezed == selectedChoice
                ? _value.selectedChoice
                : selectedChoice // ignore: cast_nullable_to_non_nullable
                      as String?,
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as HighlightResult?,
          )
          as $Val,
    );
  }

  /// Create a copy of HighlightEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $HighlightResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $HighlightResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$HighlightEventImplCopyWith<$Res>
    implements $HighlightEventCopyWith<$Res> {
  factory _$$HighlightEventImplCopyWith(
    _$HighlightEventImpl value,
    $Res Function(_$HighlightEventImpl) then,
  ) = __$$HighlightEventImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int minute,
    HighlightType type,
    FieldZone zone,
    int pressure,
    ScoreContext scoreContext,
    List<String> choices,
    String? selectedChoice,
    HighlightResult? result,
  });

  @override
  $HighlightResultCopyWith<$Res>? get result;
}

/// @nodoc
class __$$HighlightEventImplCopyWithImpl<$Res>
    extends _$HighlightEventCopyWithImpl<$Res, _$HighlightEventImpl>
    implements _$$HighlightEventImplCopyWith<$Res> {
  __$$HighlightEventImplCopyWithImpl(
    _$HighlightEventImpl _value,
    $Res Function(_$HighlightEventImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HighlightEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minute = null,
    Object? type = null,
    Object? zone = null,
    Object? pressure = null,
    Object? scoreContext = null,
    Object? choices = null,
    Object? selectedChoice = freezed,
    Object? result = freezed,
  }) {
    return _then(
      _$HighlightEventImpl(
        minute: null == minute
            ? _value.minute
            : minute // ignore: cast_nullable_to_non_nullable
                  as int,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as HighlightType,
        zone: null == zone
            ? _value.zone
            : zone // ignore: cast_nullable_to_non_nullable
                  as FieldZone,
        pressure: null == pressure
            ? _value.pressure
            : pressure // ignore: cast_nullable_to_non_nullable
                  as int,
        scoreContext: null == scoreContext
            ? _value.scoreContext
            : scoreContext // ignore: cast_nullable_to_non_nullable
                  as ScoreContext,
        choices: null == choices
            ? _value._choices
            : choices // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        selectedChoice: freezed == selectedChoice
            ? _value.selectedChoice
            : selectedChoice // ignore: cast_nullable_to_non_nullable
                  as String?,
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as HighlightResult?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HighlightEventImpl implements _HighlightEvent {
  const _$HighlightEventImpl({
    required this.minute,
    required this.type,
    required this.zone,
    this.pressure = 1,
    required this.scoreContext,
    required final List<String> choices,
    this.selectedChoice,
    this.result,
  }) : _choices = choices;

  factory _$HighlightEventImpl.fromJson(Map<String, dynamic> json) =>
      _$$HighlightEventImplFromJson(json);

  @override
  final int minute;
  // 경기 시간 (1-90+)
  @override
  final HighlightType type;
  // 이벤트 종류
  @override
  final FieldZone zone;
  // 경기장 구역
  @override
  @JsonKey()
  final int pressure;
  // 압박 레벨 (0-3)
  @override
  final ScoreContext scoreContext;
  // 스코어 상황
  final List<String> _choices;
  // 스코어 상황
  @override
  List<String> get choices {
    if (_choices is EqualUnmodifiableListView) return _choices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_choices);
  }

  // 선택지 목록
  @override
  final String? selectedChoice;
  // 선택한 커맨드
  @override
  final HighlightResult? result;

  @override
  String toString() {
    return 'HighlightEvent(minute: $minute, type: $type, zone: $zone, pressure: $pressure, scoreContext: $scoreContext, choices: $choices, selectedChoice: $selectedChoice, result: $result)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HighlightEventImpl &&
            (identical(other.minute, minute) || other.minute == minute) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.zone, zone) || other.zone == zone) &&
            (identical(other.pressure, pressure) ||
                other.pressure == pressure) &&
            (identical(other.scoreContext, scoreContext) ||
                other.scoreContext == scoreContext) &&
            const DeepCollectionEquality().equals(other._choices, _choices) &&
            (identical(other.selectedChoice, selectedChoice) ||
                other.selectedChoice == selectedChoice) &&
            (identical(other.result, result) || other.result == result));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    minute,
    type,
    zone,
    pressure,
    scoreContext,
    const DeepCollectionEquality().hash(_choices),
    selectedChoice,
    result,
  );

  /// Create a copy of HighlightEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HighlightEventImplCopyWith<_$HighlightEventImpl> get copyWith =>
      __$$HighlightEventImplCopyWithImpl<_$HighlightEventImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HighlightEventImplToJson(this);
  }
}

abstract class _HighlightEvent implements HighlightEvent {
  const factory _HighlightEvent({
    required final int minute,
    required final HighlightType type,
    required final FieldZone zone,
    final int pressure,
    required final ScoreContext scoreContext,
    required final List<String> choices,
    final String? selectedChoice,
    final HighlightResult? result,
  }) = _$HighlightEventImpl;

  factory _HighlightEvent.fromJson(Map<String, dynamic> json) =
      _$HighlightEventImpl.fromJson;

  @override
  int get minute; // 경기 시간 (1-90+)
  @override
  HighlightType get type; // 이벤트 종류
  @override
  FieldZone get zone; // 경기장 구역
  @override
  int get pressure; // 압박 레벨 (0-3)
  @override
  ScoreContext get scoreContext; // 스코어 상황
  @override
  List<String> get choices; // 선택지 목록
  @override
  String? get selectedChoice; // 선택한 커맨드
  @override
  HighlightResult? get result;

  /// Create a copy of HighlightEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HighlightEventImplCopyWith<_$HighlightEventImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

HighlightResult _$HighlightResultFromJson(Map<String, dynamic> json) {
  return _HighlightResult.fromJson(json);
}

/// @nodoc
mixin _$HighlightResult {
  bool get success => throw _privateConstructorUsedError; // 성공 여부
  bool get isGoal => throw _privateConstructorUsedError; // 득점 여부
  bool get isAssist => throw _privateConstructorUsedError; // 어시스트 여부
  bool get isYellowCard => throw _privateConstructorUsedError; // 경고
  bool get isRedCard => throw _privateConstructorUsedError; // 퇴장
  bool get isInjury => throw _privateConstructorUsedError; // 부상
  double get ratingChange => throw _privateConstructorUsedError; // 평점 변화
  int get fatigueChange => throw _privateConstructorUsedError; // 피로 변화
  int get confidenceChange => throw _privateConstructorUsedError; // 자신감 변화
  String get description => throw _privateConstructorUsedError;

  /// Serializes this HighlightResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of HighlightResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $HighlightResultCopyWith<HighlightResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HighlightResultCopyWith<$Res> {
  factory $HighlightResultCopyWith(
    HighlightResult value,
    $Res Function(HighlightResult) then,
  ) = _$HighlightResultCopyWithImpl<$Res, HighlightResult>;
  @useResult
  $Res call({
    bool success,
    bool isGoal,
    bool isAssist,
    bool isYellowCard,
    bool isRedCard,
    bool isInjury,
    double ratingChange,
    int fatigueChange,
    int confidenceChange,
    String description,
  });
}

/// @nodoc
class _$HighlightResultCopyWithImpl<$Res, $Val extends HighlightResult>
    implements $HighlightResultCopyWith<$Res> {
  _$HighlightResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of HighlightResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? isGoal = null,
    Object? isAssist = null,
    Object? isYellowCard = null,
    Object? isRedCard = null,
    Object? isInjury = null,
    Object? ratingChange = null,
    Object? fatigueChange = null,
    Object? confidenceChange = null,
    Object? description = null,
  }) {
    return _then(
      _value.copyWith(
            success: null == success
                ? _value.success
                : success // ignore: cast_nullable_to_non_nullable
                      as bool,
            isGoal: null == isGoal
                ? _value.isGoal
                : isGoal // ignore: cast_nullable_to_non_nullable
                      as bool,
            isAssist: null == isAssist
                ? _value.isAssist
                : isAssist // ignore: cast_nullable_to_non_nullable
                      as bool,
            isYellowCard: null == isYellowCard
                ? _value.isYellowCard
                : isYellowCard // ignore: cast_nullable_to_non_nullable
                      as bool,
            isRedCard: null == isRedCard
                ? _value.isRedCard
                : isRedCard // ignore: cast_nullable_to_non_nullable
                      as bool,
            isInjury: null == isInjury
                ? _value.isInjury
                : isInjury // ignore: cast_nullable_to_non_nullable
                      as bool,
            ratingChange: null == ratingChange
                ? _value.ratingChange
                : ratingChange // ignore: cast_nullable_to_non_nullable
                      as double,
            fatigueChange: null == fatigueChange
                ? _value.fatigueChange
                : fatigueChange // ignore: cast_nullable_to_non_nullable
                      as int,
            confidenceChange: null == confidenceChange
                ? _value.confidenceChange
                : confidenceChange // ignore: cast_nullable_to_non_nullable
                      as int,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$HighlightResultImplCopyWith<$Res>
    implements $HighlightResultCopyWith<$Res> {
  factory _$$HighlightResultImplCopyWith(
    _$HighlightResultImpl value,
    $Res Function(_$HighlightResultImpl) then,
  ) = __$$HighlightResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    bool success,
    bool isGoal,
    bool isAssist,
    bool isYellowCard,
    bool isRedCard,
    bool isInjury,
    double ratingChange,
    int fatigueChange,
    int confidenceChange,
    String description,
  });
}

/// @nodoc
class __$$HighlightResultImplCopyWithImpl<$Res>
    extends _$HighlightResultCopyWithImpl<$Res, _$HighlightResultImpl>
    implements _$$HighlightResultImplCopyWith<$Res> {
  __$$HighlightResultImplCopyWithImpl(
    _$HighlightResultImpl _value,
    $Res Function(_$HighlightResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of HighlightResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? success = null,
    Object? isGoal = null,
    Object? isAssist = null,
    Object? isYellowCard = null,
    Object? isRedCard = null,
    Object? isInjury = null,
    Object? ratingChange = null,
    Object? fatigueChange = null,
    Object? confidenceChange = null,
    Object? description = null,
  }) {
    return _then(
      _$HighlightResultImpl(
        success: null == success
            ? _value.success
            : success // ignore: cast_nullable_to_non_nullable
                  as bool,
        isGoal: null == isGoal
            ? _value.isGoal
            : isGoal // ignore: cast_nullable_to_non_nullable
                  as bool,
        isAssist: null == isAssist
            ? _value.isAssist
            : isAssist // ignore: cast_nullable_to_non_nullable
                  as bool,
        isYellowCard: null == isYellowCard
            ? _value.isYellowCard
            : isYellowCard // ignore: cast_nullable_to_non_nullable
                  as bool,
        isRedCard: null == isRedCard
            ? _value.isRedCard
            : isRedCard // ignore: cast_nullable_to_non_nullable
                  as bool,
        isInjury: null == isInjury
            ? _value.isInjury
            : isInjury // ignore: cast_nullable_to_non_nullable
                  as bool,
        ratingChange: null == ratingChange
            ? _value.ratingChange
            : ratingChange // ignore: cast_nullable_to_non_nullable
                  as double,
        fatigueChange: null == fatigueChange
            ? _value.fatigueChange
            : fatigueChange // ignore: cast_nullable_to_non_nullable
                  as int,
        confidenceChange: null == confidenceChange
            ? _value.confidenceChange
            : confidenceChange // ignore: cast_nullable_to_non_nullable
                  as int,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$HighlightResultImpl implements _HighlightResult {
  const _$HighlightResultImpl({
    required this.success,
    this.isGoal = false,
    this.isAssist = false,
    this.isYellowCard = false,
    this.isRedCard = false,
    this.isInjury = false,
    this.ratingChange = 0.0,
    this.fatigueChange = 0,
    this.confidenceChange = 0,
    required this.description,
  });

  factory _$HighlightResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$HighlightResultImplFromJson(json);

  @override
  final bool success;
  // 성공 여부
  @override
  @JsonKey()
  final bool isGoal;
  // 득점 여부
  @override
  @JsonKey()
  final bool isAssist;
  // 어시스트 여부
  @override
  @JsonKey()
  final bool isYellowCard;
  // 경고
  @override
  @JsonKey()
  final bool isRedCard;
  // 퇴장
  @override
  @JsonKey()
  final bool isInjury;
  // 부상
  @override
  @JsonKey()
  final double ratingChange;
  // 평점 변화
  @override
  @JsonKey()
  final int fatigueChange;
  // 피로 변화
  @override
  @JsonKey()
  final int confidenceChange;
  // 자신감 변화
  @override
  final String description;

  @override
  String toString() {
    return 'HighlightResult(success: $success, isGoal: $isGoal, isAssist: $isAssist, isYellowCard: $isYellowCard, isRedCard: $isRedCard, isInjury: $isInjury, ratingChange: $ratingChange, fatigueChange: $fatigueChange, confidenceChange: $confidenceChange, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$HighlightResultImpl &&
            (identical(other.success, success) || other.success == success) &&
            (identical(other.isGoal, isGoal) || other.isGoal == isGoal) &&
            (identical(other.isAssist, isAssist) ||
                other.isAssist == isAssist) &&
            (identical(other.isYellowCard, isYellowCard) ||
                other.isYellowCard == isYellowCard) &&
            (identical(other.isRedCard, isRedCard) ||
                other.isRedCard == isRedCard) &&
            (identical(other.isInjury, isInjury) ||
                other.isInjury == isInjury) &&
            (identical(other.ratingChange, ratingChange) ||
                other.ratingChange == ratingChange) &&
            (identical(other.fatigueChange, fatigueChange) ||
                other.fatigueChange == fatigueChange) &&
            (identical(other.confidenceChange, confidenceChange) ||
                other.confidenceChange == confidenceChange) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    success,
    isGoal,
    isAssist,
    isYellowCard,
    isRedCard,
    isInjury,
    ratingChange,
    fatigueChange,
    confidenceChange,
    description,
  );

  /// Create a copy of HighlightResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$HighlightResultImplCopyWith<_$HighlightResultImpl> get copyWith =>
      __$$HighlightResultImplCopyWithImpl<_$HighlightResultImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$HighlightResultImplToJson(this);
  }
}

abstract class _HighlightResult implements HighlightResult {
  const factory _HighlightResult({
    required final bool success,
    final bool isGoal,
    final bool isAssist,
    final bool isYellowCard,
    final bool isRedCard,
    final bool isInjury,
    final double ratingChange,
    final int fatigueChange,
    final int confidenceChange,
    required final String description,
  }) = _$HighlightResultImpl;

  factory _HighlightResult.fromJson(Map<String, dynamic> json) =
      _$HighlightResultImpl.fromJson;

  @override
  bool get success; // 성공 여부
  @override
  bool get isGoal; // 득점 여부
  @override
  bool get isAssist; // 어시스트 여부
  @override
  bool get isYellowCard; // 경고
  @override
  bool get isRedCard; // 퇴장
  @override
  bool get isInjury; // 부상
  @override
  double get ratingChange; // 평점 변화
  @override
  int get fatigueChange; // 피로 변화
  @override
  int get confidenceChange; // 자신감 변화
  @override
  String get description;

  /// Create a copy of HighlightResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$HighlightResultImplCopyWith<_$HighlightResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LogLine _$LogLineFromJson(Map<String, dynamic> json) {
  return _LogLine.fromJson(json);
}

/// @nodoc
mixin _$LogLine {
  int? get minute => throw _privateConstructorUsedError; // 경기 시간
  LogType get type => throw _privateConstructorUsedError; // 로그 타입
  String get text => throw _privateConstructorUsedError; // 텍스트
  Map<String, String> get tags => throw _privateConstructorUsedError;

  /// Serializes this LogLine to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LogLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LogLineCopyWith<LogLine> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LogLineCopyWith<$Res> {
  factory $LogLineCopyWith(LogLine value, $Res Function(LogLine) then) =
      _$LogLineCopyWithImpl<$Res, LogLine>;
  @useResult
  $Res call({int? minute, LogType type, String text, Map<String, String> tags});
}

/// @nodoc
class _$LogLineCopyWithImpl<$Res, $Val extends LogLine>
    implements $LogLineCopyWith<$Res> {
  _$LogLineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LogLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minute = freezed,
    Object? type = null,
    Object? text = null,
    Object? tags = null,
  }) {
    return _then(
      _value.copyWith(
            minute: freezed == minute
                ? _value.minute
                : minute // ignore: cast_nullable_to_non_nullable
                      as int?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as LogType,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as Map<String, String>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LogLineImplCopyWith<$Res> implements $LogLineCopyWith<$Res> {
  factory _$$LogLineImplCopyWith(
    _$LogLineImpl value,
    $Res Function(_$LogLineImpl) then,
  ) = __$$LogLineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? minute, LogType type, String text, Map<String, String> tags});
}

/// @nodoc
class __$$LogLineImplCopyWithImpl<$Res>
    extends _$LogLineCopyWithImpl<$Res, _$LogLineImpl>
    implements _$$LogLineImplCopyWith<$Res> {
  __$$LogLineImplCopyWithImpl(
    _$LogLineImpl _value,
    $Res Function(_$LogLineImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LogLine
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? minute = freezed,
    Object? type = null,
    Object? text = null,
    Object? tags = null,
  }) {
    return _then(
      _$LogLineImpl(
        minute: freezed == minute
            ? _value.minute
            : minute // ignore: cast_nullable_to_non_nullable
                  as int?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as LogType,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as Map<String, String>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LogLineImpl implements _LogLine {
  const _$LogLineImpl({
    this.minute,
    required this.type,
    required this.text,
    final Map<String, String> tags = const {},
  }) : _tags = tags;

  factory _$LogLineImpl.fromJson(Map<String, dynamic> json) =>
      _$$LogLineImplFromJson(json);

  @override
  final int? minute;
  // 경기 시간
  @override
  final LogType type;
  // 로그 타입
  @override
  final String text;
  // 텍스트
  final Map<String, String> _tags;
  // 텍스트
  @override
  @JsonKey()
  Map<String, String> get tags {
    if (_tags is EqualUnmodifiableMapView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_tags);
  }

  @override
  String toString() {
    return 'LogLine(minute: $minute, type: $type, text: $text, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LogLineImpl &&
            (identical(other.minute, minute) || other.minute == minute) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._tags, _tags));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    minute,
    type,
    text,
    const DeepCollectionEquality().hash(_tags),
  );

  /// Create a copy of LogLine
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LogLineImplCopyWith<_$LogLineImpl> get copyWith =>
      __$$LogLineImplCopyWithImpl<_$LogLineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LogLineImplToJson(this);
  }
}

abstract class _LogLine implements LogLine {
  const factory _LogLine({
    final int? minute,
    required final LogType type,
    required final String text,
    final Map<String, String> tags,
  }) = _$LogLineImpl;

  factory _LogLine.fromJson(Map<String, dynamic> json) = _$LogLineImpl.fromJson;

  @override
  int? get minute; // 경기 시간
  @override
  LogType get type; // 로그 타입
  @override
  String get text; // 텍스트
  @override
  Map<String, String> get tags;

  /// Create a copy of LogLine
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LogLineImplCopyWith<_$LogLineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Score _$ScoreFromJson(Map<String, dynamic> json) {
  return _Score.fromJson(json);
}

/// @nodoc
mixin _$Score {
  int get home => throw _privateConstructorUsedError;
  int get away => throw _privateConstructorUsedError;

  /// Serializes this Score to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ScoreCopyWith<Score> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScoreCopyWith<$Res> {
  factory $ScoreCopyWith(Score value, $Res Function(Score) then) =
      _$ScoreCopyWithImpl<$Res, Score>;
  @useResult
  $Res call({int home, int away});
}

/// @nodoc
class _$ScoreCopyWithImpl<$Res, $Val extends Score>
    implements $ScoreCopyWith<$Res> {
  _$ScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? home = null, Object? away = null}) {
    return _then(
      _value.copyWith(
            home: null == home
                ? _value.home
                : home // ignore: cast_nullable_to_non_nullable
                      as int,
            away: null == away
                ? _value.away
                : away // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ScoreImplCopyWith<$Res> implements $ScoreCopyWith<$Res> {
  factory _$$ScoreImplCopyWith(
    _$ScoreImpl value,
    $Res Function(_$ScoreImpl) then,
  ) = __$$ScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int home, int away});
}

/// @nodoc
class __$$ScoreImplCopyWithImpl<$Res>
    extends _$ScoreCopyWithImpl<$Res, _$ScoreImpl>
    implements _$$ScoreImplCopyWith<$Res> {
  __$$ScoreImplCopyWithImpl(
    _$ScoreImpl _value,
    $Res Function(_$ScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? home = null, Object? away = null}) {
    return _then(
      _$ScoreImpl(
        home: null == home
            ? _value.home
            : home // ignore: cast_nullable_to_non_nullable
                  as int,
        away: null == away
            ? _value.away
            : away // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ScoreImpl implements _Score {
  const _$ScoreImpl({this.home = 0, this.away = 0});

  factory _$ScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$ScoreImplFromJson(json);

  @override
  @JsonKey()
  final int home;
  @override
  @JsonKey()
  final int away;

  @override
  String toString() {
    return 'Score(home: $home, away: $away)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ScoreImpl &&
            (identical(other.home, home) || other.home == home) &&
            (identical(other.away, away) || other.away == away));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, home, away);

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ScoreImplCopyWith<_$ScoreImpl> get copyWith =>
      __$$ScoreImplCopyWithImpl<_$ScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ScoreImplToJson(this);
  }
}

abstract class _Score implements Score {
  const factory _Score({final int home, final int away}) = _$ScoreImpl;

  factory _Score.fromJson(Map<String, dynamic> json) = _$ScoreImpl.fromJson;

  @override
  int get home;
  @override
  int get away;

  /// Create a copy of Score
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ScoreImplCopyWith<_$ScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

RatingAccumulator _$RatingAccumulatorFromJson(Map<String, dynamic> json) {
  return _RatingAccumulator.fromJson(json);
}

/// @nodoc
mixin _$RatingAccumulator {
  int get goals => throw _privateConstructorUsedError; // 득점
  int get assists => throw _privateConstructorUsedError; // 어시스트
  int get shotsOnTarget => throw _privateConstructorUsedError; // 유효슈팅
  int get keyPasses => throw _privateConstructorUsedError; // 키패스
  int get successfulPresses => throw _privateConstructorUsedError; // 압박 성공
  int get chanceMissed => throw _privateConstructorUsedError; // 결정적 찬스 실패
  int get possessionLost => throw _privateConstructorUsedError; // 소유권 상실
  int get yellowCards => throw _privateConstructorUsedError; // 경고
  int get redCards => throw _privateConstructorUsedError;

  /// Serializes this RatingAccumulator to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RatingAccumulator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RatingAccumulatorCopyWith<RatingAccumulator> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RatingAccumulatorCopyWith<$Res> {
  factory $RatingAccumulatorCopyWith(
    RatingAccumulator value,
    $Res Function(RatingAccumulator) then,
  ) = _$RatingAccumulatorCopyWithImpl<$Res, RatingAccumulator>;
  @useResult
  $Res call({
    int goals,
    int assists,
    int shotsOnTarget,
    int keyPasses,
    int successfulPresses,
    int chanceMissed,
    int possessionLost,
    int yellowCards,
    int redCards,
  });
}

/// @nodoc
class _$RatingAccumulatorCopyWithImpl<$Res, $Val extends RatingAccumulator>
    implements $RatingAccumulatorCopyWith<$Res> {
  _$RatingAccumulatorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RatingAccumulator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goals = null,
    Object? assists = null,
    Object? shotsOnTarget = null,
    Object? keyPasses = null,
    Object? successfulPresses = null,
    Object? chanceMissed = null,
    Object? possessionLost = null,
    Object? yellowCards = null,
    Object? redCards = null,
  }) {
    return _then(
      _value.copyWith(
            goals: null == goals
                ? _value.goals
                : goals // ignore: cast_nullable_to_non_nullable
                      as int,
            assists: null == assists
                ? _value.assists
                : assists // ignore: cast_nullable_to_non_nullable
                      as int,
            shotsOnTarget: null == shotsOnTarget
                ? _value.shotsOnTarget
                : shotsOnTarget // ignore: cast_nullable_to_non_nullable
                      as int,
            keyPasses: null == keyPasses
                ? _value.keyPasses
                : keyPasses // ignore: cast_nullable_to_non_nullable
                      as int,
            successfulPresses: null == successfulPresses
                ? _value.successfulPresses
                : successfulPresses // ignore: cast_nullable_to_non_nullable
                      as int,
            chanceMissed: null == chanceMissed
                ? _value.chanceMissed
                : chanceMissed // ignore: cast_nullable_to_non_nullable
                      as int,
            possessionLost: null == possessionLost
                ? _value.possessionLost
                : possessionLost // ignore: cast_nullable_to_non_nullable
                      as int,
            yellowCards: null == yellowCards
                ? _value.yellowCards
                : yellowCards // ignore: cast_nullable_to_non_nullable
                      as int,
            redCards: null == redCards
                ? _value.redCards
                : redCards // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RatingAccumulatorImplCopyWith<$Res>
    implements $RatingAccumulatorCopyWith<$Res> {
  factory _$$RatingAccumulatorImplCopyWith(
    _$RatingAccumulatorImpl value,
    $Res Function(_$RatingAccumulatorImpl) then,
  ) = __$$RatingAccumulatorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int goals,
    int assists,
    int shotsOnTarget,
    int keyPasses,
    int successfulPresses,
    int chanceMissed,
    int possessionLost,
    int yellowCards,
    int redCards,
  });
}

/// @nodoc
class __$$RatingAccumulatorImplCopyWithImpl<$Res>
    extends _$RatingAccumulatorCopyWithImpl<$Res, _$RatingAccumulatorImpl>
    implements _$$RatingAccumulatorImplCopyWith<$Res> {
  __$$RatingAccumulatorImplCopyWithImpl(
    _$RatingAccumulatorImpl _value,
    $Res Function(_$RatingAccumulatorImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RatingAccumulator
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? goals = null,
    Object? assists = null,
    Object? shotsOnTarget = null,
    Object? keyPasses = null,
    Object? successfulPresses = null,
    Object? chanceMissed = null,
    Object? possessionLost = null,
    Object? yellowCards = null,
    Object? redCards = null,
  }) {
    return _then(
      _$RatingAccumulatorImpl(
        goals: null == goals
            ? _value.goals
            : goals // ignore: cast_nullable_to_non_nullable
                  as int,
        assists: null == assists
            ? _value.assists
            : assists // ignore: cast_nullable_to_non_nullable
                  as int,
        shotsOnTarget: null == shotsOnTarget
            ? _value.shotsOnTarget
            : shotsOnTarget // ignore: cast_nullable_to_non_nullable
                  as int,
        keyPasses: null == keyPasses
            ? _value.keyPasses
            : keyPasses // ignore: cast_nullable_to_non_nullable
                  as int,
        successfulPresses: null == successfulPresses
            ? _value.successfulPresses
            : successfulPresses // ignore: cast_nullable_to_non_nullable
                  as int,
        chanceMissed: null == chanceMissed
            ? _value.chanceMissed
            : chanceMissed // ignore: cast_nullable_to_non_nullable
                  as int,
        possessionLost: null == possessionLost
            ? _value.possessionLost
            : possessionLost // ignore: cast_nullable_to_non_nullable
                  as int,
        yellowCards: null == yellowCards
            ? _value.yellowCards
            : yellowCards // ignore: cast_nullable_to_non_nullable
                  as int,
        redCards: null == redCards
            ? _value.redCards
            : redCards // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RatingAccumulatorImpl implements _RatingAccumulator {
  const _$RatingAccumulatorImpl({
    this.goals = 0,
    this.assists = 0,
    this.shotsOnTarget = 0,
    this.keyPasses = 0,
    this.successfulPresses = 0,
    this.chanceMissed = 0,
    this.possessionLost = 0,
    this.yellowCards = 0,
    this.redCards = 0,
  });

  factory _$RatingAccumulatorImpl.fromJson(Map<String, dynamic> json) =>
      _$$RatingAccumulatorImplFromJson(json);

  @override
  @JsonKey()
  final int goals;
  // 득점
  @override
  @JsonKey()
  final int assists;
  // 어시스트
  @override
  @JsonKey()
  final int shotsOnTarget;
  // 유효슈팅
  @override
  @JsonKey()
  final int keyPasses;
  // 키패스
  @override
  @JsonKey()
  final int successfulPresses;
  // 압박 성공
  @override
  @JsonKey()
  final int chanceMissed;
  // 결정적 찬스 실패
  @override
  @JsonKey()
  final int possessionLost;
  // 소유권 상실
  @override
  @JsonKey()
  final int yellowCards;
  // 경고
  @override
  @JsonKey()
  final int redCards;

  @override
  String toString() {
    return 'RatingAccumulator(goals: $goals, assists: $assists, shotsOnTarget: $shotsOnTarget, keyPasses: $keyPasses, successfulPresses: $successfulPresses, chanceMissed: $chanceMissed, possessionLost: $possessionLost, yellowCards: $yellowCards, redCards: $redCards)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RatingAccumulatorImpl &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.assists, assists) || other.assists == assists) &&
            (identical(other.shotsOnTarget, shotsOnTarget) ||
                other.shotsOnTarget == shotsOnTarget) &&
            (identical(other.keyPasses, keyPasses) ||
                other.keyPasses == keyPasses) &&
            (identical(other.successfulPresses, successfulPresses) ||
                other.successfulPresses == successfulPresses) &&
            (identical(other.chanceMissed, chanceMissed) ||
                other.chanceMissed == chanceMissed) &&
            (identical(other.possessionLost, possessionLost) ||
                other.possessionLost == possessionLost) &&
            (identical(other.yellowCards, yellowCards) ||
                other.yellowCards == yellowCards) &&
            (identical(other.redCards, redCards) ||
                other.redCards == redCards));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    goals,
    assists,
    shotsOnTarget,
    keyPasses,
    successfulPresses,
    chanceMissed,
    possessionLost,
    yellowCards,
    redCards,
  );

  /// Create a copy of RatingAccumulator
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RatingAccumulatorImplCopyWith<_$RatingAccumulatorImpl> get copyWith =>
      __$$RatingAccumulatorImplCopyWithImpl<_$RatingAccumulatorImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$RatingAccumulatorImplToJson(this);
  }
}

abstract class _RatingAccumulator implements RatingAccumulator {
  const factory _RatingAccumulator({
    final int goals,
    final int assists,
    final int shotsOnTarget,
    final int keyPasses,
    final int successfulPresses,
    final int chanceMissed,
    final int possessionLost,
    final int yellowCards,
    final int redCards,
  }) = _$RatingAccumulatorImpl;

  factory _RatingAccumulator.fromJson(Map<String, dynamic> json) =
      _$RatingAccumulatorImpl.fromJson;

  @override
  int get goals; // 득점
  @override
  int get assists; // 어시스트
  @override
  int get shotsOnTarget; // 유효슈팅
  @override
  int get keyPasses; // 키패스
  @override
  int get successfulPresses; // 압박 성공
  @override
  int get chanceMissed; // 결정적 찬스 실패
  @override
  int get possessionLost; // 소유권 상실
  @override
  int get yellowCards; // 경고
  @override
  int get redCards;

  /// Create a copy of RatingAccumulator
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RatingAccumulatorImplCopyWith<_$RatingAccumulatorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchSession _$MatchSessionFromJson(Map<String, dynamic> json) {
  return _MatchSession.fromJson(json);
}

/// @nodoc
mixin _$MatchSession {
  String get id => throw _privateConstructorUsedError;
  String get fixtureId => throw _privateConstructorUsedError;
  String get homeTeamId => throw _privateConstructorUsedError;
  String get awayTeamId => throw _privateConstructorUsedError;
  bool get isHome => throw _privateConstructorUsedError; // PC 팀이 홈인지
  MatchPhase get phase => throw _privateConstructorUsedError; // 현재 단계
  int get minute => throw _privateConstructorUsedError; // 현재 시간
  Score get score => throw _privateConstructorUsedError; // 스코어
  List<HighlightEvent> get highlights =>
      throw _privateConstructorUsedError; // 하이라이트 목록
  int get currentHighlightIndex =>
      throw _privateConstructorUsedError; // 현재 하이라이트 인덱스
  List<LogLine> get log => throw _privateConstructorUsedError; // 경기 로그
  RatingAccumulator get ratingAccumulator =>
      throw _privateConstructorUsedError; // 평점 누적
  int get rngSeed => throw _privateConstructorUsedError; // 랜덤 시드
  int get momentum => throw _privateConstructorUsedError; // 모멘텀 (-3 ~ +3)
  int get consecutiveSuccess => throw _privateConstructorUsedError;

  /// Serializes this MatchSession to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchSessionCopyWith<MatchSession> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchSessionCopyWith<$Res> {
  factory $MatchSessionCopyWith(
    MatchSession value,
    $Res Function(MatchSession) then,
  ) = _$MatchSessionCopyWithImpl<$Res, MatchSession>;
  @useResult
  $Res call({
    String id,
    String fixtureId,
    String homeTeamId,
    String awayTeamId,
    bool isHome,
    MatchPhase phase,
    int minute,
    Score score,
    List<HighlightEvent> highlights,
    int currentHighlightIndex,
    List<LogLine> log,
    RatingAccumulator ratingAccumulator,
    int rngSeed,
    int momentum,
    int consecutiveSuccess,
  });

  $ScoreCopyWith<$Res> get score;
  $RatingAccumulatorCopyWith<$Res> get ratingAccumulator;
}

/// @nodoc
class _$MatchSessionCopyWithImpl<$Res, $Val extends MatchSession>
    implements $MatchSessionCopyWith<$Res> {
  _$MatchSessionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fixtureId = null,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? isHome = null,
    Object? phase = null,
    Object? minute = null,
    Object? score = null,
    Object? highlights = null,
    Object? currentHighlightIndex = null,
    Object? log = null,
    Object? ratingAccumulator = null,
    Object? rngSeed = null,
    Object? momentum = null,
    Object? consecutiveSuccess = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            fixtureId: null == fixtureId
                ? _value.fixtureId
                : fixtureId // ignore: cast_nullable_to_non_nullable
                      as String,
            homeTeamId: null == homeTeamId
                ? _value.homeTeamId
                : homeTeamId // ignore: cast_nullable_to_non_nullable
                      as String,
            awayTeamId: null == awayTeamId
                ? _value.awayTeamId
                : awayTeamId // ignore: cast_nullable_to_non_nullable
                      as String,
            isHome: null == isHome
                ? _value.isHome
                : isHome // ignore: cast_nullable_to_non_nullable
                      as bool,
            phase: null == phase
                ? _value.phase
                : phase // ignore: cast_nullable_to_non_nullable
                      as MatchPhase,
            minute: null == minute
                ? _value.minute
                : minute // ignore: cast_nullable_to_non_nullable
                      as int,
            score: null == score
                ? _value.score
                : score // ignore: cast_nullable_to_non_nullable
                      as Score,
            highlights: null == highlights
                ? _value.highlights
                : highlights // ignore: cast_nullable_to_non_nullable
                      as List<HighlightEvent>,
            currentHighlightIndex: null == currentHighlightIndex
                ? _value.currentHighlightIndex
                : currentHighlightIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            log: null == log
                ? _value.log
                : log // ignore: cast_nullable_to_non_nullable
                      as List<LogLine>,
            ratingAccumulator: null == ratingAccumulator
                ? _value.ratingAccumulator
                : ratingAccumulator // ignore: cast_nullable_to_non_nullable
                      as RatingAccumulator,
            rngSeed: null == rngSeed
                ? _value.rngSeed
                : rngSeed // ignore: cast_nullable_to_non_nullable
                      as int,
            momentum: null == momentum
                ? _value.momentum
                : momentum // ignore: cast_nullable_to_non_nullable
                      as int,
            consecutiveSuccess: null == consecutiveSuccess
                ? _value.consecutiveSuccess
                : consecutiveSuccess // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of MatchSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ScoreCopyWith<$Res> get score {
    return $ScoreCopyWith<$Res>(_value.score, (value) {
      return _then(_value.copyWith(score: value) as $Val);
    });
  }

  /// Create a copy of MatchSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $RatingAccumulatorCopyWith<$Res> get ratingAccumulator {
    return $RatingAccumulatorCopyWith<$Res>(_value.ratingAccumulator, (value) {
      return _then(_value.copyWith(ratingAccumulator: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$MatchSessionImplCopyWith<$Res>
    implements $MatchSessionCopyWith<$Res> {
  factory _$$MatchSessionImplCopyWith(
    _$MatchSessionImpl value,
    $Res Function(_$MatchSessionImpl) then,
  ) = __$$MatchSessionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String fixtureId,
    String homeTeamId,
    String awayTeamId,
    bool isHome,
    MatchPhase phase,
    int minute,
    Score score,
    List<HighlightEvent> highlights,
    int currentHighlightIndex,
    List<LogLine> log,
    RatingAccumulator ratingAccumulator,
    int rngSeed,
    int momentum,
    int consecutiveSuccess,
  });

  @override
  $ScoreCopyWith<$Res> get score;
  @override
  $RatingAccumulatorCopyWith<$Res> get ratingAccumulator;
}

/// @nodoc
class __$$MatchSessionImplCopyWithImpl<$Res>
    extends _$MatchSessionCopyWithImpl<$Res, _$MatchSessionImpl>
    implements _$$MatchSessionImplCopyWith<$Res> {
  __$$MatchSessionImplCopyWithImpl(
    _$MatchSessionImpl _value,
    $Res Function(_$MatchSessionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MatchSession
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fixtureId = null,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? isHome = null,
    Object? phase = null,
    Object? minute = null,
    Object? score = null,
    Object? highlights = null,
    Object? currentHighlightIndex = null,
    Object? log = null,
    Object? ratingAccumulator = null,
    Object? rngSeed = null,
    Object? momentum = null,
    Object? consecutiveSuccess = null,
  }) {
    return _then(
      _$MatchSessionImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        fixtureId: null == fixtureId
            ? _value.fixtureId
            : fixtureId // ignore: cast_nullable_to_non_nullable
                  as String,
        homeTeamId: null == homeTeamId
            ? _value.homeTeamId
            : homeTeamId // ignore: cast_nullable_to_non_nullable
                  as String,
        awayTeamId: null == awayTeamId
            ? _value.awayTeamId
            : awayTeamId // ignore: cast_nullable_to_non_nullable
                  as String,
        isHome: null == isHome
            ? _value.isHome
            : isHome // ignore: cast_nullable_to_non_nullable
                  as bool,
        phase: null == phase
            ? _value.phase
            : phase // ignore: cast_nullable_to_non_nullable
                  as MatchPhase,
        minute: null == minute
            ? _value.minute
            : minute // ignore: cast_nullable_to_non_nullable
                  as int,
        score: null == score
            ? _value.score
            : score // ignore: cast_nullable_to_non_nullable
                  as Score,
        highlights: null == highlights
            ? _value._highlights
            : highlights // ignore: cast_nullable_to_non_nullable
                  as List<HighlightEvent>,
        currentHighlightIndex: null == currentHighlightIndex
            ? _value.currentHighlightIndex
            : currentHighlightIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        log: null == log
            ? _value._log
            : log // ignore: cast_nullable_to_non_nullable
                  as List<LogLine>,
        ratingAccumulator: null == ratingAccumulator
            ? _value.ratingAccumulator
            : ratingAccumulator // ignore: cast_nullable_to_non_nullable
                  as RatingAccumulator,
        rngSeed: null == rngSeed
            ? _value.rngSeed
            : rngSeed // ignore: cast_nullable_to_non_nullable
                  as int,
        momentum: null == momentum
            ? _value.momentum
            : momentum // ignore: cast_nullable_to_non_nullable
                  as int,
        consecutiveSuccess: null == consecutiveSuccess
            ? _value.consecutiveSuccess
            : consecutiveSuccess // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchSessionImpl implements _MatchSession {
  const _$MatchSessionImpl({
    required this.id,
    required this.fixtureId,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.isHome,
    this.phase = MatchPhase.intro,
    this.minute = 0,
    this.score = const Score(),
    final List<HighlightEvent> highlights = const [],
    this.currentHighlightIndex = 0,
    final List<LogLine> log = const [],
    this.ratingAccumulator = const RatingAccumulator(),
    required this.rngSeed,
    this.momentum = 0,
    this.consecutiveSuccess = 0,
  }) : _highlights = highlights,
       _log = log;

  factory _$MatchSessionImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchSessionImplFromJson(json);

  @override
  final String id;
  @override
  final String fixtureId;
  @override
  final String homeTeamId;
  @override
  final String awayTeamId;
  @override
  final bool isHome;
  // PC 팀이 홈인지
  @override
  @JsonKey()
  final MatchPhase phase;
  // 현재 단계
  @override
  @JsonKey()
  final int minute;
  // 현재 시간
  @override
  @JsonKey()
  final Score score;
  // 스코어
  final List<HighlightEvent> _highlights;
  // 스코어
  @override
  @JsonKey()
  List<HighlightEvent> get highlights {
    if (_highlights is EqualUnmodifiableListView) return _highlights;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_highlights);
  }

  // 하이라이트 목록
  @override
  @JsonKey()
  final int currentHighlightIndex;
  // 현재 하이라이트 인덱스
  final List<LogLine> _log;
  // 현재 하이라이트 인덱스
  @override
  @JsonKey()
  List<LogLine> get log {
    if (_log is EqualUnmodifiableListView) return _log;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_log);
  }

  // 경기 로그
  @override
  @JsonKey()
  final RatingAccumulator ratingAccumulator;
  // 평점 누적
  @override
  final int rngSeed;
  // 랜덤 시드
  @override
  @JsonKey()
  final int momentum;
  // 모멘텀 (-3 ~ +3)
  @override
  @JsonKey()
  final int consecutiveSuccess;

  @override
  String toString() {
    return 'MatchSession(id: $id, fixtureId: $fixtureId, homeTeamId: $homeTeamId, awayTeamId: $awayTeamId, isHome: $isHome, phase: $phase, minute: $minute, score: $score, highlights: $highlights, currentHighlightIndex: $currentHighlightIndex, log: $log, ratingAccumulator: $ratingAccumulator, rngSeed: $rngSeed, momentum: $momentum, consecutiveSuccess: $consecutiveSuccess)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchSessionImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fixtureId, fixtureId) ||
                other.fixtureId == fixtureId) &&
            (identical(other.homeTeamId, homeTeamId) ||
                other.homeTeamId == homeTeamId) &&
            (identical(other.awayTeamId, awayTeamId) ||
                other.awayTeamId == awayTeamId) &&
            (identical(other.isHome, isHome) || other.isHome == isHome) &&
            (identical(other.phase, phase) || other.phase == phase) &&
            (identical(other.minute, minute) || other.minute == minute) &&
            (identical(other.score, score) || other.score == score) &&
            const DeepCollectionEquality().equals(
              other._highlights,
              _highlights,
            ) &&
            (identical(other.currentHighlightIndex, currentHighlightIndex) ||
                other.currentHighlightIndex == currentHighlightIndex) &&
            const DeepCollectionEquality().equals(other._log, _log) &&
            (identical(other.ratingAccumulator, ratingAccumulator) ||
                other.ratingAccumulator == ratingAccumulator) &&
            (identical(other.rngSeed, rngSeed) || other.rngSeed == rngSeed) &&
            (identical(other.momentum, momentum) ||
                other.momentum == momentum) &&
            (identical(other.consecutiveSuccess, consecutiveSuccess) ||
                other.consecutiveSuccess == consecutiveSuccess));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    fixtureId,
    homeTeamId,
    awayTeamId,
    isHome,
    phase,
    minute,
    score,
    const DeepCollectionEquality().hash(_highlights),
    currentHighlightIndex,
    const DeepCollectionEquality().hash(_log),
    ratingAccumulator,
    rngSeed,
    momentum,
    consecutiveSuccess,
  );

  /// Create a copy of MatchSession
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchSessionImplCopyWith<_$MatchSessionImpl> get copyWith =>
      __$$MatchSessionImplCopyWithImpl<_$MatchSessionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchSessionImplToJson(this);
  }
}

abstract class _MatchSession implements MatchSession {
  const factory _MatchSession({
    required final String id,
    required final String fixtureId,
    required final String homeTeamId,
    required final String awayTeamId,
    required final bool isHome,
    final MatchPhase phase,
    final int minute,
    final Score score,
    final List<HighlightEvent> highlights,
    final int currentHighlightIndex,
    final List<LogLine> log,
    final RatingAccumulator ratingAccumulator,
    required final int rngSeed,
    final int momentum,
    final int consecutiveSuccess,
  }) = _$MatchSessionImpl;

  factory _MatchSession.fromJson(Map<String, dynamic> json) =
      _$MatchSessionImpl.fromJson;

  @override
  String get id;
  @override
  String get fixtureId;
  @override
  String get homeTeamId;
  @override
  String get awayTeamId;
  @override
  bool get isHome; // PC 팀이 홈인지
  @override
  MatchPhase get phase; // 현재 단계
  @override
  int get minute; // 현재 시간
  @override
  Score get score; // 스코어
  @override
  List<HighlightEvent> get highlights; // 하이라이트 목록
  @override
  int get currentHighlightIndex; // 현재 하이라이트 인덱스
  @override
  List<LogLine> get log; // 경기 로그
  @override
  RatingAccumulator get ratingAccumulator; // 평점 누적
  @override
  int get rngSeed; // 랜덤 시드
  @override
  int get momentum; // 모멘텀 (-3 ~ +3)
  @override
  int get consecutiveSuccess;

  /// Create a copy of MatchSession
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchSessionImplCopyWith<_$MatchSessionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
