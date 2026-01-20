// 경기 요약 화면

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../../presentation/widgets/retro_theme.dart';

class SummaryScreen extends ConsumerWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final match = ref.watch(engineActiveMatchProvider);
    final pc = ref.watch(engineCharacterProvider);
    final season = ref.watch(engineSeasonProvider);

    if (match == null || pc == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final homeTeam = season?.getTeam(match.homeTeamId);
    final awayTeam = season?.getTeam(match.awayTeamId);
    final rating = match.ratingAccumulator.finalRating;
    final didPlay = match.highlights.isNotEmpty; // 결장 여부 체크

    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('경기 결과'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 최종 스코어
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Text(
                      '경기 종료',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: RetroColors.textSecondary,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                homeTeam?.name ?? 'HOME',
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${match.score.home}',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: match.isHome ? RetroColors.primary : RetroColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            '-',
                            style: TextStyle(
                              fontSize: 32,
                              color: RetroColors.textSecondary,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                awayTeam?.name ?? 'AWAY',
                                style: const TextStyle(fontSize: 14),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${match.score.away}',
                                style: TextStyle(
                                  fontSize: 48,
                                  fontWeight: FontWeight.bold,
                                  color: !match.isHome ? RetroColors.primary : RetroColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 결장 시 메시지
            if (!didPlay) ...[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Icon(
                        Icons.healing,
                        size: 48,
                        color: RetroColors.warning,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        '경기 결장',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '부상으로 인해 벤치에서 경기를 관전했습니다.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: RetroColors.textSecondary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            // 출전 시에만 평점/스탯 표시
            if (didPlay) ...[
              // 평점
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Text(
                        '경기 평점',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        rating.toStringAsFixed(1),
                        style: TextStyle(
                          fontSize: 64,
                          fontWeight: FontWeight.bold,
                          color: _getRatingColor(rating),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getRatingText(rating),
                        style: TextStyle(
                          color: _getRatingColor(rating),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 경기 스탯
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '경기 활약',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _statItem('골', match.ratingAccumulator.goals),
                          _statItem('어시스트', match.ratingAccumulator.assists),
                          _statItem('유효슈팅', match.ratingAccumulator.shotsOnTarget),
                          _statItem('키패스', match.ratingAccumulator.keyPasses),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // 성장
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '커리어 성장',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 16),
                      _growthItem('XP 획득', '+${(rating * 10).toInt()}'),
                      _growthItem(
                        '신뢰도',
                        '${((rating - 6.0) * 4).toInt() >= 0 ? '+' : ''}${((rating - 6.0) * 4).toInt()}',
                      ),
                      _growthItem('레벨', 'Lv.${pc.career.level}'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],

            ElevatedButton(
              onPressed: () {
                ref.read(orchestratorProvider).returnToHome();
                context.go('/home');
              },
              child: const Text('홈으로'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statItem(String label, int value) {
    return Column(
      children: [
        Text(
          '$value',
          style: const TextStyle(
            fontSize: 24,
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

  Widget _growthItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: RetroColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 8.0) return RetroColors.success;
    if (rating >= 7.0) return RetroColors.primary;
    if (rating >= 6.0) return RetroColors.textPrimary;
    if (rating >= 5.0) return RetroColors.warning;
    return RetroColors.error;
  }

  String _getRatingText(double rating) {
    if (rating >= 9.0) return '환상적인 경기!';
    if (rating >= 8.0) return '맨 오브 더 매치급!';
    if (rating >= 7.0) return '좋은 활약!';
    if (rating >= 6.0) return '무난한 경기';
    if (rating >= 5.0) return '조금 아쉬운 경기';
    return '부진한 경기...';
  }
}
