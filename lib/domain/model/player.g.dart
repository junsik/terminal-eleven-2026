// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PlayerProfileImpl _$$PlayerProfileImplFromJson(Map<String, dynamic> json) =>
    _$PlayerProfileImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      age: (json['age'] as num).toInt(),
      archetype: $enumDecode(_$PlayerArchetypeEnumMap, json['archetype']),
      teamId: json['teamId'] as String,
      position: $enumDecode(_$PlayerPositionEnumMap, json['position']),
    );

Map<String, dynamic> _$$PlayerProfileImplToJson(_$PlayerProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'archetype': _$PlayerArchetypeEnumMap[instance.archetype]!,
      'teamId': instance.teamId,
      'position': _$PlayerPositionEnumMap[instance.position]!,
    };

const _$PlayerArchetypeEnumMap = {
  PlayerArchetype.poacher: 'poacher',
  PlayerArchetype.speedster: 'speedster',
  PlayerArchetype.pressingForward: 'pressingForward',
  PlayerArchetype.targetMan: 'targetMan',
  PlayerArchetype.creator: 'creator',
  PlayerArchetype.boxToBox: 'boxToBox',
  PlayerArchetype.ballWinning: 'ballWinning',
  PlayerArchetype.stopper: 'stopper',
  PlayerArchetype.sweeper: 'sweeper',
  PlayerArchetype.fullBack: 'fullBack',
};

const _$PlayerPositionEnumMap = {
  PlayerPosition.forward: 'forward',
  PlayerPosition.midfielder: 'midfielder',
  PlayerPosition.defender: 'defender',
  PlayerPosition.goalkeeper: 'goalkeeper',
};

_$PlayerStatsImpl _$$PlayerStatsImplFromJson(Map<String, dynamic> json) =>
    _$PlayerStatsImpl(
      pace: (json['pace'] as num?)?.toInt() ?? 50,
      shooting: (json['shooting'] as num?)?.toInt() ?? 50,
      passing: (json['passing'] as num?)?.toInt() ?? 50,
      ballControl: (json['ballControl'] as num?)?.toInt() ?? 50,
      positioning: (json['positioning'] as num?)?.toInt() ?? 50,
      stamina: (json['stamina'] as num?)?.toInt() ?? 50,
      composure: (json['composure'] as num?)?.toInt() ?? 50,
      defending: (json['defending'] as num?)?.toInt() ?? 50,
    );

Map<String, dynamic> _$$PlayerStatsImplToJson(_$PlayerStatsImpl instance) =>
    <String, dynamic>{
      'pace': instance.pace,
      'shooting': instance.shooting,
      'passing': instance.passing,
      'ballControl': instance.ballControl,
      'positioning': instance.positioning,
      'stamina': instance.stamina,
      'composure': instance.composure,
      'defending': instance.defending,
    };

_$PlayerStatusImpl _$$PlayerStatusImplFromJson(Map<String, dynamic> json) =>
    _$PlayerStatusImpl(
      fatigue: (json['fatigue'] as num?)?.toInt() ?? 0,
      confidence: (json['confidence'] as num?)?.toInt() ?? 0,
      injury:
          $enumDecodeNullable(_$InjuryStatusEnumMap, json['injury']) ??
          InjuryStatus.none,
      injuryWeeksRemaining:
          (json['injuryWeeksRemaining'] as num?)?.toInt() ?? 0,
      form:
          $enumDecodeNullable(_$FormTrendEnumMap, json['form']) ??
          FormTrend.average,
    );

Map<String, dynamic> _$$PlayerStatusImplToJson(_$PlayerStatusImpl instance) =>
    <String, dynamic>{
      'fatigue': instance.fatigue,
      'confidence': instance.confidence,
      'injury': _$InjuryStatusEnumMap[instance.injury]!,
      'injuryWeeksRemaining': instance.injuryWeeksRemaining,
      'form': _$FormTrendEnumMap[instance.form]!,
    };

const _$InjuryStatusEnumMap = {
  InjuryStatus.none: 'none',
  InjuryStatus.minor: 'minor',
  InjuryStatus.moderate: 'moderate',
  InjuryStatus.severe: 'severe',
};

const _$FormTrendEnumMap = {
  FormTrend.excellent: 'excellent',
  FormTrend.good: 'good',
  FormTrend.average: 'average',
  FormTrend.poor: 'poor',
};

_$PlayerCareerImpl _$$PlayerCareerImplFromJson(Map<String, dynamic> json) =>
    _$PlayerCareerImpl(
      level: (json['level'] as num?)?.toInt() ?? 1,
      xp: (json['xp'] as num?)?.toInt() ?? 0,
      trust: (json['trust'] as num?)?.toInt() ?? 30,
      reputation: (json['reputation'] as num?)?.toInt() ?? 0,
      lastRatings:
          (json['lastRatings'] as List<dynamic>?)
              ?.map((e) => (e as num).toDouble())
              .toList() ??
          const [],
      totalGoals: (json['totalGoals'] as num?)?.toInt() ?? 0,
      totalAssists: (json['totalAssists'] as num?)?.toInt() ?? 0,
      matchesPlayed: (json['matchesPlayed'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$PlayerCareerImplToJson(_$PlayerCareerImpl instance) =>
    <String, dynamic>{
      'level': instance.level,
      'xp': instance.xp,
      'trust': instance.trust,
      'reputation': instance.reputation,
      'lastRatings': instance.lastRatings,
      'totalGoals': instance.totalGoals,
      'totalAssists': instance.totalAssists,
      'matchesPlayed': instance.matchesPlayed,
    };

_$PlayerCharacterImpl _$$PlayerCharacterImplFromJson(
  Map<String, dynamic> json,
) => _$PlayerCharacterImpl(
  profile: PlayerProfile.fromJson(json['profile'] as Map<String, dynamic>),
  stats: PlayerStats.fromJson(json['stats'] as Map<String, dynamic>),
  status: PlayerStatus.fromJson(json['status'] as Map<String, dynamic>),
  career: PlayerCareer.fromJson(json['career'] as Map<String, dynamic>),
);

Map<String, dynamic> _$$PlayerCharacterImplToJson(
  _$PlayerCharacterImpl instance,
) => <String, dynamic>{
  'profile': instance.profile,
  'stats': instance.stats,
  'status': instance.status,
  'career': instance.career,
};
