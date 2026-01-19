// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'player.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PlayerProfile _$PlayerProfileFromJson(Map<String, dynamic> json) {
  return _PlayerProfile.fromJson(json);
}

/// @nodoc
mixin _$PlayerProfile {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get age => throw _privateConstructorUsedError;
  PlayerArchetype get archetype => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;

  /// Serializes this PlayerProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerProfileCopyWith<PlayerProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerProfileCopyWith<$Res> {
  factory $PlayerProfileCopyWith(
    PlayerProfile value,
    $Res Function(PlayerProfile) then,
  ) = _$PlayerProfileCopyWithImpl<$Res, PlayerProfile>;
  @useResult
  $Res call({
    String id,
    String name,
    int age,
    PlayerArchetype archetype,
    String teamId,
  });
}

/// @nodoc
class _$PlayerProfileCopyWithImpl<$Res, $Val extends PlayerProfile>
    implements $PlayerProfileCopyWith<$Res> {
  _$PlayerProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? archetype = null,
    Object? teamId = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            age: null == age
                ? _value.age
                : age // ignore: cast_nullable_to_non_nullable
                      as int,
            archetype: null == archetype
                ? _value.archetype
                : archetype // ignore: cast_nullable_to_non_nullable
                      as PlayerArchetype,
            teamId: null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlayerProfileImplCopyWith<$Res>
    implements $PlayerProfileCopyWith<$Res> {
  factory _$$PlayerProfileImplCopyWith(
    _$PlayerProfileImpl value,
    $Res Function(_$PlayerProfileImpl) then,
  ) = __$$PlayerProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int age,
    PlayerArchetype archetype,
    String teamId,
  });
}

