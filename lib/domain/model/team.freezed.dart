// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'team.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Team _$TeamFromJson(Map<String, dynamic> json) {
  return _Team.fromJson(json);
}

/// @nodoc
mixin _$Team {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get attackRating => throw _privateConstructorUsedError; // 공격력 (30-90)
  int get defenseRating => throw _privateConstructorUsedError; // 수비력 (30-90)
  int get overallRating => throw _privateConstructorUsedError;

  /// Serializes this Team to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TeamCopyWith<Team> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamCopyWith<$Res> {
  factory $TeamCopyWith(Team value, $Res Function(Team) then) =
      _$TeamCopyWithImpl<$Res, Team>;
  @useResult
  $Res call({
    String id,
    String name,
    int attackRating,
    int defenseRating,
    int overallRating,
  });
}

/// @nodoc
class _$TeamCopyWithImpl<$Res, $Val extends Team>
    implements $TeamCopyWith<$Res> {
  _$TeamCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? attackRating = null,
    Object? defenseRating = null,
    Object? overallRating = null,
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
            attackRating: null == attackRating
                ? _value.attackRating
                : attackRating // ignore: cast_nullable_to_non_nullable
                      as int,
            defenseRating: null == defenseRating
                ? _value.defenseRating
                : defenseRating // ignore: cast_nullable_to_non_nullable
                      as int,
            overallRating: null == overallRating
                ? _value.overallRating
                : overallRating // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TeamImplCopyWith<$Res> implements $TeamCopyWith<$Res> {
  factory _$$TeamImplCopyWith(
    _$TeamImpl value,
    $Res Function(_$TeamImpl) then,
  ) = __$$TeamImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    int attackRating,
    int defenseRating,
    int overallRating,
  });
}

/// @nodoc
class __$$TeamImplCopyWithImpl<$Res>
    extends _$TeamCopyWithImpl<$Res, _$TeamImpl>
    implements _$$TeamImplCopyWith<$Res> {
  __$$TeamImplCopyWithImpl(_$TeamImpl _value, $Res Function(_$TeamImpl) _then)
    : super(_value, _then);

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? attackRating = null,
    Object? defenseRating = null,
    Object? overallRating = null,
  }) {
    return _then(
      _$TeamImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        attackRating: null == attackRating
            ? _value.attackRating
            : attackRating // ignore: cast_nullable_to_non_nullable
                  as int,
        defenseRating: null == defenseRating
            ? _value.defenseRating
            : defenseRating // ignore: cast_nullable_to_non_nullable
                  as int,
        overallRating: null == overallRating
            ? _value.overallRating
            : overallRating // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TeamImpl implements _Team {
  const _$TeamImpl({
    required this.id,
    required this.name,
    this.attackRating = 50,
    this.defenseRating = 50,
    this.overallRating = 50,
  });

  factory _$TeamImpl.fromJson(Map<String, dynamic> json) =>
      _$$TeamImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey()
  final int attackRating;
  // 공격력 (30-90)
  @override
  @JsonKey()
  final int defenseRating;
  // 수비력 (30-90)
  @override
  @JsonKey()
  final int overallRating;

  @override
  String toString() {
    return 'Team(id: $id, name: $name, attackRating: $attackRating, defenseRating: $defenseRating, overallRating: $overallRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TeamImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.attackRating, attackRating) ||
                other.attackRating == attackRating) &&
            (identical(other.defenseRating, defenseRating) ||
                other.defenseRating == defenseRating) &&
            (identical(other.overallRating, overallRating) ||
                other.overallRating == overallRating));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    attackRating,
    defenseRating,
    overallRating,
  );

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      __$$TeamImplCopyWithImpl<_$TeamImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TeamImplToJson(this);
  }
}

abstract class _Team implements Team {
  const factory _Team({
    required final String id,
    required final String name,
    final int attackRating,
    final int defenseRating,
    final int overallRating,
  }) = _$TeamImpl;

