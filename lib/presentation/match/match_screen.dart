// 경기 화면 - 하이라이트 플레이

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../../presentation/widgets/retro_theme.dart';

class MatchScreen extends ConsumerStatefulWidget {
  const MatchScreen({super.key});

  @override
  ConsumerState<MatchScreen> createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final match = ref.watch(engineActiveMatchProvider);

    if (match == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
      return const SizedBox();
    }

    _scrollToBottom();

    return Scaffold(
      backgroundColor: RetroColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 스코어 헤더
            _buildScoreHeader(context, match),

            // 경기 로그
            Expanded(
              child: _buildMatchLog(context, match),
            ),

            // 하단 컨트롤
            _buildBottomControls(context, ref, match),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreHeader(BuildContext context, MatchSession match) {
    final season = ref.watch(engineSeasonProvider);
    final homeTeam = season?.getTeam(match.homeTeamId);
    final awayTeam = season?.getTeam(match.awayTeamId);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: RetroColors.divider),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  homeTeam?.name ?? 'HOME',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: match.isHome ? FontWeight.bold : null,
                    color: match.isHome ? RetroColors.primary : RetroColors.textSecondary,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: RetroColors.primary),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${match.score.home} - ${match.score.away}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: RetroColors.primary,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  awayTeam?.name ?? 'AWAY',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: !match.isHome ? FontWeight.bold : null,
                    color: !match.isHome ? RetroColors.primary : RetroColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${match.minute}'",
                style: const TextStyle(color: RetroColors.textSecondary),
              ),
              const SizedBox(width: 16),
              Text(
                '하이라이트 ${match.currentHighlightIndex + 1}/${match.highlights.length}',
                style: const TextStyle(
                  fontSize: 12,
                  color: RetroColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMatchLog(BuildContext context, MatchSession match) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: match.log.length,
      itemBuilder: (context, index) {
        final log = match.log[index];
        return _LogItem(log: log);
      },
    );
  }

  Widget _buildBottomControls(BuildContext context, WidgetRef ref, MatchSession match) {
    switch (match.phase) {
      case MatchPhase.intro:
        return _ActionButton(
          text: '경기 시작',
          onPressed: () {
            ref.read(orchestratorProvider).proceedFromIntro();
          },
        );

      case MatchPhase.highlightPresent:
        final highlight = match.currentHighlight;
        if (highlight == null) return const SizedBox();

        return _HighlightChoices(
          highlight: highlight,
          onChoice: (command) {
            ref.read(orchestratorProvider).processHighlightChoice(command);
          },
        );

      case MatchPhase.highlightResult:
        return _ActionButton(
          text: '계속',
          onPressed: () {
            ref.read(orchestratorProvider).proceedToNextHighlight();
          },
        );

      case MatchPhase.fullTime:
        return _ActionButton(
          text: '경기 결과 보기',
          onPressed: () {
            ref.read(orchestratorProvider).finishMatch();
            context.go('/summary');
          },
        );

      default:
        return const SizedBox();
    }
  }
}

class _LogItem extends StatelessWidget {
  final LogLine log;

  const _LogItem({required this.log});

  @override
  Widget build(BuildContext context) {
    Color textColor;
    switch (log.type) {
      case LogType.system:
        textColor = RetroColors.warning;
        break;
      case LogType.result:
        textColor = RetroColors.success;
        break;
      case LogType.commentary:
        textColor = RetroColors.textPrimary;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (log.minute != null)
            SizedBox(
              width: 40,
              child: Text(
                "${log.minute}'",
                style: const TextStyle(
                  color: RetroColors.textSecondary,
                  fontSize: 12,
                ),
              ),
            ),
          Expanded(
            child: Text(
              log.text,
              style: TextStyle(color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(48),
        ),
        child: Text(text),
      ),
    );
  }
}

class _HighlightChoices extends StatelessWidget {
  final HighlightEvent highlight;
  final void Function(CommandType) onChoice;

  const _HighlightChoices({
    required this.highlight,
    required this.onChoice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: RetroColors.divider),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            _getEventDescription(highlight.type),
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: highlight.choices.map((choice) {
              final command = commandTypeFromString(choice);
              if (command == null) return const SizedBox();

              return OutlinedButton(
                onPressed: () => onChoice(command),
                child: Text(command.displayName),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  String _getEventDescription(HighlightType type) {
    switch (type) {
      case HighlightType.runInBehind:
        return '🏃 수비 라인 뒤 공간이 보인다!';
      case HighlightType.receiveAndTurn:
        return '🔄 등지고 공을 받았다!';
      case HighlightType.oneOnOne:
        return '⚽ 키퍼와 1대1 상황!';
      case HighlightType.edgeOfBoxShot:
        return '🎯 박스 앞에서 슈팅 찬스!';
      case HighlightType.quickCounter:
        return '💨 빠른 역습 기회!';
      case HighlightType.pressing:
        return '💪 전방에서 압박 상황!';
      case HighlightType.defensiveCover:
        return '🛡️ 수비 커버가 필요하다!';
      case HighlightType.looseBall:
        return '⚔️ 세컨볼 경합!';
      case HighlightType.setPieceRebound:
        return '🎯 세트피스 후 리바운드!';
      case HighlightType.fatigueMoment:
        return '😓 숨이 차오른다...';
      case HighlightType.mentalPressure:
        return '😰 멘탈 압박이 온다!';
      case HighlightType.coachFeedback:
        return '📋 감독이 지시를 내린다.';
      case HighlightType.penaltyKick:
        return '🥅 페널티킥!!! 골대 앞에 섰다!';
      case HighlightType.clutchChance:
        return '🔥 마지막 기회! 모든 것을 걸어라!';
    }
  }
}
