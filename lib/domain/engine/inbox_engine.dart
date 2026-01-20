/// 인박스 엔진
///
/// 메시지 추가, 읽음 처리, 삭제 등 인박스 관련 로직
/// 순수 함수로 구현

import 'base_engine.dart';
import '../state/game_state.dart';
import '../action/game_action.dart';
import '../model/inbox.dart';

/// 인박스 엔진
class InboxEngine extends GameEngine<InboxAction> {
  @override
  bool canHandle(GameAction action) => action is InboxAction;

  @override
  GameState process(GameState state, InboxAction action, int seed) {
    return switch (action) {
      AddInboxMessage() => _addMessage(state, action, seed),
      MarkMessageAsRead() => _markAsRead(state, action),
      MarkAllMessagesAsRead() => _markAllAsRead(state),
      DeleteInboxMessage() => _deleteMessage(state, action),
    };
  }

  /// 메시지 추가
  GameState _addMessage(GameState state, AddInboxMessage action, int seed) {
    final sender = MessageSender.values.firstWhere(
      (s) => s.name == action.senderType,
      orElse: () => MessageSender.system,
    );

    final category = MessageCategory.values.firstWhere(
      (c) => c.name == action.category,
      orElse: () => MessageCategory.general,
    );

    final message = InboxMessage(
      id: '${DateTime.now().millisecondsSinceEpoch}_$seed',
      sender: sender,
      category: category,
      senderName: action.customSenderName ?? sender.defaultName,
      subject: action.subject,
      content: action.content,
      gameWeek: state.season.currentRound,
      createdAt: DateTime.now(),
      isRead: false,
    );

    final newMessages = [...state.inbox.messages, message];

    return state.copyWith(
      inbox: state.inbox.copyWith(messages: newMessages),
    );
  }

  /// 메시지 읽음 처리
  GameState _markAsRead(GameState state, MarkMessageAsRead action) {
    final newMessages = state.inbox.messages.map((m) {
      if (m.id == action.messageId) {
        return m.copyWith(isRead: true);
      }
      return m;
    }).toList();

    return state.copyWith(
      inbox: state.inbox.copyWith(messages: newMessages),
    );
  }

  /// 모든 메시지 읽음 처리
  GameState _markAllAsRead(GameState state) {
    final newMessages = state.inbox.messages.map((m) {
      return m.copyWith(isRead: true);
    }).toList();

    return state.copyWith(
      inbox: state.inbox.copyWith(messages: newMessages),
    );
  }

  /// 메시지 삭제
  GameState _deleteMessage(GameState state, DeleteInboxMessage action) {
    final newMessages = state.inbox.messages
        .where((m) => m.id != action.messageId)
        .toList();

    return state.copyWith(
      inbox: state.inbox.copyWith(messages: newMessages),
    );
  }
}