  factory _Team.fromJson(Map<String, dynamic> json) = _$TeamImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get attackRating; // 공격력 (30-90)
  @override
  int get defenseRating; // 수비력 (30-90)
  @override
  int get overallRating;

  /// Create a copy of Team
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TeamImplCopyWith<_$TeamImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StandingRow _$StandingRowFromJson(Map<String, dynamic> json) {
  return _StandingRow.fromJson(json);
}

/// @nodoc
mixin _$StandingRow {
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  int get played => throw _privateConstructorUsedError; // 경기 수
  int get won => throw _privateConstructorUsedError; // 승
  int get drawn => throw _privateConstructorUsedError; // 무
  int get lost => throw _privateConstructorUsedError; // 패
  int get goalsFor => throw _privateConstructorUsedError; // 득점
  int get goalsAgainst => throw _privateConstructorUsedError;

  /// Serializes this StandingRow to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StandingRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StandingRowCopyWith<StandingRow> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StandingRowCopyWith<$Res> {
  factory $StandingRowCopyWith(
    StandingRow value,
    $Res Function(StandingRow) then,
  ) = _$StandingRowCopyWithImpl<$Res, StandingRow>;
  @useResult
  $Res call({
    String teamId,
    String teamName,
    int played,
    int won,
    int drawn,
    int lost,
    int goalsFor,
    int goalsAgainst,
  });
}

/// @nodoc
class _$StandingRowCopyWithImpl<$Res, $Val extends StandingRow>
    implements $StandingRowCopyWith<$Res> {
  _$StandingRowCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StandingRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? played = null,
    Object? won = null,
    Object? drawn = null,
    Object? lost = null,
    Object? goalsFor = null,
    Object? goalsAgainst = null,
  }) {
    return _then(
      _value.copyWith(
            teamId: null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                      as String,
            teamName: null == teamName
                ? _value.teamName
                : teamName // ignore: cast_nullable_to_non_nullable
                      as String,
            played: null == played
                ? _value.played
                : played // ignore: cast_nullable_to_non_nullable
                      as int,
            won: null == won
                ? _value.won
                : won // ignore: cast_nullable_to_non_nullable
                      as int,
            drawn: null == drawn
                ? _value.drawn
                : drawn // ignore: cast_nullable_to_non_nullable
                      as int,
            lost: null == lost
                ? _value.lost
                : lost // ignore: cast_nullable_to_non_nullable
                      as int,
            goalsFor: null == goalsFor
                ? _value.goalsFor
                : goalsFor // ignore: cast_nullable_to_non_nullable
                      as int,
            goalsAgainst: null == goalsAgainst
                ? _value.goalsAgainst
                : goalsAgainst // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StandingRowImplCopyWith<$Res>
    implements $StandingRowCopyWith<$Res> {
  factory _$$StandingRowImplCopyWith(
    _$StandingRowImpl value,
    $Res Function(_$StandingRowImpl) then,
  ) = __$$StandingRowImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String teamId,
    String teamName,
    int played,
    int won,
    int drawn,
    int lost,
    int goalsFor,
    int goalsAgainst,
  });
}

/// @nodoc
class __$$StandingRowImplCopyWithImpl<$Res>
    extends _$StandingRowCopyWithImpl<$Res, _$StandingRowImpl>
    implements _$$StandingRowImplCopyWith<$Res> {
  __$$StandingRowImplCopyWithImpl(
    _$StandingRowImpl _value,
    $Res Function(_$StandingRowImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StandingRow
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? played = null,
    Object? won = null,
    Object? drawn = null,
    Object? lost = null,
    Object? goalsFor = null,
    Object? goalsAgainst = null,
  }) {
    return _then(
      _$StandingRowImpl(
        teamId: null == teamId
            ? _value.teamId
            : teamId // ignore: cast_nullable_to_non_nullable
                  as String,
        teamName: null == teamName
            ? _value.teamName
            : teamName // ignore: cast_nullable_to_non_nullable
                  as String,
        played: null == played
            ? _value.played
            : played // ignore: cast_nullable_to_non_nullable
                  as int,
        won: null == won
            ? _value.won
            : won // ignore: cast_nullable_to_non_nullable
                  as int,
        drawn: null == drawn
            ? _value.drawn
            : drawn // ignore: cast_nullable_to_non_nullable
                  as int,
        lost: null == lost
            ? _value.lost
            : lost // ignore: cast_nullable_to_non_nullable
                  as int,
        goalsFor: null == goalsFor
            ? _value.goalsFor
            : goalsFor // ignore: cast_nullable_to_non_nullable
                  as int,
        goalsAgainst: null == goalsAgainst
            ? _value.goalsAgainst
            : goalsAgainst // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StandingRowImpl implements _StandingRow {
  const _$StandingRowImpl({
    required this.teamId,
    required this.teamName,
    this.played = 0,
    this.won = 0,
    this.drawn = 0,
    this.lost = 0,
    this.goalsFor = 0,
    this.goalsAgainst = 0,
  });

  factory _$StandingRowImpl.fromJson(Map<String, dynamic> json) =>
      _$$StandingRowImplFromJson(json);

  @override
  final String teamId;
  @override
  final String teamName;
  @override
  @JsonKey()
  final int played;
  // 경기 수
  @override
  @JsonKey()
  final int won;
  // 승
  @override
  @JsonKey()
  final int drawn;
  // 무
  @override
  @JsonKey()
  final int lost;
  // 패
  @override
  @JsonKey()
  final int goalsFor;
  // 득점
  @override
  @JsonKey()
  final int goalsAgainst;

  @override
  String toString() {
    return 'StandingRow(teamId: $teamId, teamName: $teamName, played: $played, won: $won, drawn: $drawn, lost: $lost, goalsFor: $goalsFor, goalsAgainst: $goalsAgainst)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StandingRowImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.played, played) || other.played == played) &&
            (identical(other.won, won) || other.won == won) &&
            (identical(other.drawn, drawn) || other.drawn == drawn) &&
            (identical(other.lost, lost) || other.lost == lost) &&
            (identical(other.goalsFor, goalsFor) ||
                other.goalsFor == goalsFor) &&
            (identical(other.goalsAgainst, goalsAgainst) ||
                other.goalsAgainst == goalsAgainst));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    teamId,
    teamName,
    played,
    won,
    drawn,
    lost,
    goalsFor,
    goalsAgainst,
  );

  /// Create a copy of StandingRow
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StandingRowImplCopyWith<_$StandingRowImpl> get copyWith =>
      __$$StandingRowImplCopyWithImpl<_$StandingRowImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StandingRowImplToJson(this);
  }
}

abstract class _StandingRow implements StandingRow {
  const factory _StandingRow({
    required final String teamId,
    required final String teamName,
    final int played,
    final int won,
    final int drawn,
    final int lost,
    final int goalsFor,
    final int goalsAgainst,
  }) = _$StandingRowImpl;

  factory _StandingRow.fromJson(Map<String, dynamic> json) =
      _$StandingRowImpl.fromJson;

  @override
  String get teamId;
  @override
  String get teamName;
  @override
  int get played; // 경기 수
  @override
  int get won; // 승
  @override
  int get drawn; // 무
  @override
  int get lost; // 패
  @override
  int get goalsFor; // 득점
  @override
  int get goalsAgainst;

  /// Create a copy of StandingRow
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StandingRowImplCopyWith<_$StandingRowImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Fixture _$FixtureFromJson(Map<String, dynamic> json) {
  return _Fixture.fromJson(json);
}

/// @nodoc
mixin _$Fixture {
  String get id => throw _privateConstructorUsedError;
  int get round => throw _privateConstructorUsedError; // 라운드 번호 (1-18)
  String get homeTeamId => throw _privateConstructorUsedError;
  String get awayTeamId => throw _privateConstructorUsedError;
  bool get isPlayed => throw _privateConstructorUsedError; // 경기 완료 여부
  int? get homeScore => throw _privateConstructorUsedError;
  int? get awayScore => throw _privateConstructorUsedError;

  /// Serializes this Fixture to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FixtureCopyWith<Fixture> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FixtureCopyWith<$Res> {
  factory $FixtureCopyWith(Fixture value, $Res Function(Fixture) then) =
      _$FixtureCopyWithImpl<$Res, Fixture>;
  @useResult
  $Res call({
    String id,
    int round,
    String homeTeamId,
    String awayTeamId,
    bool isPlayed,
    int? homeScore,
    int? awayScore,
  });
}

/// @nodoc
class _$FixtureCopyWithImpl<$Res, $Val extends Fixture>
    implements $FixtureCopyWith<$Res> {
  _$FixtureCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? round = null,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? isPlayed = null,
    Object? homeScore = freezed,
    Object? awayScore = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            round: null == round
                ? _value.round
                : round // ignore: cast_nullable_to_non_nullable
                      as int,
            homeTeamId: null == homeTeamId
                ? _value.homeTeamId
                : homeTeamId // ignore: cast_nullable_to_non_nullable
                      as String,
            awayTeamId: null == awayTeamId
                ? _value.awayTeamId
                : awayTeamId // ignore: cast_nullable_to_non_nullable
                      as String,
            isPlayed: null == isPlayed
                ? _value.isPlayed
                : isPlayed // ignore: cast_nullable_to_non_nullable
                      as bool,
            homeScore: freezed == homeScore
                ? _value.homeScore
                : homeScore // ignore: cast_nullable_to_non_nullable
                      as int?,
            awayScore: freezed == awayScore
                ? _value.awayScore
                : awayScore // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FixtureImplCopyWith<$Res> implements $FixtureCopyWith<$Res> {
  factory _$$FixtureImplCopyWith(
    _$FixtureImpl value,
    $Res Function(_$FixtureImpl) then,
  ) = __$$FixtureImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int round,
    String homeTeamId,
    String awayTeamId,
    bool isPlayed,
    int? homeScore,
    int? awayScore,
  });
}

/// @nodoc
class __$$FixtureImplCopyWithImpl<$Res>
    extends _$FixtureCopyWithImpl<$Res, _$FixtureImpl>
    implements _$$FixtureImplCopyWith<$Res> {
  __$$FixtureImplCopyWithImpl(
    _$FixtureImpl _value,
    $Res Function(_$FixtureImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? round = null,
    Object? homeTeamId = null,
    Object? awayTeamId = null,
    Object? isPlayed = null,
    Object? homeScore = freezed,
    Object? awayScore = freezed,
  }) {
    return _then(
      _$FixtureImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        round: null == round
            ? _value.round
            : round // ignore: cast_nullable_to_non_nullable
                  as int,
        homeTeamId: null == homeTeamId
            ? _value.homeTeamId
            : homeTeamId // ignore: cast_nullable_to_non_nullable
                  as String,
        awayTeamId: null == awayTeamId
            ? _value.awayTeamId
            : awayTeamId // ignore: cast_nullable_to_non_nullable
                  as String,
        isPlayed: null == isPlayed
            ? _value.isPlayed
            : isPlayed // ignore: cast_nullable_to_non_nullable
                  as bool,
        homeScore: freezed == homeScore
            ? _value.homeScore
            : homeScore // ignore: cast_nullable_to_non_nullable
                  as int?,
        awayScore: freezed == awayScore
            ? _value.awayScore
            : awayScore // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FixtureImpl implements _Fixture {
  const _$FixtureImpl({
    required this.id,
    required this.round,
    required this.homeTeamId,
    required this.awayTeamId,
    this.isPlayed = false,
    this.homeScore,
    this.awayScore,
  });

  factory _$FixtureImpl.fromJson(Map<String, dynamic> json) =>
      _$$FixtureImplFromJson(json);

  @override
  final String id;
  @override
  final int round;
  // 라운드 번호 (1-18)
  @override
  final String homeTeamId;
  @override
  final String awayTeamId;
  @override
  @JsonKey()
  final bool isPlayed;
  // 경기 완료 여부
  @override
  final int? homeScore;
  @override
  final int? awayScore;

  @override
  String toString() {
    return 'Fixture(id: $id, round: $round, homeTeamId: $homeTeamId, awayTeamId: $awayTeamId, isPlayed: $isPlayed, homeScore: $homeScore, awayScore: $awayScore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FixtureImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.round, round) || other.round == round) &&
            (identical(other.homeTeamId, homeTeamId) ||
                other.homeTeamId == homeTeamId) &&
            (identical(other.awayTeamId, awayTeamId) ||
                other.awayTeamId == awayTeamId) &&
            (identical(other.isPlayed, isPlayed) ||
                other.isPlayed == isPlayed) &&
            (identical(other.homeScore, homeScore) ||
                other.homeScore == homeScore) &&
            (identical(other.awayScore, awayScore) ||
                other.awayScore == awayScore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    round,
    homeTeamId,
    awayTeamId,
    isPlayed,
    homeScore,
    awayScore,
  );

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FixtureImplCopyWith<_$FixtureImpl> get copyWith =>
      __$$FixtureImplCopyWithImpl<_$FixtureImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FixtureImplToJson(this);
  }
}

abstract class _Fixture implements Fixture {
  const factory _Fixture({
    required final String id,
    required final int round,
    required final String homeTeamId,
    required final String awayTeamId,
    final bool isPlayed,
    final int? homeScore,
    final int? awayScore,
  }) = _$FixtureImpl;

  factory _Fixture.fromJson(Map<String, dynamic> json) = _$FixtureImpl.fromJson;

  @override
  String get id;
  @override
  int get round; // 라운드 번호 (1-18)
  @override
  String get homeTeamId;
  @override
  String get awayTeamId;
  @override
  bool get isPlayed; // 경기 완료 여부
  @override
  int? get homeScore;
  @override
  int? get awayScore;

  /// Create a copy of Fixture
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FixtureImplCopyWith<_$FixtureImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Season _$SeasonFromJson(Map<String, dynamic> json) {
  return _Season.fromJson(json);
}

/// @nodoc
mixin _$Season {
  String get id => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError; // 시즌 연도
  int get currentRound => throw _privateConstructorUsedError; // 현재 라운드
  Map<String, Team> get teams => throw _privateConstructorUsedError; // 팀 맵
  List<Fixture> get fixtures => throw _privateConstructorUsedError; // 전체 경기 일정
  List<StandingRow> get standings => throw _privateConstructorUsedError;

  /// Serializes this Season to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeasonCopyWith<Season> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonCopyWith<$Res> {
  factory $SeasonCopyWith(Season value, $Res Function(Season) then) =
      _$SeasonCopyWithImpl<$Res, Season>;
  @useResult
  $Res call({
    String id,
    int year,
    int currentRound,
    Map<String, Team> teams,
    List<Fixture> fixtures,
    List<StandingRow> standings,
  });
}

/// @nodoc
class _$SeasonCopyWithImpl<$Res, $Val extends Season>
    implements $SeasonCopyWith<$Res> {
  _$SeasonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? currentRound = null,
    Object? teams = null,
    Object? fixtures = null,
    Object? standings = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            currentRound: null == currentRound
                ? _value.currentRound
                : currentRound // ignore: cast_nullable_to_non_nullable
                      as int,
            teams: null == teams
                ? _value.teams
                : teams // ignore: cast_nullable_to_non_nullable
                      as Map<String, Team>,
            fixtures: null == fixtures
                ? _value.fixtures
                : fixtures // ignore: cast_nullable_to_non_nullable
                      as List<Fixture>,
            standings: null == standings
                ? _value.standings
                : standings // ignore: cast_nullable_to_non_nullable
                      as List<StandingRow>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SeasonImplCopyWith<$Res> implements $SeasonCopyWith<$Res> {
  factory _$$SeasonImplCopyWith(
    _$SeasonImpl value,
    $Res Function(_$SeasonImpl) then,
  ) = __$$SeasonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int year,
    int currentRound,
    Map<String, Team> teams,
    List<Fixture> fixtures,
    List<StandingRow> standings,
  });
}

/// @nodoc
class __$$SeasonImplCopyWithImpl<$Res>
    extends _$SeasonCopyWithImpl<$Res, _$SeasonImpl>
    implements _$$SeasonImplCopyWith<$Res> {
  __$$SeasonImplCopyWithImpl(
    _$SeasonImpl _value,
    $Res Function(_$SeasonImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? year = null,
    Object? currentRound = null,
    Object? teams = null,
    Object? fixtures = null,
    Object? standings = null,
  }) {
    return _then(
      _$SeasonImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        currentRound: null == currentRound
            ? _value.currentRound
            : currentRound // ignore: cast_nullable_to_non_nullable
                  as int,
        teams: null == teams
            ? _value._teams
            : teams // ignore: cast_nullable_to_non_nullable
                  as Map<String, Team>,
        fixtures: null == fixtures
            ? _value._fixtures
            : fixtures // ignore: cast_nullable_to_non_nullable
                  as List<Fixture>,
        standings: null == standings
            ? _value._standings
            : standings // ignore: cast_nullable_to_non_nullable
                  as List<StandingRow>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonImpl implements _Season {
  const _$SeasonImpl({
    required this.id,
    required this.year,
    this.currentRound = 1,
    required final Map<String, Team> teams,
    required final List<Fixture> fixtures,
    required final List<StandingRow> standings,
  }) : _teams = teams,
       _fixtures = fixtures,
       _standings = standings;

  factory _$SeasonImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonImplFromJson(json);

  @override
  final String id;
  @override
  final int year;
  // 시즌 연도
  @override
  @JsonKey()
  final int currentRound;
  // 현재 라운드
  final Map<String, Team> _teams;
  // 현재 라운드
  @override
  Map<String, Team> get teams {
    if (_teams is EqualUnmodifiableMapView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_teams);
  }

  // 팀 맵
  final List<Fixture> _fixtures;
  // 팀 맵
  @override
  List<Fixture> get fixtures {
    if (_fixtures is EqualUnmodifiableListView) return _fixtures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fixtures);
  }

  // 전체 경기 일정
  final List<StandingRow> _standings;
  // 전체 경기 일정
  @override
  List<StandingRow> get standings {
    if (_standings is EqualUnmodifiableListView) return _standings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_standings);
  }

  @override
  String toString() {
    return 'Season(id: $id, year: $year, currentRound: $currentRound, teams: $teams, fixtures: $fixtures, standings: $standings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.currentRound, currentRound) ||
                other.currentRound == currentRound) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality().equals(other._fixtures, _fixtures) &&
            const DeepCollectionEquality().equals(
              other._standings,
              _standings,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    year,
    currentRound,
    const DeepCollectionEquality().hash(_teams),
    const DeepCollectionEquality().hash(_fixtures),
    const DeepCollectionEquality().hash(_standings),
  );

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonImplCopyWith<_$SeasonImpl> get copyWith =>
      __$$SeasonImplCopyWithImpl<_$SeasonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonImplToJson(this);
  }
}

abstract class _Season implements Season {
  const factory _Season({
    required final String id,
    required final int year,
    final int currentRound,
    required final Map<String, Team> teams,
    required final List<Fixture> fixtures,
    required final List<StandingRow> standings,
  }) = _$SeasonImpl;

  factory _Season.fromJson(Map<String, dynamic> json) = _$SeasonImpl.fromJson;

  @override
  String get id;
  @override
  int get year; // 시즌 연도
  @override
  int get currentRound; // 현재 라운드
  @override
  Map<String, Team> get teams; // 팀 맵
  @override
  List<Fixture> get fixtures; // 전체 경기 일정
  @override
  List<StandingRow> get standings;

  /// Create a copy of Season
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeasonImplCopyWith<_$SeasonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
