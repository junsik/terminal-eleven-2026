// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TeamImpl _$$TeamImplFromJson(Map<String, dynamic> json) => _$TeamImpl(
  id: json['id'] as String,
  name: json['name'] as String,
  attackRating: (json['attackRating'] as num?)?.toInt() ?? 50,
  defenseRating: (json['defenseRating'] as num?)?.toInt() ?? 50,
  overallRating: (json['overallRating'] as num?)?.toInt() ?? 50,
);

Map<String, dynamic> _$$TeamImplToJson(_$TeamImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'attackRating': instance.attackRating,
      'defenseRating': instance.defenseRating,
      'overallRating': instance.overallRating,
    };

_$StandingRowImpl _$$StandingRowImplFromJson(Map<String, dynamic> json) =>
    _$StandingRowImpl(
      teamId: json['teamId'] as String,
      teamName: json['teamName'] as String,
      played: (json['played'] as num?)?.toInt() ?? 0,
      won: (json['won'] as num?)?.toInt() ?? 0,
      drawn: (json['drawn'] as num?)?.toInt() ?? 0,
      lost: (json['lost'] as num?)?.toInt() ?? 0,
      goalsFor: (json['goalsFor'] as num?)?.toInt() ?? 0,
      goalsAgainst: (json['goalsAgainst'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$StandingRowImplToJson(_$StandingRowImpl instance) =>
    <String, dynamic>{
      'teamId': instance.teamId,
      'teamName': instance.teamName,
      'played': instance.played,
      'won': instance.won,
      'drawn': instance.drawn,
      'lost': instance.lost,
      'goalsFor': instance.goalsFor,
      'goalsAgainst': instance.goalsAgainst,
    };

_$FixtureImpl _$$FixtureImplFromJson(Map<String, dynamic> json) =>
    _$FixtureImpl(
      id: json['id'] as String,
      round: (json['round'] as num).toInt(),
      homeTeamId: json['homeTeamId'] as String,
      awayTeamId: json['awayTeamId'] as String,
      isPlayed: json['isPlayed'] as bool? ?? false,
      homeScore: (json['homeScore'] as num?)?.toInt(),
      awayScore: (json['awayScore'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$FixtureImplToJson(_$FixtureImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'round': instance.round,
      'homeTeamId': instance.homeTeamId,
      'awayTeamId': instance.awayTeamId,
      'isPlayed': instance.isPlayed,
      'homeScore': instance.homeScore,
      'awayScore': instance.awayScore,
    };

_$SeasonImpl _$$SeasonImplFromJson(Map<String, dynamic> json) => _$SeasonImpl(
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
);

Map<String, dynamic> _$$SeasonImplToJson(_$SeasonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'year': instance.year,
      'currentRound': instance.currentRound,
      'teams': instance.teams,
      'fixtures': instance.fixtures,
      'standings': instance.standings,
    };
