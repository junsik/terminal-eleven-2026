// 홈 화면 - 대시보드

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../../presentation/widgets/retro_theme.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pc = ref.watch(engineCharacterProvider);
    final nextOpponent = ref.watch(engineNextOpponentProvider);
    final season = ref.watch(engineSeasonProvider);
    final weeklyActions = ref.watch(engineWeeklyActionsProvider);
    final standings = ref.watch(engineStandingsProvider);
    final pcRank = ref.watch(enginePcRankProvider);

    if (pc == null || season == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('홈'),
        leading: PopupMenuButton<String>(
          icon: const Icon(Icons.menu),
          onSelected: (value) {
            if (value == 'lobby') {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('로비로 이동'),
                  content: const Text('현재 게임을 저장하고 로비로 이동합니다.'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('취소'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.go('/');
                      },
                      child: const Text('확인'),
                    ),
                  ],
                ),
              );
            } else if (value == 'help') {
              context.push('/help');
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'lobby',
              child: Row(
                children: [
                  Icon(Icons.home, size: 20),
                  SizedBox(width: 8),
                  Text('로비로 이동'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'help',
              child: Row(
                children: [
                  Icon(Icons.help_outline, size: 20),
                  SizedBox(width: 8),
                  Text('게임 도움말'),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.mail_outline),
            onPressed: () => context.push('/inbox'),
          ),
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () => context.push('/career'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 선수 정보 카드
            _buildPlayerCard(context, pc, season.getTeam(pc.profile.teamId)),
            const SizedBox(height: 16),

            // 다음 경기 카드
            _buildNextMatchCard(context, ref, nextOpponent, season.currentRound),
            const SizedBox(height: 16),

            // 상태 카드
            _buildStatusCard(context, pc, weeklyActions),
            const SizedBox(height: 16),

            // 순위표 미니
            _buildStandingsCard(context, standings, pc.profile.teamId, pcRank),
            const SizedBox(height: 24),

            // 액션 버튼들
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: weeklyActions > 0
                        ? () => context.push('/training')
                        : null,
                    icon: const Icon(Icons.fitness_center),
                    label: const Text('훈련'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: pc.status.injury == InjuryStatus.none
                        ? () {
                            ref.read(orchestratorProvider).startMatch();
                            context.go('/match');
                          }
                        : () {
                            ref.read(orchestratorProvider).spectateMatchComplete();
                            context.go('/summary');
                          },
                    icon: Icon(pc.status.injury == InjuryStatus.none
                        ? Icons.sports_soccer
                        : Icons.visibility),
                    label: Text(pc.status.injury == InjuryStatus.none
                        ? '다음 경기'
                        : '경기 결장'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerCard(BuildContext context, PlayerCharacter pc, [Team? team]) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/career'),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pc.profile.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        if (team != null)
                          Text(
                            team.name,
                            style: const TextStyle(
                              color: RetroColors.primary,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: RetroColors.primary),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'LV.${pc.career.level}',
                          style: const TextStyle(
                            color: RetroColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, size: 16),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${pc.profile.age}세 | ${_archetypeName(pc.profile.archetype)} | ST',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: RetroColors.textSecondary,
                    ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _statItem('골', '${pc.career.totalGoals}'),
                  _statItem('도움', '${pc.career.totalAssists}'),
                  _statItem('경기', '${pc.career.matchesPlayed}'),
                  _statItem('평점', pc.career.lastRatings.isEmpty
                      ? '-'
                      : pc.career.lastRatings.last.toStringAsFixed(1)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNextMatchCard(
    BuildContext context,
    WidgetRef ref,
    Team? opponent,
    int round,
  ) {
    return Card(
      child: InkWell(
        onTap: () => context.push('/fixtures'),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '다음 경기',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        'R$round',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, size: 16),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (opponent != null) ...[
                Text(
                  'vs ${opponent.name}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  '상대 레이팅: ${opponent.overallRating}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ] else
                const Text('시즌 종료'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard(
    BuildContext context,
    PlayerCharacter pc,
    int weeklyActions,
  ) {
    return Card(
      child: InkWell(
        onTap: weeklyActions > 0 ? () => context.push('/training') : null,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '상태',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  if (weeklyActions > 0)
                    const Icon(Icons.chevron_right, size: 16),
                ],
              ),
            const SizedBox(height: 12),
            _progressBar('피로', pc.status.fatigue, 100, isInverted: true),
            const SizedBox(height: 8),
            _progressBar('신뢰', pc.career.trust, 100),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '자신감: ${_confidenceText(pc.status.confidence)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  '주간 행동: $weeklyActions/3',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            // 피로 경고
            if (pc.status.fatigue > 60 && pc.status.injury == InjuryStatus.none) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (pc.status.fatigue > 80 ? RetroColors.error : RetroColors.warning).withAlpha(25),
                  border: Border.all(
                    color: pc.status.fatigue > 80 ? RetroColors.error : RetroColors.warning,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: pc.status.fatigue > 80 ? RetroColors.error : RetroColors.warning,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        pc.status.fatigue > 80
                            ? '과로 상태! 성공률 -${((pc.status.fatigue - 80) * 0.6 + 6).toStringAsFixed(0)}%, 부상위험 2배'
                            : '피로 누적 중. 성공률 -${((pc.status.fatigue - 60) * 0.3).toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: pc.status.fatigue > 80 ? RetroColors.error : RetroColors.warning,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
            if (pc.status.injury != InjuryStatus.none) ...[
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: RetroColors.error.withAlpha(25),
                  border: Border.all(color: RetroColors.error),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.healing, color: RetroColors.error, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      '부상: ${pc.status.injuryWeeksRemaining}주 남음',
                      style: const TextStyle(color: RetroColors.error),
                    ),
                  ],
                ),
              ),
            ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStandingsCard(
    BuildContext context,
    List<StandingRow> standings,
    String pcTeamId,
    int pcRank,
  ) {
    // 상위 5팀만 표시
    final displayStandings = standings.take(5).toList();

    return Card(
      child: InkWell(
        onTap: () => context.push('/standings'),
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '순위표',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Row(
                    children: [
                      Text(
                        '내 순위: $pcRank위',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.chevron_right, size: 16),
                    ],
                  ),
                ],
              ),
            const SizedBox(height: 12),
            // 헤더
            Row(
              children: const [
                SizedBox(width: 24, child: Text('#', style: TextStyle(fontSize: 12))),
                Expanded(child: Text('팀', style: TextStyle(fontSize: 12))),
                SizedBox(width: 32, child: Text('경기', style: TextStyle(fontSize: 12))),
                SizedBox(width: 32, child: Text('승점', style: TextStyle(fontSize: 12))),
              ],
            ),
            const Divider(),
            ...displayStandings.asMap().entries.map((entry) {
              final rank = entry.key + 1;
              final row = entry.value;
              final isPC = row.teamId == pcTeamId;

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 4),
                color: isPC ? RetroColors.primary.withAlpha(25) : null,
                child: Row(
                  children: [
                    SizedBox(
                      width: 24,
                      child: Text(
                        '$rank',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isPC ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        row.teamName,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isPC ? FontWeight.bold : null,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      width: 32,
                      child: Text('${row.played}', style: const TextStyle(fontSize: 12)),
                    ),
                    SizedBox(
                      width: 32,
                      child: Text(
                        '${row.points}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: isPC ? FontWeight.bold : null,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: RetroColors.primary,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: RetroColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _progressBar(String label, int value, int max, {bool isInverted = false}) {
    final ratio = value / max;
    final color = isInverted
        ? (ratio > 0.7 ? RetroColors.error : (ratio > 0.4 ? RetroColors.warning : RetroColors.success))
        : (ratio > 0.7 ? RetroColors.success : (ratio > 0.4 ? RetroColors.warning : RetroColors.error));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(fontSize: 12)),
            Text('$value', style: const TextStyle(fontSize: 12)),
          ],
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: ratio,
          backgroundColor: RetroColors.divider,
          valueColor: AlwaysStoppedAnimation(color),
        ),
      ],
    );
  }

  String _confidenceText(int confidence) {
    if (confidence >= 2) return '최고! ⬆️';
    if (confidence == 1) return '좋음 🔼';
    if (confidence == 0) return '보통';
    if (confidence == -1) return '낮음 🔽';
    return '최저 ⬇️';
  }

  String _archetypeName(PlayerArchetype archetype) {
    return archetype.label;
  }
}
