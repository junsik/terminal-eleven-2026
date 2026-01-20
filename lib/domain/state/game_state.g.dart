// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      player: PlayerState.fromJson(json['player'] as Map<String, dynamic>),
      season: SeasonState.fromJson(json['season'] as Map<String, dynamic>),
      ui: UIScreenState.fromJson(json['ui'] as Map<String, dynamic>),
      meta: MetaState.fromJson(json['meta'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'player': instance.player,
      'season': instance.season,
      'ui': instance.ui,
      'meta': instance.meta,
    };

_$PlayerStateImpl _$$PlayerStateImplFromJson(Map<String, dynamic> json) =>
    _$PlayerStateImpl(
      character: PlayerCharacter.fromJson(
        json['character'] as Map<String, dynamic>,
      ),
      weeklyActionsRemaining:
          (json['weeklyActionsRemaining'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$$PlayerStateImplToJson(_$PlayerStateImpl instance) =>
    <String, dynamic>{
      'character': instance.character,
      'weeklyActionsRemaining': instance.weeklyActionsRemaining,
    };

_$SeasonStateImpl _$$SeasonStateImplFromJson(Map<String, dynamic> json) =>
    _$SeasonStateImpl(
      id: json['id'] as String,
      year: (json['year'] as num).toInt(),
      currentRound: (json['currentRound'] as num?)?.toInt() ?? 1,
      teams: (json['teams'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, Team.fromJson(e as Map<String, dynamic>)),
      ),
      fixtures: (json['fixtures'] as List<dynamic>)
          .map((e) => Fixture.fromJson(e as Map<String, dynamic>))
          .toList(),
      standings: (json['standings'] as List<dynamic>)
          .map((e) => StandingRow.fromJson(e as Map<String, dynamic>))
          .toList(),
      leagueStats: json['leagueStats'] == null
          ? null
          : LeagueStats.fromJson(json['leagueStats'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$SeasonStateImplToJson(_$SeasonStateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'currentRound': instance.currentRound,
      'teams': instance.teams,
      'fixtures': instance.fixtures,
      'standings': instance.standings,
      'leagueStats': instance.leagueStats,
    };

_$UIScreenStateImpl _$$UIScreenStateImplFromJson(Map<String, dynamic> json) =>
    _$UIScreenStateImpl(
      screen:
          $enumDecodeNullable(_$UIScreenEnumMap, json['screen']) ??
          UIScreen.boot,
      activeMatch: json['activeMatch'] == null
          ? null
          : MatchSession.fromJson(json['activeMatch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UIScreenStateImplToJson(_$UIScreenStateImpl instance) =>
    <String, dynamic>{
      'screen': _$UIScreenEnumMap[instance.screen]!,
      'activeMatch': instance.activeMatch,
    };

const _$UIScreenEnumMap = {
  UIScreen.boot: 'boot',
  UIScreen.home: 'home',
  UIScreen.training: 'training',
  UIScreen.preMatch: 'preMatch',
  UIScreen.match: 'match',
  UIScreen.postMatch: 'postMatch',
};

_$MetaStateImpl _$$MetaStateImplFromJson(Map<String, dynamic> json) =>
    _$MetaStateImpl(
      version: (json['version'] as num?)?.toInt() ?? 1,
      savedAt: DateTime.parse(json['savedAt'] as String),
    );

Map<String, dynamic> _$$MetaStateImplToJson(_$MetaStateImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
      'savedAt': instance.savedAt.toIso8601String(),
    };
