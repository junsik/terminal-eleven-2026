// 리그 일정 화면

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../widgets/retro_theme.dart';

class FixturesScreen extends ConsumerStatefulWidget {
  const FixturesScreen({super.key});

  @override
  ConsumerState<FixturesScreen> createState() => _FixturesScreenState();
}

class _FixturesScreenState extends ConsumerState<FixturesScreen> {
  bool _showOnlyMyTeam = false;

  @override
  Widget build(BuildContext context) {
    final season = ref.watch(engineSeasonProvider);
    final pcTeamId = ref.watch(engineCharacterProvider)?.profile.teamId;

    if (season == null || pcTeamId == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // 라운드별로 그룹핑
    final fixturesByRound = <int, List<Fixture>>{};
    for (final fixture in season.fixtures) {
      if (_showOnlyMyTeam &&
          fixture.homeTeamId != pcTeamId &&
          fixture.awayTeamId != pcTeamId) {
        continue;
      }
      fixturesByRound.putIfAbsent(fixture.round, () => []).add(fixture);
    }

    final rounds = fixturesByRound.keys.toList()..sort();

    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('리그 일정'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _showOnlyMyTeam ? Icons.filter_alt : Icons.filter_alt_outlined,
              color: _showOnlyMyTeam ? RetroColors.primary : null,
            ),
            onPressed: () {
              setState(() => _showOnlyMyTeam = !_showOnlyMyTeam);
            },
            tooltip: '내 팀 경기만',
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: rounds.length,
        itemBuilder: (context, index) {
          final round = rounds[index];
          final fixtures = fixturesByRound[round]!;
          final isCurrentRound = round == season.currentRound;

          return _RoundSection(
            round: round,
            fixtures: fixtures,
            teams: season.teams,
            pcTeamId: pcTeamId,
            isCurrentRound: isCurrentRound,
          );
        },
      ),
    );
  }
}

class _RoundSection extends StatelessWidget {
  final int round;
  final List<Fixture> fixtures;
  final Map<String, Team> teams;
  final String pcTeamId;
  final bool isCurrentRound;

  const _RoundSection({
    required this.round,
    required this.fixtures,
    required this.teams,
    required this.pcTeamId,
    required this.isCurrentRound,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 라운드 헤더
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: isCurrentRound
                ? RetroColors.primary.withAlpha(25)
                : RetroColors.surface,
            border: Border.all(
              color: isCurrentRound ? RetroColors.primary : RetroColors.divider,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              Text(
                'R$round',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isCurrentRound
                      ? RetroColors.primary
                      : RetroColors.textPrimary,
                ),
              ),
              if (isCurrentRound) ...[
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: RetroColors.primary,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: const Text(
                    '현재',
                    style: TextStyle(
                      fontSize: 10,
                      color: RetroColors.background,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 8),

        // 경기 목록
        ...fixtures.map((fixture) => _FixtureRow(
              fixture: fixture,
              teams: teams,
              pcTeamId: pcTeamId,
            )),
        const SizedBox(height: 16),
      ],
    );
  }
}

class _FixtureRow extends StatelessWidget {
  final Fixture fixture;
  final Map<String, Team> teams;
  final String pcTeamId;

  const _FixtureRow({
    required this.fixture,
    required this.teams,
    required this.pcTeamId,
  });

  @override
  Widget build(BuildContext context) {
    final homeTeam = teams[fixture.homeTeamId];
    final awayTeam = teams[fixture.awayTeamId];
    final isMyMatch =
        fixture.homeTeamId == pcTeamId || fixture.awayTeamId == pcTeamId;
    final isPlayed = fixture.isPlayed;

    // 내 팀 승/무/패 결과
    String? myResult;
    if (isMyMatch && isPlayed) {
      final myScore = fixture.homeTeamId == pcTeamId
          ? fixture.homeScore
          : fixture.awayScore;
      final opponentScore = fixture.homeTeamId == pcTeamId
          ? fixture.awayScore
          : fixture.homeScore;
      if (myScore! > opponentScore!) {
        myResult = 'W';
      } else if (myScore < opponentScore) {
        myResult = 'L';
      } else {
        myResult = 'D';
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: isMyMatch ? RetroColors.primary.withAlpha(15) : null,
        border: Border.all(
          color: isMyMatch ? RetroColors.primary.withAlpha(50) : RetroColors.divider,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        children: [
          // 홈팀
          Expanded(
            flex: 3,
            child: Text(
              homeTeam?.name ?? '-',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight:
                    fixture.homeTeamId == pcTeamId ? FontWeight.bold : null,
                color: fixture.homeTeamId == pcTeamId
                    ? RetroColors.primary
                    : RetroColors.textPrimary,
              ),
            ),
          ),

          // 스코어 또는 VS
          SizedBox(
            width: 70,
            child: isPlayed
                ? Text(
                    '${fixture.homeScore} - ${fixture.awayScore}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  )
                : const Text(
                    'vs',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: RetroColors.textSecondary,
                    ),
                  ),
          ),

          // 어웨이팀
          Expanded(
            flex: 3,
            child: Text(
              awayTeam?.name ?? '-',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontWeight:
                    fixture.awayTeamId == pcTeamId ? FontWeight.bold : null,
                color: fixture.awayTeamId == pcTeamId
                    ? RetroColors.primary
                    : RetroColors.textPrimary,
              ),
            ),
          ),

          // 내 팀 결과 배지
          if (myResult != null)
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: myResult == 'W'
                    ? RetroColors.success
                    : myResult == 'L'
                        ? RetroColors.error
                        : RetroColors.warning,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Center(
                child: Text(
                  myResult,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          else
            const SizedBox(width: 24),
        ],
      ),
    );
  }
}