/// @nodoc
class __$$PlayerProfileImplCopyWithImpl<$Res>
    extends _$PlayerProfileCopyWithImpl<$Res, _$PlayerProfileImpl>
    implements _$$PlayerProfileImplCopyWith<$Res> {
  __$$PlayerProfileImplCopyWithImpl(
    _$PlayerProfileImpl _value,
    $Res Function(_$PlayerProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? age = null,
    Object? archetype = null,
    Object? teamId = null,
  }) {
    return _then(
      _$PlayerProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        age: null == age
            ? _value.age
            : age // ignore: cast_nullable_to_non_nullable
                  as int,
        archetype: null == archetype
            ? _value.archetype
            : archetype // ignore: cast_nullable_to_non_nullable
                  as PlayerArchetype,
        teamId: null == teamId
            ? _value.teamId
            : teamId // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerProfileImpl implements _PlayerProfile {
  const _$PlayerProfileImpl({
    required this.id,
    required this.name,
    required this.age,
    required this.archetype,
    required this.teamId,
  });

  factory _$PlayerProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int age;
  @override
  final PlayerArchetype archetype;
  @override
  final String teamId;

  @override
  String toString() {
    return 'PlayerProfile(id: $id, name: $name, age: $age, archetype: $archetype, teamId: $teamId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.age, age) || other.age == age) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.teamId, teamId) || other.teamId == teamId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, age, archetype, teamId);

  /// Create a copy of PlayerProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerProfileImplCopyWith<_$PlayerProfileImpl> get copyWith =>
      __$$PlayerProfileImplCopyWithImpl<_$PlayerProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerProfileImplToJson(this);
  }
}

abstract class _PlayerProfile implements PlayerProfile {
  const factory _PlayerProfile({
    required final String id,
    required final String name,
    required final int age,
    required final PlayerArchetype archetype,
    required final String teamId,
  }) = _$PlayerProfileImpl;

  factory _PlayerProfile.fromJson(Map<String, dynamic> json) =
      _$PlayerProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get age;
  @override
  PlayerArchetype get archetype;
  @override
  String get teamId;

  /// Create a copy of PlayerProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerProfileImplCopyWith<_$PlayerProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerStats _$PlayerStatsFromJson(Map<String, dynamic> json) {
  return _PlayerStats.fromJson(json);
}

/// @nodoc
mixin _$PlayerStats {
  int get pace => throw _privateConstructorUsedError; // 속도
  int get shooting => throw _privateConstructorUsedError; // 슈팅
  int get passing => throw _privateConstructorUsedError; // 패스
  int get ballControl => throw _privateConstructorUsedError; // 볼 컨트롤
  int get positioning => throw _privateConstructorUsedError; // 위치 선정
  int get stamina => throw _privateConstructorUsedError; // 체력
  int get composure => throw _privateConstructorUsedError;

  /// Serializes this PlayerStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStatsCopyWith<PlayerStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatsCopyWith<$Res> {
  factory $PlayerStatsCopyWith(
    PlayerStats value,
    $Res Function(PlayerStats) then,
  ) = _$PlayerStatsCopyWithImpl<$Res, PlayerStats>;
  @useResult
  $Res call({
    int pace,
    int shooting,
    int passing,
    int ballControl,
    int positioning,
    int stamina,
    int composure,
  });
}

/// @nodoc
class _$PlayerStatsCopyWithImpl<$Res, $Val extends PlayerStats>
    implements $PlayerStatsCopyWith<$Res> {
  _$PlayerStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pace = null,
    Object? shooting = null,
    Object? passing = null,
    Object? ballControl = null,
    Object? positioning = null,
    Object? stamina = null,
    Object? composure = null,
  }) {
    return _then(
      _value.copyWith(
            pace: null == pace
                ? _value.pace
                : pace // ignore: cast_nullable_to_non_nullable
                      as int,
            shooting: null == shooting
                ? _value.shooting
                : shooting // ignore: cast_nullable_to_non_nullable
                      as int,
            passing: null == passing
                ? _value.passing
                : passing // ignore: cast_nullable_to_non_nullable
                      as int,
            ballControl: null == ballControl
                ? _value.ballControl
                : ballControl // ignore: cast_nullable_to_non_nullable
                      as int,
            positioning: null == positioning
                ? _value.positioning
                : positioning // ignore: cast_nullable_to_non_nullable
                      as int,
            stamina: null == stamina
                ? _value.stamina
                : stamina // ignore: cast_nullable_to_non_nullable
                      as int,
            composure: null == composure
                ? _value.composure
                : composure // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlayerStatsImplCopyWith<$Res>
    implements $PlayerStatsCopyWith<$Res> {
  factory _$$PlayerStatsImplCopyWith(
    _$PlayerStatsImpl value,
    $Res Function(_$PlayerStatsImpl) then,
  ) = __$$PlayerStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int pace,
    int shooting,
    int passing,
    int ballControl,
    int positioning,
    int stamina,
    int composure,
  });
}

/// @nodoc
class __$$PlayerStatsImplCopyWithImpl<$Res>
    extends _$PlayerStatsCopyWithImpl<$Res, _$PlayerStatsImpl>
    implements _$$PlayerStatsImplCopyWith<$Res> {
  __$$PlayerStatsImplCopyWithImpl(
    _$PlayerStatsImpl _value,
    $Res Function(_$PlayerStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pace = null,
    Object? shooting = null,
    Object? passing = null,
    Object? ballControl = null,
    Object? positioning = null,
    Object? stamina = null,
    Object? composure = null,
  }) {
    return _then(
      _$PlayerStatsImpl(
        pace: null == pace
            ? _value.pace
            : pace // ignore: cast_nullable_to_non_nullable
                  as int,
        shooting: null == shooting
            ? _value.shooting
            : shooting // ignore: cast_nullable_to_non_nullable
                  as int,
        passing: null == passing
            ? _value.passing
            : passing // ignore: cast_nullable_to_non_nullable
                  as int,
        ballControl: null == ballControl
            ? _value.ballControl
            : ballControl // ignore: cast_nullable_to_non_nullable
                  as int,
        positioning: null == positioning
            ? _value.positioning
            : positioning // ignore: cast_nullable_to_non_nullable
                  as int,
        stamina: null == stamina
            ? _value.stamina
            : stamina // ignore: cast_nullable_to_non_nullable
                  as int,
        composure: null == composure
            ? _value.composure
            : composure // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStatsImpl implements _PlayerStats {
  const _$PlayerStatsImpl({
    this.pace = 50,
    this.shooting = 50,
    this.passing = 50,
    this.ballControl = 50,
    this.positioning = 50,
    this.stamina = 50,
    this.composure = 50,
  });

  factory _$PlayerStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStatsImplFromJson(json);

  @override
  @JsonKey()
  final int pace;
  // 속도
  @override
  @JsonKey()
  final int shooting;
  // 슈팅
  @override
  @JsonKey()
  final int passing;
  // 패스
  @override
  @JsonKey()
  final int ballControl;
  // 볼 컨트롤
  @override
  @JsonKey()
  final int positioning;
  // 위치 선정
  @override
  @JsonKey()
  final int stamina;
  // 체력
  @override
  @JsonKey()
  final int composure;

  @override
  String toString() {
    return 'PlayerStats(pace: $pace, shooting: $shooting, passing: $passing, ballControl: $ballControl, positioning: $positioning, stamina: $stamina, composure: $composure)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatsImpl &&
            (identical(other.pace, pace) || other.pace == pace) &&
            (identical(other.shooting, shooting) ||
                other.shooting == shooting) &&
            (identical(other.passing, passing) || other.passing == passing) &&
            (identical(other.ballControl, ballControl) ||
                other.ballControl == ballControl) &&
            (identical(other.positioning, positioning) ||
                other.positioning == positioning) &&
            (identical(other.stamina, stamina) || other.stamina == stamina) &&
            (identical(other.composure, composure) ||
                other.composure == composure));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    pace,
    shooting,
    passing,
    ballControl,
    positioning,
    stamina,
    composure,
  );

  /// Create a copy of PlayerStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatsImplCopyWith<_$PlayerStatsImpl> get copyWith =>
      __$$PlayerStatsImplCopyWithImpl<_$PlayerStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStatsImplToJson(this);
  }
}

abstract class _PlayerStats implements PlayerStats {
  const factory _PlayerStats({
    final int pace,
    final int shooting,
    final int passing,
    final int ballControl,
    final int positioning,
    final int stamina,
    final int composure,
  }) = _$PlayerStatsImpl;

  factory _PlayerStats.fromJson(Map<String, dynamic> json) =
      _$PlayerStatsImpl.fromJson;

  @override
  int get pace; // 속도
  @override
  int get shooting; // 슈팅
  @override
  int get passing; // 패스
  @override
  int get ballControl; // 볼 컨트롤
  @override
  int get positioning; // 위치 선정
  @override
  int get stamina; // 체력
  @override
  int get composure;

  /// Create a copy of PlayerStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStatsImplCopyWith<_$PlayerStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerStatus _$PlayerStatusFromJson(Map<String, dynamic> json) {
  return _PlayerStatus.fromJson(json);
}

/// @nodoc
mixin _$PlayerStatus {
  int get fatigue => throw _privateConstructorUsedError; // 피로도 (0-100)
  int get confidence => throw _privateConstructorUsedError; // 자신감 (-3 ~ +3)
  InjuryStatus get injury => throw _privateConstructorUsedError; // 부상 상태
  int get injuryWeeksRemaining =>
      throw _privateConstructorUsedError; // 잔여 부상 기간
  FormTrend get form => throw _privateConstructorUsedError;

  /// Serializes this PlayerStatus to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStatusCopyWith<PlayerStatus> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStatusCopyWith<$Res> {
  factory $PlayerStatusCopyWith(
    PlayerStatus value,
    $Res Function(PlayerStatus) then,
  ) = _$PlayerStatusCopyWithImpl<$Res, PlayerStatus>;
  @useResult
  $Res call({
    int fatigue,
    int confidence,
    InjuryStatus injury,
    int injuryWeeksRemaining,
    FormTrend form,
  });
}

/// @nodoc
class _$PlayerStatusCopyWithImpl<$Res, $Val extends PlayerStatus>
    implements $PlayerStatusCopyWith<$Res> {
  _$PlayerStatusCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fatigue = null,
    Object? confidence = null,
    Object? injury = null,
    Object? injuryWeeksRemaining = null,
    Object? form = null,
  }) {
    return _then(
      _value.copyWith(
            fatigue: null == fatigue
                ? _value.fatigue
                : fatigue // ignore: cast_nullable_to_non_nullable
                      as int,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as int,
            injury: null == injury
                ? _value.injury
                : injury // ignore: cast_nullable_to_non_nullable
                      as InjuryStatus,
            injuryWeeksRemaining: null == injuryWeeksRemaining
                ? _value.injuryWeeksRemaining
                : injuryWeeksRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
            form: null == form
                ? _value.form
                : form // ignore: cast_nullable_to_non_nullable
                      as FormTrend,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlayerStatusImplCopyWith<$Res>
    implements $PlayerStatusCopyWith<$Res> {
  factory _$$PlayerStatusImplCopyWith(
    _$PlayerStatusImpl value,
    $Res Function(_$PlayerStatusImpl) then,
  ) = __$$PlayerStatusImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int fatigue,
    int confidence,
    InjuryStatus injury,
    int injuryWeeksRemaining,
    FormTrend form,
  });
}

/// @nodoc
class __$$PlayerStatusImplCopyWithImpl<$Res>
    extends _$PlayerStatusCopyWithImpl<$Res, _$PlayerStatusImpl>
    implements _$$PlayerStatusImplCopyWith<$Res> {
  __$$PlayerStatusImplCopyWithImpl(
    _$PlayerStatusImpl _value,
    $Res Function(_$PlayerStatusImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerStatus
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? fatigue = null,
    Object? confidence = null,
    Object? injury = null,
    Object? injuryWeeksRemaining = null,
    Object? form = null,
  }) {
    return _then(
      _$PlayerStatusImpl(
        fatigue: null == fatigue
            ? _value.fatigue
            : fatigue // ignore: cast_nullable_to_non_nullable
                  as int,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as int,
        injury: null == injury
            ? _value.injury
            : injury // ignore: cast_nullable_to_non_nullable
                  as InjuryStatus,
        injuryWeeksRemaining: null == injuryWeeksRemaining
            ? _value.injuryWeeksRemaining
            : injuryWeeksRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
        form: null == form
            ? _value.form
            : form // ignore: cast_nullable_to_non_nullable
                  as FormTrend,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStatusImpl implements _PlayerStatus {
  const _$PlayerStatusImpl({
    this.fatigue = 0,
    this.confidence = 0,
    this.injury = InjuryStatus.none,
    this.injuryWeeksRemaining = 0,
    this.form = FormTrend.average,
  });

  factory _$PlayerStatusImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStatusImplFromJson(json);

  @override
  @JsonKey()
  final int fatigue;
  // 피로도 (0-100)
  @override
  @JsonKey()
  final int confidence;
  // 자신감 (-3 ~ +3)
  @override
  @JsonKey()
  final InjuryStatus injury;
  // 부상 상태
  @override
  @JsonKey()
  final int injuryWeeksRemaining;
  // 잔여 부상 기간
  @override
  @JsonKey()
  final FormTrend form;

  @override
  String toString() {
    return 'PlayerStatus(fatigue: $fatigue, confidence: $confidence, injury: $injury, injuryWeeksRemaining: $injuryWeeksRemaining, form: $form)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStatusImpl &&
            (identical(other.fatigue, fatigue) || other.fatigue == fatigue) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.injury, injury) || other.injury == injury) &&
            (identical(other.injuryWeeksRemaining, injuryWeeksRemaining) ||
                other.injuryWeeksRemaining == injuryWeeksRemaining) &&
            (identical(other.form, form) || other.form == form));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    fatigue,
    confidence,
    injury,
    injuryWeeksRemaining,
    form,
  );

  /// Create a copy of PlayerStatus
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStatusImplCopyWith<_$PlayerStatusImpl> get copyWith =>
      __$$PlayerStatusImplCopyWithImpl<_$PlayerStatusImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStatusImplToJson(this);
  }
}

abstract class _PlayerStatus implements PlayerStatus {
  const factory _PlayerStatus({
    final int fatigue,
    final int confidence,
    final InjuryStatus injury,
    final int injuryWeeksRemaining,
    final FormTrend form,
  }) = _$PlayerStatusImpl;

  factory _PlayerStatus.fromJson(Map<String, dynamic> json) =
      _$PlayerStatusImpl.fromJson;

  @override
  int get fatigue; // 피로도 (0-100)
  @override
  int get confidence; // 자신감 (-3 ~ +3)
  @override
  InjuryStatus get injury; // 부상 상태
  @override
  int get injuryWeeksRemaining; // 잔여 부상 기간
  @override
  FormTrend get form;

  /// Create a copy of PlayerStatus
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStatusImplCopyWith<_$PlayerStatusImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerCareer _$PlayerCareerFromJson(Map<String, dynamic> json) {
  return _PlayerCareer.fromJson(json);
}

/// @nodoc
mixin _$PlayerCareer {
  int get level => throw _privateConstructorUsedError; // 레벨
  int get xp => throw _privateConstructorUsedError; // 경험치
  int get trust => throw _privateConstructorUsedError; // 감독 신뢰도 (0-100)
  int get reputation => throw _privateConstructorUsedError; // 평판 (0-100)
  List<double> get lastRatings =>
      throw _privateConstructorUsedError; // 최근 10경기 평점
  int get totalGoals => throw _privateConstructorUsedError; // 통산 득점
  int get totalAssists => throw _privateConstructorUsedError; // 통산 어시스트
  int get matchesPlayed => throw _privateConstructorUsedError;

  /// Serializes this PlayerCareer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerCareer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerCareerCopyWith<PlayerCareer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCareerCopyWith<$Res> {
  factory $PlayerCareerCopyWith(
    PlayerCareer value,
    $Res Function(PlayerCareer) then,
  ) = _$PlayerCareerCopyWithImpl<$Res, PlayerCareer>;
  @useResult
  $Res call({
    int level,
    int xp,
    int trust,
    int reputation,
    List<double> lastRatings,
    int totalGoals,
    int totalAssists,
    int matchesPlayed,
  });
}

/// @nodoc
class _$PlayerCareerCopyWithImpl<$Res, $Val extends PlayerCareer>
    implements $PlayerCareerCopyWith<$Res> {
  _$PlayerCareerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerCareer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? xp = null,
    Object? trust = null,
    Object? reputation = null,
    Object? lastRatings = null,
    Object? totalGoals = null,
    Object? totalAssists = null,
    Object? matchesPlayed = null,
  }) {
    return _then(
      _value.copyWith(
            level: null == level
                ? _value.level
                : level // ignore: cast_nullable_to_non_nullable
                      as int,
            xp: null == xp
                ? _value.xp
                : xp // ignore: cast_nullable_to_non_nullable
                      as int,
            trust: null == trust
                ? _value.trust
                : trust // ignore: cast_nullable_to_non_nullable
                      as int,
            reputation: null == reputation
                ? _value.reputation
                : reputation // ignore: cast_nullable_to_non_nullable
                      as int,
            lastRatings: null == lastRatings
                ? _value.lastRatings
                : lastRatings // ignore: cast_nullable_to_non_nullable
                      as List<double>,
            totalGoals: null == totalGoals
                ? _value.totalGoals
                : totalGoals // ignore: cast_nullable_to_non_nullable
                      as int,
            totalAssists: null == totalAssists
                ? _value.totalAssists
                : totalAssists // ignore: cast_nullable_to_non_nullable
                      as int,
            matchesPlayed: null == matchesPlayed
                ? _value.matchesPlayed
                : matchesPlayed // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PlayerCareerImplCopyWith<$Res>
    implements $PlayerCareerCopyWith<$Res> {
  factory _$$PlayerCareerImplCopyWith(
    _$PlayerCareerImpl value,
    $Res Function(_$PlayerCareerImpl) then,
  ) = __$$PlayerCareerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int level,
    int xp,
    int trust,
    int reputation,
    List<double> lastRatings,
    int totalGoals,
    int totalAssists,
    int matchesPlayed,
  });
}

/// @nodoc
class __$$PlayerCareerImplCopyWithImpl<$Res>
    extends _$PlayerCareerCopyWithImpl<$Res, _$PlayerCareerImpl>
    implements _$$PlayerCareerImplCopyWith<$Res> {
  __$$PlayerCareerImplCopyWithImpl(
    _$PlayerCareerImpl _value,
    $Res Function(_$PlayerCareerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerCareer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? level = null,
    Object? xp = null,
    Object? trust = null,
    Object? reputation = null,
    Object? lastRatings = null,
    Object? totalGoals = null,
    Object? totalAssists = null,
    Object? matchesPlayed = null,
  }) {
    return _then(
      _$PlayerCareerImpl(
        level: null == level
            ? _value.level
            : level // ignore: cast_nullable_to_non_nullable
                  as int,
        xp: null == xp
            ? _value.xp
            : xp // ignore: cast_nullable_to_non_nullable
                  as int,
        trust: null == trust
            ? _value.trust
            : trust // ignore: cast_nullable_to_non_nullable
                  as int,
        reputation: null == reputation
            ? _value.reputation
            : reputation // ignore: cast_nullable_to_non_nullable
                  as int,
        lastRatings: null == lastRatings
            ? _value._lastRatings
            : lastRatings // ignore: cast_nullable_to_non_nullable
                  as List<double>,
        totalGoals: null == totalGoals
            ? _value.totalGoals
            : totalGoals // ignore: cast_nullable_to_non_nullable
                  as int,
        totalAssists: null == totalAssists
            ? _value.totalAssists
            : totalAssists // ignore: cast_nullable_to_non_nullable
                  as int,
        matchesPlayed: null == matchesPlayed
            ? _value.matchesPlayed
            : matchesPlayed // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerCareerImpl implements _PlayerCareer {
  const _$PlayerCareerImpl({
    this.level = 1,
    this.xp = 0,
    this.trust = 30,
    this.reputation = 0,
    final List<double> lastRatings = const [],
    this.totalGoals = 0,
    this.totalAssists = 0,
    this.matchesPlayed = 0,
  }) : _lastRatings = lastRatings;

  factory _$PlayerCareerImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerCareerImplFromJson(json);

  @override
  @JsonKey()
  final int level;
  // 레벨
  @override
  @JsonKey()
  final int xp;
  // 경험치
  @override
  @JsonKey()
  final int trust;
  // 감독 신뢰도 (0-100)
  @override
  @JsonKey()
  final int reputation;
  // 평판 (0-100)
  final List<double> _lastRatings;
  // 평판 (0-100)
  @override
  @JsonKey()
  List<double> get lastRatings {
    if (_lastRatings is EqualUnmodifiableListView) return _lastRatings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lastRatings);
  }

  // 최근 10경기 평점
  @override
  @JsonKey()
  final int totalGoals;
  // 통산 득점
  @override
  @JsonKey()
  final int totalAssists;
  // 통산 어시스트
  @override
  @JsonKey()
  final int matchesPlayed;

  @override
  String toString() {
    return 'PlayerCareer(level: $level, xp: $xp, trust: $trust, reputation: $reputation, lastRatings: $lastRatings, totalGoals: $totalGoals, totalAssists: $totalAssists, matchesPlayed: $matchesPlayed)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerCareerImpl &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.xp, xp) || other.xp == xp) &&
            (identical(other.trust, trust) || other.trust == trust) &&
            (identical(other.reputation, reputation) ||
                other.reputation == reputation) &&
            const DeepCollectionEquality().equals(
              other._lastRatings,
              _lastRatings,
            ) &&
            (identical(other.totalGoals, totalGoals) ||
                other.totalGoals == totalGoals) &&
            (identical(other.totalAssists, totalAssists) ||
                other.totalAssists == totalAssists) &&
            (identical(other.matchesPlayed, matchesPlayed) ||
                other.matchesPlayed == matchesPlayed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    level,
    xp,
    trust,
    reputation,
    const DeepCollectionEquality().hash(_lastRatings),
    totalGoals,
    totalAssists,
    matchesPlayed,
  );

  /// Create a copy of PlayerCareer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerCareerImplCopyWith<_$PlayerCareerImpl> get copyWith =>
      __$$PlayerCareerImplCopyWithImpl<_$PlayerCareerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerCareerImplToJson(this);
  }
}

abstract class _PlayerCareer implements PlayerCareer {
  const factory _PlayerCareer({
    final int level,
    final int xp,
    final int trust,
    final int reputation,
    final List<double> lastRatings,
    final int totalGoals,
    final int totalAssists,
    final int matchesPlayed,
  }) = _$PlayerCareerImpl;

  factory _PlayerCareer.fromJson(Map<String, dynamic> json) =
      _$PlayerCareerImpl.fromJson;

  @override
  int get level; // 레벨
  @override
  int get xp; // 경험치
  @override
  int get trust; // 감독 신뢰도 (0-100)
  @override
  int get reputation; // 평판 (0-100)
  @override
  List<double> get lastRatings; // 최근 10경기 평점
  @override
  int get totalGoals; // 통산 득점
  @override
  int get totalAssists; // 통산 어시스트
  @override
  int get matchesPlayed;

  /// Create a copy of PlayerCareer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerCareerImplCopyWith<_$PlayerCareerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerCharacter _$PlayerCharacterFromJson(Map<String, dynamic> json) {
  return _PlayerCharacter.fromJson(json);
}

/// @nodoc
mixin _$PlayerCharacter {
  PlayerProfile get profile => throw _privateConstructorUsedError;
  PlayerStats get stats => throw _privateConstructorUsedError;
  PlayerStatus get status => throw _privateConstructorUsedError;
  PlayerCareer get career => throw _privateConstructorUsedError;

  /// Serializes this PlayerCharacter to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerCharacterCopyWith<PlayerCharacter> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerCharacterCopyWith<$Res> {
  factory $PlayerCharacterCopyWith(
    PlayerCharacter value,
    $Res Function(PlayerCharacter) then,
  ) = _$PlayerCharacterCopyWithImpl<$Res, PlayerCharacter>;
  @useResult
  $Res call({
    PlayerProfile profile,
    PlayerStats stats,
    PlayerStatus status,
    PlayerCareer career,
  });

  $PlayerProfileCopyWith<$Res> get profile;
  $PlayerStatsCopyWith<$Res> get stats;
  $PlayerStatusCopyWith<$Res> get status;
  $PlayerCareerCopyWith<$Res> get career;
}

/// @nodoc
class _$PlayerCharacterCopyWithImpl<$Res, $Val extends PlayerCharacter>
    implements $PlayerCharacterCopyWith<$Res> {
  _$PlayerCharacterCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? stats = null,
    Object? status = null,
    Object? career = null,
  }) {
    return _then(
      _value.copyWith(
            profile: null == profile
                ? _value.profile
                : profile // ignore: cast_nullable_to_non_nullable
                      as PlayerProfile,
            stats: null == stats
                ? _value.stats
                : stats // ignore: cast_nullable_to_non_nullable
                      as PlayerStats,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PlayerStatus,
            career: null == career
                ? _value.career
                : career // ignore: cast_nullable_to_non_nullable
                      as PlayerCareer,
          )
          as $Val,
    );
  }

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerProfileCopyWith<$Res> get profile {
    return $PlayerProfileCopyWith<$Res>(_value.profile, (value) {
      return _then(_value.copyWith(profile: value) as $Val);
    });
  }

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerStatsCopyWith<$Res> get stats {
    return $PlayerStatsCopyWith<$Res>(_value.stats, (value) {
      return _then(_value.copyWith(stats: value) as $Val);
    });
  }

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerStatusCopyWith<$Res> get status {
    return $PlayerStatusCopyWith<$Res>(_value.status, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
  }

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerCareerCopyWith<$Res> get career {
    return $PlayerCareerCopyWith<$Res>(_value.career, (value) {
      return _then(_value.copyWith(career: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerCharacterImplCopyWith<$Res>
    implements $PlayerCharacterCopyWith<$Res> {
  factory _$$PlayerCharacterImplCopyWith(
    _$PlayerCharacterImpl value,
    $Res Function(_$PlayerCharacterImpl) then,
  ) = __$$PlayerCharacterImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PlayerProfile profile,
    PlayerStats stats,
    PlayerStatus status,
    PlayerCareer career,
  });

  @override
  $PlayerProfileCopyWith<$Res> get profile;
  @override
  $PlayerStatsCopyWith<$Res> get stats;
  @override
  $PlayerStatusCopyWith<$Res> get status;
  @override
  $PlayerCareerCopyWith<$Res> get career;
}

/// @nodoc
class __$$PlayerCharacterImplCopyWithImpl<$Res>
    extends _$PlayerCharacterCopyWithImpl<$Res, _$PlayerCharacterImpl>
    implements _$$PlayerCharacterImplCopyWith<$Res> {
  __$$PlayerCharacterImplCopyWithImpl(
    _$PlayerCharacterImpl _value,
    $Res Function(_$PlayerCharacterImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? profile = null,
    Object? stats = null,
    Object? status = null,
    Object? career = null,
  }) {
    return _then(
      _$PlayerCharacterImpl(
        profile: null == profile
            ? _value.profile
            : profile // ignore: cast_nullable_to_non_nullable
                  as PlayerProfile,
        stats: null == stats
            ? _value.stats
            : stats // ignore: cast_nullable_to_non_nullable
                  as PlayerStats,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PlayerStatus,
        career: null == career
            ? _value.career
            : career // ignore: cast_nullable_to_non_nullable
                  as PlayerCareer,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerCharacterImpl implements _PlayerCharacter {
  const _$PlayerCharacterImpl({
    required this.profile,
    required this.stats,
    required this.status,
    required this.career,
  });

  factory _$PlayerCharacterImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerCharacterImplFromJson(json);

  @override
  final PlayerProfile profile;
  @override
  final PlayerStats stats;
  @override
  final PlayerStatus status;
  @override
  final PlayerCareer career;

  @override
  String toString() {
    return 'PlayerCharacter(profile: $profile, stats: $stats, status: $status, career: $career)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerCharacterImpl &&
            (identical(other.profile, profile) || other.profile == profile) &&
            (identical(other.stats, stats) || other.stats == stats) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.career, career) || other.career == career));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, profile, stats, status, career);

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerCharacterImplCopyWith<_$PlayerCharacterImpl> get copyWith =>
      __$$PlayerCharacterImplCopyWithImpl<_$PlayerCharacterImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerCharacterImplToJson(this);
  }
}

abstract class _PlayerCharacter implements PlayerCharacter {
  const factory _PlayerCharacter({
    required final PlayerProfile profile,
    required final PlayerStats stats,
    required final PlayerStatus status,
    required final PlayerCareer career,
  }) = _$PlayerCharacterImpl;

  factory _PlayerCharacter.fromJson(Map<String, dynamic> json) =
      _$PlayerCharacterImpl.fromJson;

  @override
  PlayerProfile get profile;
  @override
  PlayerStats get stats;
  @override
  PlayerStatus get status;
  @override
  PlayerCareer get career;

  /// Create a copy of PlayerCharacter
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerCharacterImplCopyWith<_$PlayerCharacterImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
