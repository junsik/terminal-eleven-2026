// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InboxMessage _$InboxMessageFromJson(Map<String, dynamic> json) {
  return _InboxMessage.fromJson(json);
}

/// @nodoc
mixin _$InboxMessage {
  String get id => throw _privateConstructorUsedError;
  MessageSender get sender => throw _privateConstructorUsedError;
  MessageCategory get category => throw _privateConstructorUsedError;
  String get senderName => throw _privateConstructorUsedError;
  String get subject => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  int get gameWeek => throw _privateConstructorUsedError; // 게임 내 주차 (라운드)
  DateTime get createdAt => throw _privateConstructorUsedError;
  bool get isRead => throw _privateConstructorUsedError;

  /// Serializes this InboxMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InboxMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InboxMessageCopyWith<InboxMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InboxMessageCopyWith<$Res> {
  factory $InboxMessageCopyWith(
    InboxMessage value,
    $Res Function(InboxMessage) then,
  ) = _$InboxMessageCopyWithImpl<$Res, InboxMessage>;
  @useResult
  $Res call({
    String id,
    MessageSender sender,
    MessageCategory category,
    String senderName,
    String subject,
    String content,
    int gameWeek,
    DateTime createdAt,
    bool isRead,
  });
}

/// @nodoc
class _$InboxMessageCopyWithImpl<$Res, $Val extends InboxMessage>
    implements $InboxMessageCopyWith<$Res> {
  _$InboxMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InboxMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? category = null,
    Object? senderName = null,
    Object? subject = null,
    Object? content = null,
    Object? gameWeek = null,
    Object? createdAt = null,
    Object? isRead = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            sender: null == sender
                ? _value.sender
                : sender // ignore: cast_nullable_to_non_nullable
                      as MessageSender,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as MessageCategory,
            senderName: null == senderName
                ? _value.senderName
                : senderName // ignore: cast_nullable_to_non_nullable
                      as String,
            subject: null == subject
                ? _value.subject
                : subject // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            gameWeek: null == gameWeek
                ? _value.gameWeek
                : gameWeek // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            isRead: null == isRead
                ? _value.isRead
                : isRead // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InboxMessageImplCopyWith<$Res>
    implements $InboxMessageCopyWith<$Res> {
  factory _$$InboxMessageImplCopyWith(
    _$InboxMessageImpl value,
    $Res Function(_$InboxMessageImpl) then,
  ) = __$$InboxMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    MessageSender sender,
    MessageCategory category,
    String senderName,
    String subject,
    String content,
    int gameWeek,
    DateTime createdAt,
    bool isRead,
  });
}

/// @nodoc
class __$$InboxMessageImplCopyWithImpl<$Res>
    extends _$InboxMessageCopyWithImpl<$Res, _$InboxMessageImpl>
    implements _$$InboxMessageImplCopyWith<$Res> {
  __$$InboxMessageImplCopyWithImpl(
    _$InboxMessageImpl _value,
    $Res Function(_$InboxMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InboxMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? sender = null,
    Object? category = null,
    Object? senderName = null,
    Object? subject = null,
    Object? content = null,
    Object? gameWeek = null,
    Object? createdAt = null,
    Object? isRead = null,
  }) {
    return _then(
      _$InboxMessageImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        sender: null == sender
            ? _value.sender
            : sender // ignore: cast_nullable_to_non_nullable
                  as MessageSender,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as MessageCategory,
        senderName: null == senderName
            ? _value.senderName
            : senderName // ignore: cast_nullable_to_non_nullable
                  as String,
        subject: null == subject
            ? _value.subject
            : subject // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        gameWeek: null == gameWeek
            ? _value.gameWeek
            : gameWeek // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        isRead: null == isRead
            ? _value.isRead
            : isRead // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InboxMessageImpl extends _InboxMessage {
  const _$InboxMessageImpl({
    required this.id,
    required this.sender,
    required this.category,
    required this.senderName,
    required this.subject,
    required this.content,
    required this.gameWeek,
    required this.createdAt,
    this.isRead = false,
  }) : super._();

  factory _$InboxMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$InboxMessageImplFromJson(json);

  @override
  final String id;
  @override
  final MessageSender sender;
  @override
  final MessageCategory category;
  @override
  final String senderName;
  @override
  final String subject;
  @override
  final String content;
  @override
  final int gameWeek;
  // 게임 내 주차 (라운드)
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final bool isRead;

  @override
  String toString() {
    return 'InboxMessage(id: $id, sender: $sender, category: $category, senderName: $senderName, subject: $subject, content: $content, gameWeek: $gameWeek, createdAt: $createdAt, isRead: $isRead)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InboxMessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.senderName, senderName) ||
                other.senderName == senderName) &&
            (identical(other.subject, subject) || other.subject == subject) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.gameWeek, gameWeek) ||
                other.gameWeek == gameWeek) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.isRead, isRead) || other.isRead == isRead));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    sender,
    category,
    senderName,
    subject,
    content,
    gameWeek,
    createdAt,
    isRead,
  );

  /// Create a copy of InboxMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InboxMessageImplCopyWith<_$InboxMessageImpl> get copyWith =>
      __$$InboxMessageImplCopyWithImpl<_$InboxMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InboxMessageImplToJson(this);
  }
}

abstract class _InboxMessage extends InboxMessage {
  const factory _InboxMessage({
    required final String id,
    required final MessageSender sender,
    required final MessageCategory category,
    required final String senderName,
    required final String subject,
    required final String content,
    required final int gameWeek,
    required final DateTime createdAt,
    final bool isRead,
  }) = _$InboxMessageImpl;
  const _InboxMessage._() : super._();

  factory _InboxMessage.fromJson(Map<String, dynamic> json) =
      _$InboxMessageImpl.fromJson;

  @override
  String get id;
  @override
  MessageSender get sender;
  @override
  MessageCategory get category;
  @override
  String get senderName;
  @override
  String get subject;
  @override
  String get content;
  @override
  int get gameWeek; // 게임 내 주차 (라운드)
  @override
  DateTime get createdAt;
  @override
  bool get isRead;

  /// Create a copy of InboxMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InboxMessageImplCopyWith<_$InboxMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
