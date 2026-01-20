// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'command.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CommandImpl _$$CommandImplFromJson(Map<String, dynamic> json) =>
    _$CommandImpl(
      type: $enumDecode(_$CommandTypeEnumMap, json['type']),
      payload: json['payload'] as Map<String, dynamic>? ?? const {},
      issuedAt: json['issuedAt'] == null
          ? null
          : DateTime.parse(json['issuedAt'] as String),
    );

Map<String, dynamic> _$$CommandImplToJson(_$CommandImpl instance) =>
    <String, dynamic>{
      'type': _$CommandTypeEnumMap[instance.type]!,
      'payload': instance.payload,
      'issuedAt': instance.issuedAt?.toIso8601String(),
    };

const _$CommandTypeEnumMap = {
  CommandType.shoot: 'shoot',
  CommandType.pass: 'pass',
  CommandType.dribble: 'dribble',
  CommandType.safePlay: 'safePlay',
  CommandType.press: 'press',
  CommandType.contain: 'contain',
  CommandType.tackle: 'tackle',
  CommandType.fallBack: 'fallBack',
  CommandType.compose: 'compose',
  CommandType.forcePlay: 'forcePlay',
  CommandType.callForBall: 'callForBall',
  CommandType.accept: 'accept',
  CommandType.askRole: 'askRole',
  CommandType.ignore: 'ignore',
  CommandType.chipShot: 'chipShot',
  CommandType.knuckleShot: 'knuckleShot',
  CommandType.panenka: 'panenka',
  CommandType.powerShot: 'powerShot',
  CommandType.curvedShot: 'curvedShot',
  CommandType.shoutEncourage: 'shoutEncourage',
  CommandType.shoutDemand: 'shoutDemand',
  CommandType.shoutCalm: 'shoutCalm',
};
