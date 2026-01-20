// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_snapshot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

GameSnapshot _$GameSnapshotFromJson(Map<String, dynamic> json) {
  return _GameSnapshot.fromJson(json);
}

/// @nodoc
mixin _$GameSnapshot {
  int get version => throw _privateConstructorUsedError; // 스냅샷 버전
  DateTime get savedAt => throw _privateConstructorUsedError; // 저장 시간
  GameState get gameState => throw _privateConstructorUsedError; // 현재 게임 상태
  PlayerCharacter get pc => throw _privateConstructorUsedError; // 플레이어 캐릭터
  Season get season => throw _privateConstructorUsedError; // 현재 시즌
  MatchSession? get activeMatch =>
      throw _privateConstructorUsedError; // 진행 중인 경기 (있을 경우)
  int get weeklyActionsRemaining =>
      throw _privateConstructorUsedError; // 이번 주 남은 행동 횟수
  LeagueStats? get leagueStats =>
      throw _privateConstructorUsedError; // 개인 순위용 리그 통계
  List<InboxMessage> get inboxMessages => throw _privateConstructorUsedError;

  /// Serializes this GameSnapshot to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameSnapshotCopyWith<GameSnapshot> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameSnapshotCopyWith<$Res> {
  factory $GameSnapshotCopyWith(
    GameSnapshot value,
    $Res Function(GameSnapshot) then,
  ) = _$GameSnapshotCopyWithImpl<$Res, GameSnapshot>;
  @useResult
  $Res call({
    int version,
    DateTime savedAt,
    GameState gameState,
    PlayerCharacter pc,
    Season season,
    MatchSession? activeMatch,
    int weeklyActionsRemaining,
    LeagueStats? leagueStats,
    List<InboxMessage> inboxMessages,
  });

  $PlayerCharacterCopyWith<$Res> get pc;
  $SeasonCopyWith<$Res> get season;
  $MatchSessionCopyWith<$Res>? get activeMatch;
  $LeagueStatsCopyWith<$Res>? get leagueStats;
}

/// @nodoc
class _$GameSnapshotCopyWithImpl<$Res, $Val extends GameSnapshot>
    implements $GameSnapshotCopyWith<$Res> {
  _$GameSnapshotCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? savedAt = null,
    Object? gameState = null,
    Object? pc = null,
    Object? season = null,
    Object? activeMatch = freezed,
    Object? weeklyActionsRemaining = null,
    Object? leagueStats = freezed,
    Object? inboxMessages = null,
  }) {
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
            gameState: null == gameState
                ? _value.gameState
                : gameState // ignore: cast_nullable_to_non_nullable
                      as GameState,
            pc: null == pc
                ? _value.pc
                : pc // ignore: cast_nullable_to_non_nullable
                      as PlayerCharacter,
            season: null == season
                ? _value.season
                : season // ignore: cast_nullable_to_non_nullable
                      as Season,
            activeMatch: freezed == activeMatch
                ? _value.activeMatch
                : activeMatch // ignore: cast_nullable_to_non_nullable
                      as MatchSession?,
            weeklyActionsRemaining: null == weeklyActionsRemaining
                ? _value.weeklyActionsRemaining
                : weeklyActionsRemaining // ignore: cast_nullable_to_non_nullable
                      as int,
            leagueStats: freezed == leagueStats
                ? _value.leagueStats
                : leagueStats // ignore: cast_nullable_to_non_nullable
                      as LeagueStats?,
            inboxMessages: null == inboxMessages
                ? _value.inboxMessages
                : inboxMessages // ignore: cast_nullable_to_non_nullable
                      as List<InboxMessage>,
          )
          as $Val,
    );
  }

  /// Create a copy of GameSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlayerCharacterCopyWith<$Res> get pc {
    return $PlayerCharacterCopyWith<$Res>(_value.pc, (value) {
      return _then(_value.copyWith(pc: value) as $Val);
    });
  }

  /// Create a copy of GameSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SeasonCopyWith<$Res> get season {
    return $SeasonCopyWith<$Res>(_value.season, (value) {
      return _then(_value.copyWith(season: value) as $Val);
    });
  }

  /// Create a copy of GameSnapshot
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

  /// Create a copy of GameSnapshot
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
abstract class _$$GameSnapshotImplCopyWith<$Res>
    implements $GameSnapshotCopyWith<$Res> {
  factory _$$GameSnapshotImplCopyWith(
    _$GameSnapshotImpl value,
    $Res Function(_$GameSnapshotImpl) then,
  ) = __$$GameSnapshotImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int version,
    DateTime savedAt,
    GameState gameState,
    PlayerCharacter pc,
    Season season,
    MatchSession? activeMatch,
    int weeklyActionsRemaining,
    LeagueStats? leagueStats,
    List<InboxMessage> inboxMessages,
  });

  @override
  $PlayerCharacterCopyWith<$Res> get pc;
  @override
  $SeasonCopyWith<$Res> get season;
  @override
  $MatchSessionCopyWith<$Res>? get activeMatch;
  @override
  $LeagueStatsCopyWith<$Res>? get leagueStats;
}

