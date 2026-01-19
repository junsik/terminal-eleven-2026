// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'league.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

VirtualPlayer _$VirtualPlayerFromJson(Map<String, dynamic> json) {
  return _VirtualPlayer.fromJson(json);
}

/// @nodoc
mixin _$VirtualPlayer {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  int get goals => throw _privateConstructorUsedError;
  int get assists => throw _privateConstructorUsedError;
  int get matchesPlayed => throw _privateConstructorUsedError;
  List<double> get ratings => throw _privateConstructorUsedError;

  /// Serializes this VirtualPlayer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VirtualPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VirtualPlayerCopyWith<VirtualPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VirtualPlayerCopyWith<$Res> {
  factory $VirtualPlayerCopyWith(
    VirtualPlayer value,
    $Res Function(VirtualPlayer) then,
  ) = _$VirtualPlayerCopyWithImpl<$Res, VirtualPlayer>;
  @useResult
  $Res call({
    String id,
    String name,
    String teamId,
    int goals,
    int assists,
    int matchesPlayed,
    List<double> ratings,
  });
}

/// @nodoc
class _$VirtualPlayerCopyWithImpl<$Res, $Val extends VirtualPlayer>
    implements $VirtualPlayerCopyWith<$Res> {
  _$VirtualPlayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VirtualPlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? teamId = null,
    Object? goals = null,
    Object? assists = null,
    Object? matchesPlayed = null,
    Object? ratings = null,
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
            teamId: null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                      as String,
            goals: null == goals
                ? _value.goals
                : goals // ignore: cast_nullable_to_non_nullable
                      as int,
            assists: null == assists
                ? _value.assists
                : assists // ignore: cast_nullable_to_non_nullable
                      as int,
            matchesPlayed: null == matchesPlayed
                ? _value.matchesPlayed
                : matchesPlayed // ignore: cast_nullable_to_non_nullable
                      as int,
            ratings: null == ratings
                ? _value.ratings
                : ratings // ignore: cast_nullable_to_non_nullable
                      as List<double>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$VirtualPlayerImplCopyWith<$Res>
    implements $VirtualPlayerCopyWith<$Res> {
  factory _$$VirtualPlayerImplCopyWith(
    _$VirtualPlayerImpl value,
    $Res Function(_$VirtualPlayerImpl) then,
  ) = __$$VirtualPlayerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String teamId,
    int goals,
    int assists,
    int matchesPlayed,
    List<double> ratings,
  });
}

/// @nodoc
class __$$VirtualPlayerImplCopyWithImpl<$Res>
    extends _$VirtualPlayerCopyWithImpl<$Res, _$VirtualPlayerImpl>
    implements _$$VirtualPlayerImplCopyWith<$Res> {
  __$$VirtualPlayerImplCopyWithImpl(
    _$VirtualPlayerImpl _value,
    $Res Function(_$VirtualPlayerImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of VirtualPlayer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? teamId = null,
    Object? goals = null,
    Object? assists = null,
    Object? matchesPlayed = null,
    Object? ratings = null,
  }) {
    return _then(
      _$VirtualPlayerImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        teamId: null == teamId
            ? _value.teamId
            : teamId // ignore: cast_nullable_to_non_nullable
                  as String,
        goals: null == goals
            ? _value.goals
            : goals // ignore: cast_nullable_to_non_nullable
                  as int,
        assists: null == assists
            ? _value.assists
            : assists // ignore: cast_nullable_to_non_nullable
                  as int,
        matchesPlayed: null == matchesPlayed
            ? _value.matchesPlayed
            : matchesPlayed // ignore: cast_nullable_to_non_nullable
                  as int,
        ratings: null == ratings
            ? _value._ratings
            : ratings // ignore: cast_nullable_to_non_nullable
                  as List<double>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$VirtualPlayerImpl implements _VirtualPlayer {
  const _$VirtualPlayerImpl({
    required this.id,
    required this.name,
    required this.teamId,
    this.goals = 0,
    this.assists = 0,
    this.matchesPlayed = 0,
    final List<double> ratings = const [],
  }) : _ratings = ratings;

  factory _$VirtualPlayerImpl.fromJson(Map<String, dynamic> json) =>
      _$$VirtualPlayerImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String teamId;
  @override
  @JsonKey()
  final int goals;
  @override
  @JsonKey()
  final int assists;
  @override
  @JsonKey()
  final int matchesPlayed;
  final List<double> _ratings;
  @override
  @JsonKey()
  List<double> get ratings {
    if (_ratings is EqualUnmodifiableListView) return _ratings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ratings);
  }

  @override
  String toString() {
    return 'VirtualPlayer(id: $id, name: $name, teamId: $teamId, goals: $goals, assists: $assists, matchesPlayed: $matchesPlayed, ratings: $ratings)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VirtualPlayerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.goals, goals) || other.goals == goals) &&
            (identical(other.assists, assists) || other.assists == assists) &&
            (identical(other.matchesPlayed, matchesPlayed) ||
                other.matchesPlayed == matchesPlayed) &&
            const DeepCollectionEquality().equals(other._ratings, _ratings));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    teamId,
    goals,
    assists,
    matchesPlayed,
    const DeepCollectionEquality().hash(_ratings),
  );

  /// Create a copy of VirtualPlayer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VirtualPlayerImplCopyWith<_$VirtualPlayerImpl> get copyWith =>
      __$$VirtualPlayerImplCopyWithImpl<_$VirtualPlayerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VirtualPlayerImplToJson(this);
  }
}

