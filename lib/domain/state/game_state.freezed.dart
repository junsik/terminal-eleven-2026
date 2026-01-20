// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  /// 플레이어 상태
  PlayerState get player => throw _privateConstructorUsedError;

  /// 시즌/리그 상태
  SeasonState get season => throw _privateConstructorUsedError;

  /// UI 상태
  UIScreenState get ui => throw _privateConstructorUsedError;

  /// 메타 정보
  MetaState get meta => throw _privateConstructorUsedError;

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call({
    PlayerState player,
    SeasonState season,
    UIScreenState ui,
    MetaState meta,
  });

  $PlayerStateCopyWith<$Res> get player;
  $SeasonStateCopyWith<$Res> get season;
  $UIScreenStateCopyWith<$Res> get ui;
  $MetaStateCopyWith<$Res> get meta;
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? season = null,
    Object? ui = null,
    Object? meta = null,
  }) {
    return _then(
      _value.copyWith(
            player: null == player
                ? _value.player
                : player // ignore: cast_nullable_to_non_nullable
                      as PlayerState,
            season: null == season
                ? _value.season
                : season // ignore: cast_nullable_to_non_nullable
                      as SeasonState,
            ui: null == ui
                ? _value.ui
                : ui // ignore: cast_nullable_to_non_nullable
                      as UIScreenState,
            meta: null == meta
                ? _value.meta
                : meta // ignore: cast_nullable_to_non_nullable
                      as MetaState,
          )
          as $Val,
    );
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerStateCopyWith<$Res> get player {
    return $PlayerStateCopyWith<$Res>(_value.player, (value) {
      return _then(_value.copyWith(player: value) as $Val);
    });
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeasonStateCopyWith<$Res> get season {
    return $SeasonStateCopyWith<$Res>(_value.season, (value) {
      return _then(_value.copyWith(season: value) as $Val);
    });
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $UIScreenStateCopyWith<$Res> get ui {
    return $UIScreenStateCopyWith<$Res>(_value.ui, (value) {
      return _then(_value.copyWith(ui: value) as $Val);
    });
  }

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MetaStateCopyWith<$Res> get meta {
    return $MetaStateCopyWith<$Res>(_value.meta, (value) {
      return _then(_value.copyWith(meta: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
    _$GameStateImpl value,
    $Res Function(_$GameStateImpl) then,
  ) = __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    PlayerState player,
    SeasonState season,
    UIScreenState ui,
    MetaState meta,
  });

  @override
  $PlayerStateCopyWith<$Res> get player;
  @override
  $SeasonStateCopyWith<$Res> get season;
  @override
  $UIScreenStateCopyWith<$Res> get ui;
  @override
  $MetaStateCopyWith<$Res> get meta;
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
    _$GameStateImpl _value,
    $Res Function(_$GameStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? player = null,
    Object? season = null,
    Object? ui = null,
    Object? meta = null,
  }) {
    return _then(
      _$GameStateImpl(
        player: null == player
            ? _value.player
            : player // ignore: cast_nullable_to_non_nullable
                  as PlayerState,
        season: null == season
            ? _value.season
            : season // ignore: cast_nullable_to_non_nullable
                  as SeasonState,
        ui: null == ui
            ? _value.ui
            : ui // ignore: cast_nullable_to_non_nullable
                  as UIScreenState,
        meta: null == meta
            ? _value.meta
            : meta // ignore: cast_nullable_to_non_nullable
                  as MetaState,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl extends _GameState {
  const _$GameStateImpl({
    required this.player,
    required this.season,
    required this.ui,
    required this.meta,
  }) : super._();

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  /// 플레이어 상태
  @override
  final PlayerState player;

  /// 시즌/리그 상태
  @override
  final SeasonState season;

  /// UI 상태
  @override
  final UIScreenState ui;

  /// 메타 정보
  @override
  final MetaState meta;

  @override
  String toString() {
    return 'GameState(player: $player, season: $season, ui: $ui, meta: $meta)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.player, player) || other.player == player) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.ui, ui) || other.ui == ui) &&
            (identical(other.meta, meta) || other.meta == meta));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, player, season, ui, meta);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(this);
  }
}

abstract class _GameState extends GameState {
  const factory _GameState({
    required final PlayerState player,
    required final SeasonState season,
    required final UIScreenState ui,
    required final MetaState meta,
  }) = _$GameStateImpl;
  const _GameState._() : super._();

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  /// 플레이어 상태
  @override
  PlayerState get player;

  /// 시즌/리그 상태
  @override
  SeasonState get season;

  /// UI 상태
  @override
  UIScreenState get ui;

  /// 메타 정보
  @override
  MetaState get meta;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PlayerState _$PlayerStateFromJson(Map<String, dynamic> json) {
  return _PlayerState.fromJson(json);
}

/// @nodoc
mixin _$PlayerState {
  /// 플레이어 캐릭터 (프로필, 스탯, 상태, 커리어)
  PlayerCharacter get character => throw _privateConstructorUsedError;

  /// 이번 주 남은 행동 횟수
  int get weeklyActionsRemaining => throw _privateConstructorUsedError;

  /// Serializes this PlayerState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PlayerStateCopyWith<PlayerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayerStateCopyWith<$Res> {
  factory $PlayerStateCopyWith(
    PlayerState value,
    $Res Function(PlayerState) then,
  ) = _$PlayerStateCopyWithImpl<$Res, PlayerState>;
  @useResult
  $Res call({PlayerCharacter character, int weeklyActionsRemaining});

  $PlayerCharacterCopyWith<$Res> get character;
}

/// @nodoc
class _$PlayerStateCopyWithImpl<$Res, $Val extends PlayerState>
    implements $PlayerStateCopyWith<$Res> {
  _$PlayerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? character = null, Object? weeklyActionsRemaining = null}) {
    return _then(
      _value.copyWith(
            character: null == character
                ? _value.character
                : character // ignore: cast_nullable_to_non_nullable
                      as PlayerCharacter,
            weeklyActionsRemaining: null == weeklyActionsRemaining
                ? _value.weeklyActionsRemaining
                : weeklyActionsRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerCharacterCopyWith<$Res> get character {
    return $PlayerCharacterCopyWith<$Res>(_value.character, (value) {
      return _then(_value.copyWith(character: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PlayerStateImplCopyWith<$Res>
    implements $PlayerStateCopyWith<$Res> {
  factory _$$PlayerStateImplCopyWith(
    _$PlayerStateImpl value,
    $Res Function(_$PlayerStateImpl) then,
  ) = __$$PlayerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({PlayerCharacter character, int weeklyActionsRemaining});

  @override
  $PlayerCharacterCopyWith<$Res> get character;
}

/// @nodoc
class __$$PlayerStateImplCopyWithImpl<$Res>
    extends _$PlayerStateCopyWithImpl<$Res, _$PlayerStateImpl>
    implements _$$PlayerStateImplCopyWith<$Res> {
  __$$PlayerStateImplCopyWithImpl(
    _$PlayerStateImpl _value,
    $Res Function(_$PlayerStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? character = null, Object? weeklyActionsRemaining = null}) {
    return _then(
      _$PlayerStateImpl(
        character: null == character
            ? _value.character
            : character // ignore: cast_nullable_to_non_nullable
                  as PlayerCharacter,
        weeklyActionsRemaining: null == weeklyActionsRemaining
            ? _value.weeklyActionsRemaining
            : weeklyActionsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PlayerStateImpl extends _PlayerState {
  const _$PlayerStateImpl({
    required this.character,
    this.weeklyActionsRemaining = 3,
  }) : super._();

  factory _$PlayerStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$PlayerStateImplFromJson(json);

  /// 플레이어 캐릭터 (프로필, 스탯, 상태, 커리어)
  @override
  final PlayerCharacter character;

  /// 이번 주 남은 행동 횟수
  @override
  @JsonKey()
  final int weeklyActionsRemaining;

  @override
  String toString() {
    return 'PlayerState(character: $character, weeklyActionsRemaining: $weeklyActionsRemaining)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayerStateImpl &&
            (identical(other.character, character) ||
                other.character == character) &&
            (identical(other.weeklyActionsRemaining, weeklyActionsRemaining) ||
                other.weeklyActionsRemaining == weeklyActionsRemaining));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, character, weeklyActionsRemaining);

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      __$$PlayerStateImplCopyWithImpl<_$PlayerStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PlayerStateImplToJson(this);
  }
}

abstract class _PlayerState extends PlayerState {
  const factory _PlayerState({
    required final PlayerCharacter character,
    final int weeklyActionsRemaining,
  }) = _$PlayerStateImpl;
  const _PlayerState._() : super._();

  factory _PlayerState.fromJson(Map<String, dynamic> json) =
      _$PlayerStateImpl.fromJson;

  /// 플레이어 캐릭터 (프로필, 스탯, 상태, 커리어)
  @override
  PlayerCharacter get character;

  /// 이번 주 남은 행동 횟수
  @override
  int get weeklyActionsRemaining;

  /// Create a copy of PlayerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PlayerStateImplCopyWith<_$PlayerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SeasonState _$SeasonStateFromJson(Map<String, dynamic> json) {
  return _SeasonState.fromJson(json);
}

/// @nodoc
mixin _$SeasonState {
  String get id => throw _privateConstructorUsedError;
  int get year => throw _privateConstructorUsedError;
  int get currentRound => throw _privateConstructorUsedError;

  /// 팀 데이터 (유일한 원천)
  Map<String, Team> get teams => throw _privateConstructorUsedError;

  /// 경기 일정
  List<Fixture> get fixtures => throw _privateConstructorUsedError;

  /// 순위표
  List<StandingRow> get standings => throw _privateConstructorUsedError;

  /// 개인 순위용 리그 통계
  LeagueStats? get leagueStats => throw _privateConstructorUsedError;

  /// Serializes this SeasonState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SeasonState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SeasonStateCopyWith<SeasonState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SeasonStateCopyWith<$Res> {
  factory $SeasonStateCopyWith(
    SeasonState value,
    $Res Function(SeasonState) then,
  ) = _$SeasonStateCopyWithImpl<$Res, SeasonState>;
  @useResult
  $Res call({
    String id,
    int year,
    int currentRound,
    Map<String, Team> teams,
    List<Fixture> fixtures,
    List<StandingRow> standings,
    LeagueStats? leagueStats,
  });

  $LeagueStatsCopyWith<$Res>? get leagueStats;
}

/// @nodoc
class _$SeasonStateCopyWithImpl<$Res, $Val extends SeasonState>
    implements $SeasonStateCopyWith<$Res> {
  _$SeasonStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SeasonState
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
    Object? leagueStats = freezed,
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
            leagueStats: freezed == leagueStats
                ? _value.leagueStats
                : leagueStats // ignore: cast_nullable_to_non_nullable
                      as LeagueStats?,
          )
          as $Val,
    );
  }

  /// Create a copy of SeasonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LeagueStatsCopyWith<$Res>? get leagueStats {
    if (_value.leagueStats == null) {
      return null;
    }

    return $LeagueStatsCopyWith<$Res>(_value.leagueStats!, (value) {
      return _then(_value.copyWith(leagueStats: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SeasonStateImplCopyWith<$Res>
    implements $SeasonStateCopyWith<$Res> {
  factory _$$SeasonStateImplCopyWith(
    _$SeasonStateImpl value,
    $Res Function(_$SeasonStateImpl) then,
  ) = __$$SeasonStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int year,
    int currentRound,
    Map<String, Team> teams,
    List<Fixture> fixtures,
    List<StandingRow> standings,
    LeagueStats? leagueStats,
  });

  @override
  $LeagueStatsCopyWith<$Res>? get leagueStats;
}

/// @nodoc
class __$$SeasonStateImplCopyWithImpl<$Res>
    extends _$SeasonStateCopyWithImpl<$Res, _$SeasonStateImpl>
    implements _$$SeasonStateImplCopyWith<$Res> {
  __$$SeasonStateImplCopyWithImpl(
    _$SeasonStateImpl _value,
    $Res Function(_$SeasonStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SeasonState
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
    Object? leagueStats = freezed,
  }) {
    return _then(
      _$SeasonStateImpl(
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
        leagueStats: freezed == leagueStats
            ? _value.leagueStats
            : leagueStats // ignore: cast_nullable_to_non_nullable
                  as LeagueStats?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$SeasonStateImpl extends _SeasonState {
  const _$SeasonStateImpl({
    required this.id,
    required this.year,
    this.currentRound = 1,
    required final Map<String, Team> teams,
    required final List<Fixture> fixtures,
    required final List<StandingRow> standings,
    this.leagueStats,
  }) : _teams = teams,
       _fixtures = fixtures,
       _standings = standings,
       super._();

  factory _$SeasonStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$SeasonStateImplFromJson(json);

  @override
  final String id;
  @override
  final int year;
  @override
  @JsonKey()
  final int currentRound;

  /// 팀 데이터 (유일한 원천)
  final Map<String, Team> _teams;

  /// 팀 데이터 (유일한 원천)
  @override
  Map<String, Team> get teams {
    if (_teams is EqualUnmodifiableMapView) return _teams;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_teams);
  }

  /// 경기 일정
  final List<Fixture> _fixtures;

  /// 경기 일정
  @override
  List<Fixture> get fixtures {
    if (_fixtures is EqualUnmodifiableListView) return _fixtures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fixtures);
  }

  /// 순위표
  final List<StandingRow> _standings;

  /// 순위표
  @override
  List<StandingRow> get standings {
    if (_standings is EqualUnmodifiableListView) return _standings;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_standings);
  }

  /// 개인 순위용 리그 통계
  @override
  final LeagueStats? leagueStats;

  @override
  String toString() {
    return 'SeasonState(id: $id, year: $year, currentRound: $currentRound, teams: $teams, fixtures: $fixtures, standings: $standings, leagueStats: $leagueStats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SeasonStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.currentRound, currentRound) ||
                other.currentRound == currentRound) &&
            const DeepCollectionEquality().equals(other._teams, _teams) &&
            const DeepCollectionEquality().equals(other._fixtures, _fixtures) &&
            const DeepCollectionEquality().equals(
              other._standings,
              _standings,
            ) &&
            (identical(other.leagueStats, leagueStats) ||
                other.leagueStats == leagueStats));
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
    leagueStats,
  );

  /// Create a copy of SeasonState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SeasonStateImplCopyWith<_$SeasonStateImpl> get copyWith =>
      __$$SeasonStateImplCopyWithImpl<_$SeasonStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SeasonStateImplToJson(this);
  }
}

abstract class _SeasonState extends SeasonState {
  const factory _SeasonState({
    required final String id,
    required final int year,
    final int currentRound,
    required final Map<String, Team> teams,
    required final List<Fixture> fixtures,
    required final List<StandingRow> standings,
    final LeagueStats? leagueStats,
  }) = _$SeasonStateImpl;
  const _SeasonState._() : super._();

  factory _SeasonState.fromJson(Map<String, dynamic> json) =
      _$SeasonStateImpl.fromJson;

  @override
  String get id;
  @override
  int get year;
  @override
  int get currentRound;

  /// 팀 데이터 (유일한 원천)
  @override
  Map<String, Team> get teams;

  /// 경기 일정
  @override
  List<Fixture> get fixtures;

  /// 순위표
  @override
  List<StandingRow> get standings;

  /// 개인 순위용 리그 통계
  @override
  LeagueStats? get leagueStats;

  /// Create a copy of SeasonState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SeasonStateImplCopyWith<_$SeasonStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

UIScreenState _$UIScreenStateFromJson(Map<String, dynamic> json) {
  return _UIScreenState.fromJson(json);
}

/// @nodoc
mixin _$UIScreenState {
  /// 현재 화면
  UIScreen get screen => throw _privateConstructorUsedError;

  /// 진행 중인 경기 (있을 경우)
  MatchSession? get activeMatch => throw _privateConstructorUsedError;

  /// Serializes this UIScreenState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UIScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UIScreenStateCopyWith<UIScreenState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UIScreenStateCopyWith<$Res> {
  factory $UIScreenStateCopyWith(
    UIScreenState value,
    $Res Function(UIScreenState) then,
  ) = _$UIScreenStateCopyWithImpl<$Res, UIScreenState>;
  @useResult
  $Res call({UIScreen screen, MatchSession? activeMatch});

  $MatchSessionCopyWith<$Res>? get activeMatch;
}

/// @nodoc
class _$UIScreenStateCopyWithImpl<$Res, $Val extends UIScreenState>
    implements $UIScreenStateCopyWith<$Res> {
  _$UIScreenStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UIScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? screen = null, Object? activeMatch = freezed}) {
    return _then(
      _value.copyWith(
            screen: null == screen
                ? _value.screen
                : screen // ignore: cast_nullable_to_non_nullable
                      as UIScreen,
            activeMatch: freezed == activeMatch
                ? _value.activeMatch
                : activeMatch // ignore: cast_nullable_to_non_nullable
                      as MatchSession?,
          )
          as $Val,
    );
  }

  /// Create a copy of UIScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchSessionCopyWith<$Res>? get activeMatch {
    if (_value.activeMatch == null) {
      return null;
    }

    return $MatchSessionCopyWith<$Res>(_value.activeMatch!, (value) {
      return _then(_value.copyWith(activeMatch: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UIScreenStateImplCopyWith<$Res>
    implements $UIScreenStateCopyWith<$Res> {
  factory _$$UIScreenStateImplCopyWith(
    _$UIScreenStateImpl value,
    $Res Function(_$UIScreenStateImpl) then,
  ) = __$$UIScreenStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({UIScreen screen, MatchSession? activeMatch});

  @override
  $MatchSessionCopyWith<$Res>? get activeMatch;
}

/// @nodoc
class __$$UIScreenStateImplCopyWithImpl<$Res>
    extends _$UIScreenStateCopyWithImpl<$Res, _$UIScreenStateImpl>
    implements _$$UIScreenStateImplCopyWith<$Res> {
  __$$UIScreenStateImplCopyWithImpl(
    _$UIScreenStateImpl _value,
    $Res Function(_$UIScreenStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UIScreenState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? screen = null, Object? activeMatch = freezed}) {
    return _then(
      _$UIScreenStateImpl(
        screen: null == screen
            ? _value.screen
            : screen // ignore: cast_nullable_to_non_nullable
                  as UIScreen,
        activeMatch: freezed == activeMatch
            ? _value.activeMatch
            : activeMatch // ignore: cast_nullable_to_non_nullable
                  as MatchSession?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UIScreenStateImpl extends _UIScreenState {
  const _$UIScreenStateImpl({this.screen = UIScreen.boot, this.activeMatch})
    : super._();

  factory _$UIScreenStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$UIScreenStateImplFromJson(json);

  /// 현재 화면
  @override
  @JsonKey()
  final UIScreen screen;

  /// 진행 중인 경기 (있을 경우)
  @override
  final MatchSession? activeMatch;

  @override
  String toString() {
    return 'UIScreenState(screen: $screen, activeMatch: $activeMatch)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UIScreenStateImpl &&
            (identical(other.screen, screen) || other.screen == screen) &&
            (identical(other.activeMatch, activeMatch) ||
                other.activeMatch == activeMatch));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, screen, activeMatch);

  /// Create a copy of UIScreenState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UIScreenStateImplCopyWith<_$UIScreenStateImpl> get copyWith =>
      __$$UIScreenStateImplCopyWithImpl<_$UIScreenStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UIScreenStateImplToJson(this);
  }
}

abstract class _UIScreenState extends UIScreenState {
  const factory _UIScreenState({
    final UIScreen screen,
    final MatchSession? activeMatch,
  }) = _$UIScreenStateImpl;
  const _UIScreenState._() : super._();

  factory _UIScreenState.fromJson(Map<String, dynamic> json) =
      _$UIScreenStateImpl.fromJson;

  /// 현재 화면
  @override
  UIScreen get screen;

  /// 진행 중인 경기 (있을 경우)
  @override
  MatchSession? get activeMatch;

  /// Create a copy of UIScreenState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UIScreenStateImplCopyWith<_$UIScreenStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MetaState _$MetaStateFromJson(Map<String, dynamic> json) {
  return _MetaState.fromJson(json);
}

/// @nodoc
mixin _$MetaState {
  int get version => throw _privateConstructorUsedError;
  DateTime get savedAt => throw _privateConstructorUsedError;

  /// Serializes this MetaState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MetaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MetaStateCopyWith<MetaState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MetaStateCopyWith<$Res> {
  factory $MetaStateCopyWith(MetaState value, $Res Function(MetaState) then) =
      _$MetaStateCopyWithImpl<$Res, MetaState>;
  @useResult
  $Res call({int version, DateTime savedAt});
}

/// @nodoc
class _$MetaStateCopyWithImpl<$Res, $Val extends MetaState>
    implements $MetaStateCopyWith<$Res> {
  _$MetaStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MetaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? version = null, Object? savedAt = null}) {
    return _then(
      _value.copyWith(
            version: null == version
                ? _value.version
                : version // ignore: cast_nullable_to_non_nullable
                      as int,
            savedAt: null == savedAt
                ? _value.savedAt
                : savedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MetaStateImplCopyWith<$Res>
    implements $MetaStateCopyWith<$Res> {
  factory _$$MetaStateImplCopyWith(
    _$MetaStateImpl value,
    $Res Function(_$MetaStateImpl) then,
  ) = __$$MetaStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int version, DateTime savedAt});
}

/// @nodoc
class __$$MetaStateImplCopyWithImpl<$Res>
    extends _$MetaStateCopyWithImpl<$Res, _$MetaStateImpl>
    implements _$$MetaStateImplCopyWith<$Res> {
  __$$MetaStateImplCopyWithImpl(
    _$MetaStateImpl _value,
    $Res Function(_$MetaStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MetaState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? version = null, Object? savedAt = null}) {
    return _then(
      _$MetaStateImpl(
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
        savedAt: null == savedAt
            ? _value.savedAt
            : savedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MetaStateImpl implements _MetaState {
  const _$MetaStateImpl({this.version = 1, required this.savedAt});

  factory _$MetaStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$MetaStateImplFromJson(json);

  @override
  @JsonKey()
  final int version;
  @override
  final DateTime savedAt;

  @override
  String toString() {
    return 'MetaState(version: $version, savedAt: $savedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MetaStateImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, version, savedAt);

  /// Create a copy of MetaState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MetaStateImplCopyWith<_$MetaStateImpl> get copyWith =>
      __$$MetaStateImplCopyWithImpl<_$MetaStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MetaStateImplToJson(this);
  }
}

abstract class _MetaState implements MetaState {
  const factory _MetaState({
    final int version,
    required final DateTime savedAt,
  }) = _$MetaStateImpl;

  factory _MetaState.fromJson(Map<String, dynamic> json) =
      _$MetaStateImpl.fromJson;

  @override
  int get version;
  @override
  DateTime get savedAt;

  /// Create a copy of MetaState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MetaStateImplCopyWith<_$MetaStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
