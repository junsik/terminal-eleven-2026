// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_snapshot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameSnapshotImpl _$$GameSnapshotImplFromJson(Map<String, dynamic> json) =>
    _$GameSnapshotImpl(
      version: (json['version'] as num?)?.toInt() ?? 1,
      savedAt: DateTime.parse(json['savedAt'] as String),
      gameState:
          $enumDecodeNullable(_$GameStateEnumMap, json['gameState']) ??
          GameState.boot,
      pc: PlayerCharacter.fromJson(json['pc'] as Map<String, dynamic>),
      season: Season.fromJson(json['season'] as Map<String, dynamic>),
      activeMatch: json['activeMatch'] == null
          ? null
          : MatchSession.fromJson(json['activeMatch'] as Map<String, dynamic>),
      weeklyActionsRemaining:
          (json['weeklyActionsRemaining'] as num?)?.toInt() ?? 3,
    );

Map<String, dynamic> _$$GameSnapshotImplToJson(_$GameSnapshotImpl instance) =>
    <String, dynamic>{
      'version': instance.version,
      'savedAt': instance.savedAt.toIso8601String(),
      'gameState': _$GameStateEnumMap[instance.gameState]!,
      'pc': instance.pc,
      'season': instance.season,
      'activeMatch': instance.activeMatch,
      'weeklyActionsRemaining': instance.weeklyActionsRemaining,
    };

const _$GameStateEnumMap = {
  GameState.boot: 'boot',
  GameState.home: 'home',
  GameState.training: 'training',
  GameState.preMatch: 'preMatch',
  GameState.match: 'match',
  GameState.postMatch: 'postMatch',
};
