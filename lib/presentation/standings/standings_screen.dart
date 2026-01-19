// 순위표 화면 - 팀/개인 탭

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../widgets/retro_theme.dart';

class StandingsScreen extends ConsumerStatefulWidget {
  const StandingsScreen({super.key});

  @override
  ConsumerState<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends ConsumerState<StandingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('순위표'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '팀 순위'),
            Tab(text: '개인 순위'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _TeamStandingsTab(),
          _IndividualStandingsTab(),
        ],
      ),
    );
  }
}

class _TeamStandingsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final standings = ref.watch(standingsProvider);
    final pcTeamId = ref.watch(playerCharacterProvider)?.profile.teamId;

    if (standings.isEmpty) {
      return const Center(child: Text('순위 정보가 없습니다.'));
    }

    // 순위 정렬
    final sorted = [...standings]..sort((a, b) {
        if (a.points != b.points) return b.points.compareTo(a.points);
        return b.goalDifference.compareTo(a.goalDifference);
      });

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sorted.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildTeamHeader();
        }
        final row = sorted[index - 1];
        final isPC = row.teamId == pcTeamId;
        return _buildTeamRow(index, row, isPC);
      },
    );
  }

  Widget _buildTeamHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: RetroColors.divider)),
      ),
      child: const Row(
        children: [
          SizedBox(width: 30, child: Text('#', style: TextStyle(color: RetroColors.textSecondary))),
          Expanded(child: Text('팀', style: TextStyle(color: RetroColors.textSecondary))),
          SizedBox(width: 35, child: Text('경기', style: TextStyle(color: RetroColors.textSecondary), textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text('승', style: TextStyle(color: RetroColors.textSecondary), textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text('무', style: TextStyle(color: RetroColors.textSecondary), textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text('패', style: TextStyle(color: RetroColors.textSecondary), textAlign: TextAlign.center)),
          SizedBox(width: 45, child: Text('득실', style: TextStyle(color: RetroColors.textSecondary), textAlign: TextAlign.center)),
          SizedBox(width: 40, child: Text('승점', style: TextStyle(color: RetroColors.textSecondary), textAlign: TextAlign.center)),
        ],
      ),
    );
  }

  Widget _buildTeamRow(int rank, StandingRow row, bool isPC) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
      decoration: BoxDecoration(
        color: isPC ? RetroColors.primary.withValues(alpha: 0.15) : null,
        border: const Border(bottom: BorderSide(color: RetroColors.divider)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              style: TextStyle(
                fontWeight: isPC ? FontWeight.bold : null,
                color: isPC ? RetroColors.primary : RetroColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: Text(
              row.teamName,
              style: TextStyle(
                fontWeight: isPC ? FontWeight.bold : null,
                color: isPC ? RetroColors.primary : RetroColors.textPrimary,
              ),
            ),
          ),
          SizedBox(width: 35, child: Text('${row.played}', textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text('${row.won}', textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text('${row.drawn}', textAlign: TextAlign.center)),
          SizedBox(width: 35, child: Text('${row.lost}', textAlign: TextAlign.center)),
          SizedBox(
            width: 45,
            child: Text(
              '${row.goalDifference >= 0 ? '+' : ''}${row.goalDifference}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: row.goalDifference > 0
                    ? RetroColors.success
                    : row.goalDifference < 0
                        ? RetroColors.error
                        : RetroColors.textSecondary,
              ),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              '${row.points}',
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class _IndividualStandingsTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<_IndividualStandingsTab> createState() => _IndividualStandingsTabState();
}

class _IndividualStandingsTabState extends ConsumerState<_IndividualStandingsTab> {
  int _selectedIndex = 0; // 0: 득점, 1: 도움, 2: 평점

  @override
  Widget build(BuildContext context) {
    final leagueStats = ref.watch(leagueStatsProvider);
    final pc = ref.watch(playerCharacterProvider);
    final season = ref.watch(seasonProvider);

    if (leagueStats == null || pc == null || season == null) {
      return const Center(child: Text('통계 정보가 없습니다.'));
    }

    // PC 정보를 리그 스탯에 포함
    final pcAsPlayer = VirtualPlayer(
      id: pc.profile.id,
      name: pc.profile.name,
      teamId: pc.profile.teamId,
      goals: pc.career.totalGoals,
      assists: pc.career.totalAssists,
      matchesPlayed: pc.career.matchesPlayed,
      ratings: pc.career.lastRatings,
    );

    // PC 포함한 전체 플레이어 목록
    final allPlayers = [
      pcAsPlayer,
      ...leagueStats.players.where((p) => p.id != pc.profile.id),
    ];

    List<VirtualPlayer> ranking;
    String title;
    String Function(VirtualPlayer) getValue;

    switch (_selectedIndex) {
      case 0:
        ranking = [...allPlayers]..sort((a, b) => b.goals.compareTo(a.goals));
        title = '🥇 득점 순위';
        // 득점
        getValue = (p) => '${p.goals}';
        break;
      case 1:
        ranking = [...allPlayers]..sort((a, b) => b.assists.compareTo(a.assists));
        title = '🅰️ 도움 순위';
        // 도움
        getValue = (p) => '${p.assists}';
        break;
      default:
        final qualified = allPlayers.where((p) => p.matchesPlayed >= 3).toList();
        ranking = [...qualified]..sort((a, b) => b.avgRating.compareTo(a.avgRating));
        title = '⭐ 평점 순위';
        // 평점
        getValue = (p) => p.avgRating.toStringAsFixed(2);
    }

    return Column(
      children: [
        // 카테고리 선택
        Padding(
          padding: const EdgeInsets.all(16),
          child: SegmentedButton<int>(
            segments: const [
              ButtonSegment(value: 0, label: Text('득점')),
              ButtonSegment(value: 1, label: Text('도움')),
              ButtonSegment(value: 2, label: Text('평점')),
            ],
            selected: {_selectedIndex},
            onSelectionChanged: (set) {
              setState(() => _selectedIndex = set.first);
            },
          ),
        ),

        // 헤더
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(title, style: Theme.of(context).textTheme.titleMedium),
        ),

        // 순위 목록
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: ranking.take(20).length,
            itemBuilder: (context, index) {
              final player = ranking[index];
              final isPC = player.id == pc.profile.id;
              final teamName = season.teams[player.teamId]?.name ?? '-';

              return Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  color: isPC ? RetroColors.primary.withValues(alpha: 0.15) : null,
                  border: const Border(bottom: BorderSide(color: RetroColors.divider)),
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 30,
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          fontWeight: isPC ? FontWeight.bold : null,
                          color: index < 3 ? RetroColors.warning : RetroColors.textPrimary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            player.name,
                            style: TextStyle(
                              fontWeight: isPC ? FontWeight.bold : null,
                              color: isPC ? RetroColors.primary : RetroColors.textPrimary,
                            ),
                          ),
                          Text(
                            teamName,
                            style: const TextStyle(
                              fontSize: 12,
                              color: RetroColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      getValue(player),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: isPC ? RetroColors.primary : RetroColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