abstract class _VirtualPlayer implements VirtualPlayer {
  const factory _VirtualPlayer({
    required final String id,
    required final String name,
    required final String teamId,
    final int goals,
    final int assists,
    final int matchesPlayed,
    final List<double> ratings,
  }) = _$VirtualPlayerImpl;

  factory _VirtualPlayer.fromJson(Map<String, dynamic> json) =
      _$VirtualPlayerImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get teamId;
  @override
  int get goals;
  @override
  int get assists;
  @override
  int get matchesPlayed;
  @override
  List<double> get ratings;

  /// Create a copy of VirtualPlayer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VirtualPlayerImplCopyWith<_$VirtualPlayerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

LeagueStats _$LeagueStatsFromJson(Map<String, dynamic> json) {
  return _LeagueStats.fromJson(json);
}

/// @nodoc
mixin _$LeagueStats {
  List<VirtualPlayer> get players => throw _privateConstructorUsedError;

  /// Serializes this LeagueStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LeagueStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeagueStatsCopyWith<LeagueStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeagueStatsCopyWith<$Res> {
  factory $LeagueStatsCopyWith(
    LeagueStats value,
    $Res Function(LeagueStats) then,
  ) = _$LeagueStatsCopyWithImpl<$Res, LeagueStats>;
  @useResult
  $Res call({List<VirtualPlayer> players});
}

/// @nodoc
class _$LeagueStatsCopyWithImpl<$Res, $Val extends LeagueStats>
    implements $LeagueStatsCopyWith<$Res> {
  _$LeagueStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeagueStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? players = null}) {
    return _then(
      _value.copyWith(
            players: null == players
                ? _value.players
                : players // ignore: cast_nullable_to_non_nullable
                      as List<VirtualPlayer>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$LeagueStatsImplCopyWith<$Res>
    implements $LeagueStatsCopyWith<$Res> {
  factory _$$LeagueStatsImplCopyWith(
    _$LeagueStatsImpl value,
    $Res Function(_$LeagueStatsImpl) then,
  ) = __$$LeagueStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<VirtualPlayer> players});
}

/// @nodoc
class __$$LeagueStatsImplCopyWithImpl<$Res>
    extends _$LeagueStatsCopyWithImpl<$Res, _$LeagueStatsImpl>
    implements _$$LeagueStatsImplCopyWith<$Res> {
  __$$LeagueStatsImplCopyWithImpl(
    _$LeagueStatsImpl _value,
    $Res Function(_$LeagueStatsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of LeagueStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? players = null}) {
    return _then(
      _$LeagueStatsImpl(
        players: null == players
            ? _value._players
            : players // ignore: cast_nullable_to_non_nullable
                  as List<VirtualPlayer>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$LeagueStatsImpl implements _LeagueStats {
  const _$LeagueStatsImpl({final List<VirtualPlayer> players = const []})
    : _players = players;

  factory _$LeagueStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeagueStatsImplFromJson(json);

  final List<VirtualPlayer> _players;
  @override
  @JsonKey()
  List<VirtualPlayer> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  @override
  String toString() {
    return 'LeagueStats(players: $players)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeagueStatsImpl &&
            const DeepCollectionEquality().equals(other._players, _players));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_players));

  /// Create a copy of LeagueStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeagueStatsImplCopyWith<_$LeagueStatsImpl> get copyWith =>
      __$$LeagueStatsImplCopyWithImpl<_$LeagueStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeagueStatsImplToJson(this);
  }
}

abstract class _LeagueStats implements LeagueStats {
  const factory _LeagueStats({final List<VirtualPlayer> players}) =
      _$LeagueStatsImpl;

  factory _LeagueStats.fromJson(Map<String, dynamic> json) =
      _$LeagueStatsImpl.fromJson;

  @override
  List<VirtualPlayer> get players;

  /// Create a copy of LeagueStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeagueStatsImplCopyWith<_$LeagueStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
