// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InboxMessageImpl _$$InboxMessageImplFromJson(Map<String, dynamic> json) =>
    _$InboxMessageImpl(
      id: json['id'] as String,
      sender: $enumDecode(_$MessageSenderEnumMap, json['sender']),
      category: $enumDecode(_$MessageCategoryEnumMap, json['category']),
      senderName: json['senderName'] as String,
      subject: json['subject'] as String,
      content: json['content'] as String,
      gameWeek: (json['gameWeek'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      isRead: json['isRead'] as bool? ?? false,
    );

Map<String, dynamic> _$$InboxMessageImplToJson(_$InboxMessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender': _$MessageSenderEnumMap[instance.sender]!,
      'category': _$MessageCategoryEnumMap[instance.category]!,
      'senderName': instance.senderName,
      'subject': instance.subject,
      'content': instance.content,
      'gameWeek': instance.gameWeek,
      'createdAt': instance.createdAt.toIso8601String(),
      'isRead': instance.isRead,
    };

const _$MessageSenderEnumMap = {
  MessageSender.coach: 'coach',
  MessageSender.agent: 'agent',
  MessageSender.fan: 'fan',
  MessageSender.media: 'media',
  MessageSender.system: 'system',
};

const _$MessageCategoryEnumMap = {
  MessageCategory.welcome: 'welcome',
  MessageCategory.training: 'training',
  MessageCategory.matchResult: 'matchResult',
  MessageCategory.levelUp: 'levelUp',
  MessageCategory.injury: 'injury',
  MessageCategory.trust: 'trust',
  MessageCategory.milestone: 'milestone',
  MessageCategory.form: 'form',
  MessageCategory.general: 'general',
};
