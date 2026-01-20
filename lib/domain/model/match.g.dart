// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'match.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HighlightEventImpl _$$HighlightEventImplFromJson(Map<String, dynamic> json) =>
    _$HighlightEventImpl(
      minute: (json['minute'] as num).toInt(),
      type: $enumDecode(_$HighlightTypeEnumMap, json['type']),
      zone: $enumDecode(_$FieldZoneEnumMap, json['zone']),
      pressure: (json['pressure'] as num?)?.toInt() ?? 1,
      scoreContext: $enumDecode(_$ScoreContextEnumMap, json['scoreContext']),
      choices: (json['choices'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      selectedChoice: json['selectedChoice'] as String?,
      result: json['result'] == null
          ? null
          : HighlightResult.fromJson(json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$HighlightEventImplToJson(
  _$HighlightEventImpl instance,
) => <String, dynamic>{
  'minute': instance.minute,
  'type': _$HighlightTypeEnumMap[instance.type]!,
  'zone': _$FieldZoneEnumMap[instance.zone]!,
  'pressure': instance.pressure,
  'scoreContext': _$ScoreContextEnumMap[instance.scoreContext]!,
  'choices': instance.choices,
  'selectedChoice': instance.selectedChoice,
  'result': instance.result,
};

const _$HighlightTypeEnumMap = {
  HighlightType.runInBehind: 'runInBehind',
  HighlightType.receiveAndTurn: 'receiveAndTurn',
  HighlightType.oneOnOne: 'oneOnOne',
  HighlightType.edgeOfBoxShot: 'edgeOfBoxShot',
  HighlightType.quickCounter: 'quickCounter',
  HighlightType.pressing: 'pressing',
  HighlightType.defensiveCover: 'defensiveCover',
  HighlightType.looseBall: 'looseBall',
  HighlightType.setPieceRebound: 'setPieceRebound',
  HighlightType.fatigueMoment: 'fatigueMoment',
  HighlightType.mentalPressure: 'mentalPressure',
  HighlightType.coachFeedback: 'coachFeedback',
  HighlightType.penaltyKick: 'penaltyKick',
  HighlightType.clutchChance: 'clutchChance',
};

const _$FieldZoneEnumMap = {
  FieldZone.def: 'def',
  FieldZone.mid: 'mid',
  FieldZone.att: 'att',
  FieldZone.box: 'box',
};

const _$ScoreContextEnumMap = {
  ScoreContext.leading: 'leading',
  ScoreContext.draw: 'draw',
  ScoreContext.trailing: 'trailing',
};

_$HighlightResultImpl _$$HighlightResultImplFromJson(
  Map<String, dynamic> json,
) => _$HighlightResultImpl(
  success: json['success'] as bool,
  isGoal: json['isGoal'] as bool? ?? false,
  isAssist: json['isAssist'] as bool? ?? false,
  isYellowCard: json['isYellowCard'] as bool? ?? false,
  isRedCard: json['isRedCard'] as bool? ?? false,
  isInjury: json['isInjury'] as bool? ?? false,
  ratingChange: (json['ratingChange'] as num?)?.toDouble() ?? 0.0,
  fatigueChange: (json['fatigueChange'] as num?)?.toInt() ?? 0,
  confidenceChange: (json['confidenceChange'] as num?)?.toInt() ?? 0,
  momentumChange: (json['momentumChange'] as num?)?.toInt() ?? 0,
  description: json['description'] as String,
);

Map<String, dynamic> _$$HighlightResultImplToJson(
  _$HighlightResultImpl instance,
) => <String, dynamic>{
  'success': instance.success,
  'isGoal': instance.isGoal,
  'isAssist': instance.isAssist,
  'isYellowCard': instance.isYellowCard,
  'isRedCard': instance.isRedCard,
  'isInjury': instance.isInjury,
  'ratingChange': instance.ratingChange,
  'fatigueChange': instance.fatigueChange,
  'confidenceChange': instance.confidenceChange,
  'momentumChange': instance.momentumChange,
  'description': instance.description,
};

_$LogLineImpl _$$LogLineImplFromJson(Map<String, dynamic> json) =>
    _$LogLineImpl(
      minute: (json['minute'] as num?)?.toInt(),
      type: $enumDecode(_$LogTypeEnumMap, json['type']),
      text: json['text'] as String,
      tags:
          (json['tags'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
    );

Map<String, dynamic> _$$LogLineImplToJson(_$LogLineImpl instance) =>
    <String, dynamic>{
      'minute': instance.minute,
      'type': _$LogTypeEnumMap[instance.type]!,
      'text': instance.text,
      'tags': instance.tags,
    };

const _$LogTypeEnumMap = {
  LogType.commentary: 'commentary',
  LogType.result: 'result',
  LogType.system: 'system',
};

_$ScoreImpl _$$ScoreImplFromJson(Map<String, dynamic> json) => _$ScoreImpl(
  home: (json['home'] as num?)?.toInt() ?? 0,
  away: (json['away'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$ScoreImplToJson(_$ScoreImpl instance) =>
    <String, dynamic>{'home': instance.home, 'away': instance.away};

_$RatingAccumulatorImpl _$$RatingAccumulatorImplFromJson(
  Map<String, dynamic> json,
) => _$RatingAccumulatorImpl(
  goals: (json['goals'] as num?)?.toInt() ?? 0,
  assists: (json['assists'] as num?)?.toInt() ?? 0,
  shotsOnTarget: (json['shotsOnTarget'] as num?)?.toInt() ?? 0,
  keyPasses: (json['keyPasses'] as num?)?.toInt() ?? 0,
  successfulPresses: (json['successfulPresses'] as num?)?.toInt() ?? 0,
  chanceMissed: (json['chanceMissed'] as num?)?.toInt() ?? 0,
  possessionLost: (json['possessionLost'] as num?)?.toInt() ?? 0,
  yellowCards: (json['yellowCards'] as num?)?.toInt() ?? 0,
  redCards: (json['redCards'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$$RatingAccumulatorImplToJson(
  _$RatingAccumulatorImpl instance,
) => <String, dynamic>{
  'goals': instance.goals,
  'assists': instance.assists,
  'shotsOnTarget': instance.shotsOnTarget,
  'keyPasses': instance.keyPasses,
  'successfulPresses': instance.successfulPresses,
  'chanceMissed': instance.chanceMissed,
  'possessionLost': instance.possessionLost,
  'yellowCards': instance.yellowCards,
  'redCards': instance.redCards,
};

_$MatchSessionImpl _$$MatchSessionImplFromJson(Map<String, dynamic> json) =>
    _$MatchSessionImpl(
      id: json['id'] as String,
      fixtureId: json['fixtureId'] as String,
      homeTeamId: json['homeTeamId'] as String,
      awayTeamId: json['awayTeamId'] as String,
      isHome: json['isHome'] as bool,
      phase:
          $enumDecodeNullable(_$MatchPhaseEnumMap, json['phase']) ??
          MatchPhase.intro,
      minute: (json['minute'] as num?)?.toInt() ?? 0,
      score: json['score'] == null
          ? const Score()
          : Score.fromJson(json['score'] as Map<String, dynamic>),
      highlights:
          (json['highlights'] as List<dynamic>?)
              ?.map((e) => HighlightEvent.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      currentHighlightIndex:
          (json['currentHighlightIndex'] as num?)?.toInt() ?? 0,
      log:
          (json['log'] as List<dynamic>?)
              ?.map((e) => LogLine.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      ratingAccumulator: json['ratingAccumulator'] == null
          ? const RatingAccumulator()
          : RatingAccumulator.fromJson(
              json['ratingAccumulator'] as Map<String, dynamic>,
            ),
      rngSeed: (json['rngSeed'] as num).toInt(),
      momentum: (json['momentum'] as num?)?.toInt() ?? 0,
      consecutiveSuccess: (json['consecutiveSuccess'] as num?)?.toInt() ?? 0,
      consecutiveFailure: (json['consecutiveFailure'] as num?)?.toInt() ?? 0,
      lastShoutIndex: (json['lastShoutIndex'] as num?)?.toInt() ?? -1,
    );

Map<String, dynamic> _$$MatchSessionImplToJson(_$MatchSessionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fixtureId': instance.fixtureId,
      'homeTeamId': instance.homeTeamId,
      'awayTeamId': instance.awayTeamId,
      'isHome': instance.isHome,
      'phase': _$MatchPhaseEnumMap[instance.phase]!,
      'minute': instance.minute,
      'score': instance.score,
      'highlights': instance.highlights,
      'currentHighlightIndex': instance.currentHighlightIndex,
      'log': instance.log,
      'ratingAccumulator': instance.ratingAccumulator,
      'rngSeed': instance.rngSeed,
      'momentum': instance.momentum,
      'consecutiveSuccess': instance.consecutiveSuccess,
      'consecutiveFailure': instance.consecutiveFailure,
      'lastShoutIndex': instance.lastShoutIndex,
    };

const _$MatchPhaseEnumMap = {
  MatchPhase.intro: 'intro',
  MatchPhase.highlightPresent: 'highlightPresent',
  MatchPhase.highlightResolve: 'highlightResolve',
  MatchPhase.highlightResult: 'highlightResult',
  MatchPhase.fullTime: 'fullTime',
  MatchPhase.summary: 'summary',
};
