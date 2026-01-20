/// 인박스 메시지 모델
///
/// 게임 내 메시지 시스템 - 코치, 에이전트, 팬, 시스템 메시지

import 'package:freezed_annotation/freezed_annotation.dart';

part 'inbox.freezed.dart';
part 'inbox.g.dart';

/// 메시지 발신자 타입
enum MessageSender {
  @JsonValue('coach')
  coach, // 감독
  @JsonValue('agent')
  agent, // 에이전트
  @JsonValue('fan')
  fan, // 팬
  @JsonValue('media')
  media, // 미디어
  @JsonValue('system')
  system, // 시스템
}

/// 메시지 카테고리 (이벤트 트리거 기반)
enum MessageCategory {
  @JsonValue('welcome')
  welcome, // 게임 시작
  @JsonValue('training')
  training, // 훈련 관련
  @JsonValue('matchResult')
  matchResult, // 경기 결과
  @JsonValue('levelUp')
  levelUp, // 레벨업
  @JsonValue('injury')
  injury, // 부상
  @JsonValue('trust')
  trust, // 신뢰도 변화
  @JsonValue('milestone')
  milestone, // 마일스톤 달성
  @JsonValue('form')
  form, // 폼 변화
  @JsonValue('general')
  general, // 일반
}

/// 인박스 메시지
@freezed
class InboxMessage with _$InboxMessage {
  const InboxMessage._();

  const factory InboxMessage({
    required String id,
    required MessageSender sender,
    required MessageCategory category,
    required String senderName,
    required String subject,
    required String content,
    required int gameWeek, // 게임 내 주차 (라운드)
    required DateTime createdAt,
    @Default(false) bool isRead,
  }) = _InboxMessage;

  factory InboxMessage.fromJson(Map<String, dynamic> json) =>
      _$InboxMessageFromJson(json);
}

extension MessageSenderX on MessageSender {
  String get defaultName {
    switch (this) {
      case MessageSender.coach:
        return '김 감독';
      case MessageSender.agent:
        return '박 에이전트';
      case MessageSender.fan:
        return '팬클럽';
      case MessageSender.media:
        return '스포츠 뉴스';
      case MessageSender.system:
        return '시스템';
    }
  }
}
