/// 인박스 화면 - 코치/에이전트/팬/미디어 메시지

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/inbox.dart';
import '../../presentation/widgets/retro_theme.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(engineStateProvider);

    if (gameState == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final messages = gameState.inbox.sortedMessages;
    final unreadCount = gameState.inbox.unreadCount;

    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('인박스'),
            if (unreadCount > 0) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: RetroColors.error,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$unreadCount',
                  style: const TextStyle(
                    fontSize: 11,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: () {
                ref.read(orchestratorProvider).markAllMessagesAsRead();
              },
              child: const Text(
                '모두 읽음',
                style: TextStyle(fontSize: 12),
              ),
            ),
        ],
      ),
      body: messages.isEmpty
          ? _buildEmptyState(context)
          : _buildMessageList(context, ref, messages),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              border: Border.all(color: RetroColors.textSecondary),
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Icon(
              Icons.inbox_outlined,
              size: 48,
              color: RetroColors.textSecondary,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '새 메시지가 없습니다',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: RetroColors.textSecondary,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            '경기를 치르거나 훈련을 하면\n메시지가 도착합니다',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: RetroColors.textSecondary,
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(
    BuildContext context,
    WidgetRef ref,
    List<InboxMessage> messages,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final message = messages[index];
        return _MessageCard(
          message: message,
          onTap: () => _showMessageDetail(context, ref, message),
          onDelete: () => _deleteMessage(context, ref, message),
        );
      },
    );
  }

  void _showMessageDetail(
    BuildContext context,
    WidgetRef ref,
    InboxMessage message,
  ) {
    // 읽음 처리
    if (!message.isRead) {
      ref.read(orchestratorProvider).markMessageAsRead(message.id);
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: RetroColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(8)),
        side: BorderSide(color: RetroColors.border),
      ),
      builder: (context) => _MessageDetailSheet(message: message),
    );
  }

  void _deleteMessage(
    BuildContext context,
    WidgetRef ref,
    InboxMessage message,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: RetroColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: RetroColors.border),
        ),
        title: const Text(
          '메시지 삭제',
          style: TextStyle(color: RetroColors.primary),
        ),
        content: const Text(
          '이 메시지를 삭제하시겠습니까?',
          style: TextStyle(color: RetroColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('취소'),
          ),
          TextButton(
            onPressed: () {
              ref.read(orchestratorProvider).deleteMessage(message.id);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: RetroColors.error),
            child: const Text('삭제'),
          ),
        ],
      ),
    );
  }
}

class _MessageCard extends StatelessWidget {
  final InboxMessage message;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _MessageCard({
    required this.message,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isUnread = !message.isRead;

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(4),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUnread ? RetroColors.surface : RetroColors.background,
            border: Border.all(
              color: isUnread ? RetroColors.primary : RetroColors.divider,
              width: isUnread ? 1 : 0.5,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 발신자 아이콘
              _SenderIcon(sender: message.sender, isUnread: isUnread),
              const SizedBox(width: 12),
              // 메시지 내용
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            message.senderName,
                            style: TextStyle(
                              fontSize: 12,
                              color: _getSenderColor(message.sender),
                              fontWeight:
                                  isUnread ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                        Text(
                          _formatGameWeek(message.gameWeek),
                          style: const TextStyle(
                            fontSize: 10,
                            color: RetroColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message.subject,
                      style: TextStyle(
                        fontSize: 14,
                        color: RetroColors.textPrimary,
                        fontWeight:
                            isUnread ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      message.content,
                      style: const TextStyle(
                        fontSize: 12,
                        color: RetroColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              // 삭제 버튼
              IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 16,
                  color: RetroColors.textSecondary,
                ),
                onPressed: onDelete,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(
                  minWidth: 24,
                  minHeight: 24,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getSenderColor(MessageSender sender) {
    return switch (sender) {
      MessageSender.coach => RetroColors.primary,
      MessageSender.agent => RetroColors.warning,
      MessageSender.fan => Colors.pinkAccent,
      MessageSender.media => Colors.lightBlueAccent,
      MessageSender.system => RetroColors.textSecondary,
    };
  }

  String _formatGameWeek(int week) {
    return 'R$week';
  }
}

class _SenderIcon extends StatelessWidget {
  final MessageSender sender;
  final bool isUnread;

  const _SenderIcon({required this.sender, required this.isUnread});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(
        color: RetroColors.background,
        border: Border.all(
          color: _getColor(),
          width: isUnread ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Icon(
        _getIcon(),
        color: _getColor(),
        size: 18,
      ),
    );
  }

  IconData _getIcon() {
    return switch (sender) {
      MessageSender.coach => Icons.sports,
      MessageSender.agent => Icons.business_center,
      MessageSender.fan => Icons.favorite,
      MessageSender.media => Icons.newspaper,
      MessageSender.system => Icons.info_outline,
    };
  }

  Color _getColor() {
    return switch (sender) {
      MessageSender.coach => RetroColors.primary,
      MessageSender.agent => RetroColors.warning,
      MessageSender.fan => Colors.pinkAccent,
      MessageSender.media => Colors.lightBlueAccent,
      MessageSender.system => RetroColors.textSecondary,
    };
  }
}

class _MessageDetailSheet extends StatelessWidget {
  final InboxMessage message;

  const _MessageDetailSheet({required this.message});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      expand: false,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 핸들
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: RetroColors.textSecondary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // 발신자 정보
              Row(
                children: [
                  _SenderIcon(sender: message.sender, isUnread: false),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.senderName,
                          style: TextStyle(
                            fontSize: 14,
                            color: _getSenderColor(message.sender),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _formatCategory(message.category),
                          style: const TextStyle(
                            fontSize: 11,
                            color: RetroColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'R${message.gameWeek}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: RetroColors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(color: RetroColors.divider),
              const SizedBox(height: 16),
              // 제목
              Text(
                message.subject,
                style: const TextStyle(
                  fontSize: 18,
                  color: RetroColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // 본문
              Text(
                message.content,
                style: const TextStyle(
                  fontSize: 14,
                  color: RetroColors.textPrimary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        );
      },
    );
  }

  Color _getSenderColor(MessageSender sender) {
    return switch (sender) {
      MessageSender.coach => RetroColors.primary,
      MessageSender.agent => RetroColors.warning,
      MessageSender.fan => Colors.pinkAccent,
      MessageSender.media => Colors.lightBlueAccent,
      MessageSender.system => RetroColors.textSecondary,
    };
  }

  String _formatCategory(MessageCategory category) {
    return switch (category) {
      MessageCategory.welcome => '환영 메시지',
      MessageCategory.training => '훈련',
      MessageCategory.matchResult => '경기 결과',
      MessageCategory.levelUp => '레벨업',
      MessageCategory.injury => '부상',
      MessageCategory.trust => '신뢰도',
      MessageCategory.milestone => '기록 달성',
      MessageCategory.form => '컨디션',
      MessageCategory.general => '일반',
    };
  }
}
