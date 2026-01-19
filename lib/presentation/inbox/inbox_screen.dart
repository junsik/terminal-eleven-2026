// 인박스 화면 - 코치/에이전트/팬 메시지

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../../presentation/widgets/retro_theme.dart';

/// 메시지 타입
enum MessageType {
  coach,
  agent,
  fan,
  system,
}

/// 인박스 메시지
class InboxMessage {
  final String id;
  final MessageType type;
  final String sender;
  final String subject;
  final String content;
  final DateTime timestamp;
  final bool isRead;

  const InboxMessage({
    required this.id,
    required this.type,
    required this.sender,
    required this.subject,
    required this.content,
    required this.timestamp,
    this.isRead = false,
  });
}

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pc = ref.watch(playerCharacterProvider);

    if (pc == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 예시 메시지 생성
    final messages = _generateMessages(pc);

    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('인박스'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: messages.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.inbox_outlined,
                    size: 64,
                    color: RetroColors.textSecondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '새 메시지가 없습니다',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: RetroColors.textSecondary,
                        ),
                  ),
                ],
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: messages.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final message = messages[index];
                return _MessageTile(message: message);
              },
            ),
    );
  }

  List<InboxMessage> _generateMessages(PlayerCharacter pc) {
    final messages = <InboxMessage>[];
    final now = DateTime.now();

    // 신뢰도에 따른 코치 메시지
    if (pc.career.trust < 40) {
      messages.add(InboxMessage(
        id: '1',
        type: MessageType.coach,
        sender: '김 감독',
        subject: '훈련 태도에 대해',
        content: '경기력이 기대에 미치지 못하고 있어. 훈련에 더 집중해 주길 바란다.',
        timestamp: now.subtract(const Duration(hours: 2)),
      ));
    } else if (pc.career.trust > 70) {
      messages.add(InboxMessage(
        id: '2',
        type: MessageType.coach,
        sender: '김 감독',
        subject: '좋은 활약!',
        content: '최근 경기력이 매우 좋아. 이대로만 해주면 더 많은 기회를 주겠다.',
        timestamp: now.subtract(const Duration(hours: 5)),
      ));
    }

    // 레벨업 축하 메시지
    if (pc.career.level > 1) {
      messages.add(InboxMessage(
        id: '3',
        type: MessageType.agent,
        sender: '박 에이전트',
        subject: '성장에 대해',
        content: '레벨 ${pc.career.level}까지 올라왔군요! 계속 이렇게 성장하면 좋은 제안이 올 수도 있습니다.',
        timestamp: now.subtract(const Duration(days: 1)),
      ));
    }

    // 부상 위로 메시지
    if (pc.status.injury != InjuryStatus.none) {
      messages.add(InboxMessage(
        id: '4',
        type: MessageType.fan,
        sender: '팬클럽',
        subject: '빠른 쾌유를 빕니다',
        content: '부상 소식을 듣고 걱정이 많습니다. 빨리 나아서 그라운드에서 다시 뛰어주세요! 응원합니다!',
        timestamp: now.subtract(const Duration(hours: 12)),
      ));
    }

    // 기본 시스템 메시지
    messages.add(InboxMessage(
      id: '5',
      type: MessageType.system,
      sender: '시스템',
      subject: 'MUD 축구에 오신 것을 환영합니다!',
      content: '무명 유망주에서 시작해 스타 선수로 성장하는 여정을 시작하세요. 훈련하고, 경기에 출전하고, 당신의 커리어를 만들어가세요!',
      timestamp: now.subtract(const Duration(days: 7)),
    ));

    // 시간순 정렬
    messages.sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return messages;
  }
}

class _MessageTile extends StatelessWidget {
  final InboxMessage message;

  const _MessageTile({required this.message});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showMessageDialog(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                border: Border.all(color: _getTypeColor()),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Icon(
                _getTypeIcon(),
                color: _getTypeColor(),
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        message.sender,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: RetroColors.primary,
                        ),
                      ),
                      Text(
                        _formatTime(message.timestamp),
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
                    style: const TextStyle(color: RetroColors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    message.content,
                    style: const TextStyle(
                      fontSize: 12,
                      color: RetroColors.textSecondary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: RetroColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: RetroColors.border),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(_getTypeIcon(), color: _getTypeColor(), size: 20),
                const SizedBox(width: 8),
                Text(
                  message.sender,
                  style: TextStyle(
                    color: _getTypeColor(),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              message.subject,
              style: const TextStyle(
                color: RetroColors.primary,
                fontSize: 16,
              ),
            ),
          ],
        ),
        content: Text(
          message.content,
          style: const TextStyle(color: RetroColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }

  IconData _getTypeIcon() {
    switch (message.type) {
      case MessageType.coach:
        return Icons.sports;
      case MessageType.agent:
        return Icons.business;
      case MessageType.fan:
        return Icons.favorite;
      case MessageType.system:
        return Icons.info;
    }
  }

  Color _getTypeColor() {
    switch (message.type) {
      case MessageType.coach:
        return RetroColors.primary;
      case MessageType.agent:
        return RetroColors.warning;
      case MessageType.fan:
        return RetroColors.error;
      case MessageType.system:
        return RetroColors.textSecondary;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}분 전';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}시간 전';
    } else {
      return '${diff.inDays}일 전';
    }
  }
}