/// @nodoc
class __$$GameSnapshotImplCopyWithImpl<$Res>
    extends _$GameSnapshotCopyWithImpl<$Res, _$GameSnapshotImpl>
    implements _$$GameSnapshotImplCopyWith<$Res> {
  __$$GameSnapshotImplCopyWithImpl(
    _$GameSnapshotImpl _value,
    $Res Function(_$GameSnapshotImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of GameSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? version = null,
    Object? savedAt = null,
    Object? gameState = null,
    Object? pc = null,
    Object? season = null,
    Object? activeMatch = freezed,
    Object? weeklyActionsRemaining = null,
    Object? leagueStats = freezed,
    Object? inboxMessages = null,
  }) {
    return _then(
      _$GameSnapshotImpl(
        version: null == version
            ? _value.version
            : version // ignore: cast_nullable_to_non_nullable
                  as int,
        savedAt: null == savedAt
            ? _value.savedAt
            : savedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        gameState: null == gameState
            ? _value.gameState
            : gameState // ignore: cast_nullable_to_non_nullable
                  as GameState,
        pc: null == pc
            ? _value.pc
            : pc // ignore: cast_nullable_to_non_nullable
                  as PlayerCharacter,
        season: null == season
            ? _value.season
            : season // ignore: cast_nullable_to_non_nullable
                  as Season,
        activeMatch: freezed == activeMatch
            ? _value.activeMatch
            : activeMatch // ignore: cast_nullable_to_non_nullable
                  as MatchSession?,
        weeklyActionsRemaining: null == weeklyActionsRemaining
            ? _value.weeklyActionsRemaining
            : weeklyActionsRemaining // ignore: cast_nullable_to_non_nullable
                  as int,
        leagueStats: freezed == leagueStats
            ? _value.leagueStats
            : leagueStats // ignore: cast_nullable_to_non_nullable
                  as LeagueStats?,
        inboxMessages: null == inboxMessages
            ? _value._inboxMessages
            : inboxMessages // ignore: cast_nullable_to_non_nullable
                  as List<InboxMessage>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$GameSnapshotImpl implements _GameSnapshot {
  const _$GameSnapshotImpl({
    this.version = 1,
    required this.savedAt,
    this.gameState = GameState.boot,
    required this.pc,
    required this.season,
    this.activeMatch,
    this.weeklyActionsRemaining = 3,
    this.leagueStats,
    final List<InboxMessage> inboxMessages = const [],
  }) : _inboxMessages = inboxMessages;

  factory _$GameSnapshotImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameSnapshotImplFromJson(json);

  @override
  @JsonKey()
  final int version;
  // 스냅샷 버전
  @override
  final DateTime savedAt;
  // 저장 시간
  @override
  @JsonKey()
  final GameState gameState;
  // 현재 게임 상태
  @override
  final PlayerCharacter pc;
  // 플레이어 캐릭터
  @override
  final Season season;
  // 현재 시즌
  @override
  final MatchSession? activeMatch;
  // 진행 중인 경기 (있을 경우)
  @override
  @JsonKey()
  final int weeklyActionsRemaining;
  // 이번 주 남은 행동 횟수
  @override
  final LeagueStats? leagueStats;
  // 개인 순위용 리그 통계
  final List<InboxMessage> _inboxMessages;
  // 개인 순위용 리그 통계
  @override
  @JsonKey()
  List<InboxMessage> get inboxMessages {
    if (_inboxMessages is EqualUnmodifiableListView) return _inboxMessages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_inboxMessages);
  }

  @override
  String toString() {
    return 'GameSnapshot(version: $version, savedAt: $savedAt, gameState: $gameState, pc: $pc, season: $season, activeMatch: $activeMatch, weeklyActionsRemaining: $weeklyActionsRemaining, leagueStats: $leagueStats, inboxMessages: $inboxMessages)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameSnapshotImpl &&
            (identical(other.version, version) || other.version == version) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt) &&
            (identical(other.gameState, gameState) ||
                other.gameState == gameState) &&
            (identical(other.pc, pc) || other.pc == pc) &&
            (identical(other.season, season) || other.season == season) &&
            (identical(other.activeMatch, activeMatch) ||
                other.activeMatch == activeMatch) &&
            (identical(other.weeklyActionsRemaining, weeklyActionsRemaining) ||
                other.weeklyActionsRemaining == weeklyActionsRemaining) &&
            (identical(other.leagueStats, leagueStats) ||
                other.leagueStats == leagueStats) &&
            const DeepCollectionEquality().equals(
              other._inboxMessages,
              _inboxMessages,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    version,
    savedAt,
    gameState,
    pc,
    season,
    activeMatch,
    weeklyActionsRemaining,
    leagueStats,
    const DeepCollectionEquality().hash(_inboxMessages),
  );

  /// Create a copy of GameSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameSnapshotImplCopyWith<_$GameSnapshotImpl> get copyWith =>
      __$$GameSnapshotImplCopyWithImpl<_$GameSnapshotImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameSnapshotImplToJson(this);
  }
}

abstract class _GameSnapshot implements GameSnapshot {
  const factory _GameSnapshot({
    final int version,
    required final DateTime savedAt,
    final GameState gameState,
    required final PlayerCharacter pc,
    required final Season season,
    final MatchSession? activeMatch,
    final int weeklyActionsRemaining,
    final LeagueStats? leagueStats,
    final List<InboxMessage> inboxMessages,
  }) = _$GameSnapshotImpl;

  factory _GameSnapshot.fromJson(Map<String, dynamic> json) =
      _$GameSnapshotImpl.fromJson;

  @override
  int get version; // 스냅샷 버전
  @override
  DateTime get savedAt; // 저장 시간
  @override
  GameState get gameState; // 현재 게임 상태
  @override
  PlayerCharacter get pc; // 플레이어 캐릭터
  @override
  Season get season; // 현재 시즌
  @override
  MatchSession? get activeMatch; // 진행 중인 경기 (있을 경우)
  @override
  int get weeklyActionsRemaining; // 이번 주 남은 행동 횟수
  @override
  LeagueStats? get leagueStats; // 개인 순위용 리그 통계
  @override
  List<InboxMessage> get inboxMessages;

  /// Create a copy of GameSnapshot
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameSnapshotImplCopyWith<_$GameSnapshotImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
