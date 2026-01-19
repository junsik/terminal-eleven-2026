// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VirtualPlayerImpl _$$VirtualPlayerImplFromJson(Map<String, dynamic> json) =>
    _$VirtualPlayerImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      teamId: json['teamId'] as String,
      goals: (json['goals'] as num?)?.toInt() ?? 0,
      assists: (json['assists'] as num?)?.toInt() ?? 0,
      matchesPlayed: (json['matchesPlayed'] as num?)?.toInt() ?? 0,
      ratings:
          (json['ratings'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$VirtualPlayerImplToJson(_$VirtualPlayerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'teamId': instance.teamId,
      'goals': instance.goals,
      'assists': instance.assists,
      'matchesPlayed': instance.matchesPlayed,
      'ratings': instance.ratings,
    };

_$LeagueStatsImpl _$$LeagueStatsImplFromJson(Map<String, dynamic> json) =>
    _$LeagueStatsImpl(
      players:
          (json['players'] as List<dynamic>?)
              ?.map((e) => VirtualPlayer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$LeagueStatsImplToJson(_$LeagueStatsImpl instance) =>
    <String, dynamic>{'players': instance.players};
