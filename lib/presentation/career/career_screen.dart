// 커리어 화면 - 선수 스탯 상세

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../../presentation/widgets/retro_theme.dart';

class CareerScreen extends ConsumerWidget {
  const CareerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pc = ref.watch(playerCharacterProvider);

    if (pc == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('커리어'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 프로필 카드
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(color: RetroColors.primary, width: 2),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: const Icon(
                        Icons.person,
                        size: 48,
                        color: RetroColors.primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      pc.profile.name,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${pc.profile.age}세 | ${_archetypeName(pc.profile.archetype)} | 스트라이커',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _careerStat('레벨', '${pc.career.level}'),
                        _careerStat('경기', '${pc.career.matchesPlayed}'),
                        _careerStat('골', '${pc.career.totalGoals}'),
                        _careerStat('어시', '${pc.career.totalAssists}'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // XP 진행률
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'LV.${pc.career.level}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'LV.${pc.career.level + 1}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: pc.career.xp / (pc.career.level * 100),
                      backgroundColor: RetroColors.divider,
                      valueColor: const AlwaysStoppedAnimation(RetroColors.primary),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'XP: ${pc.career.xp} / ${pc.career.level * 100}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 능력치
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '능력치',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    _statBar('속도', pc.stats.pace),
                    _statBar('슈팅', pc.stats.shooting),
                    _statBar('패스', pc.stats.passing),
                    _statBar('볼컨트롤', pc.stats.ballControl),
                    _statBar('위치선정', pc.stats.positioning),
                    _statBar('체력', pc.stats.stamina),
                    _statBar('침착성', pc.stats.composure),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 상태
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '현재 상태',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    _statusRow('피로도', '${pc.status.fatigue}/100'),
                    _statusRow('자신감', _confidenceText(pc.status.confidence)),
                    _statusRow('폼', _formText(pc.status.form)),
                    _statusRow('신뢰도', '${pc.career.trust}/100'),
                    _statusRow('평판', '${pc.career.reputation}/100'),
                    if (pc.status.injury != InjuryStatus.none)
                      _statusRow(
                        '부상',
                        '${_injuryText(pc.status.injury)} (${pc.status.injuryWeeksRemaining}주)',
                        isWarning: true,
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 최근 평점
            if (pc.career.lastRatings.isNotEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '최근 경기 평점',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: pc.career.lastRatings
                            .take(5)
                            .map((r) => _ratingBadge(r))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _careerStat(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
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

  Widget _statBar(String label, int value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          SizedBox(
            width: 80,
            child: Text(
              label,
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: RetroColors.divider,
              valueColor: AlwaysStoppedAnimation(_getStatColor(value)),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 32,
            child: Text(
              '$value',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: _getStatColor(value),
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusRow(String label, String value, {bool isWarning = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(color: RetroColors.textSecondary),
          ),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isWarning ? RetroColors.error : RetroColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _ratingBadge(double rating) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        border: Border.all(color: _getRatingColor(rating)),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Center(
        child: Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _getRatingColor(rating),
          ),
        ),
      ),
    );
  }

  Color _getStatColor(int value) {
    if (value >= 80) return RetroColors.success;
    if (value >= 60) return RetroColors.primary;
    if (value >= 40) return RetroColors.warning;
    return RetroColors.error;
  }

  Color _getRatingColor(double rating) {
    if (rating >= 8.0) return RetroColors.success;
    if (rating >= 7.0) return RetroColors.primary;
    if (rating >= 6.0) return RetroColors.textPrimary;
    return RetroColors.error;
  }

  String _archetypeName(PlayerArchetype archetype) {
    switch (archetype) {
      case PlayerArchetype.poacher:
        return '포처';
      case PlayerArchetype.speedster:
        return '스피드스터';
      case PlayerArchetype.pressingForward:
        return '프레싱 FW';
      case PlayerArchetype.targetMan:
        return '타겟맨';
    }
  }

  String _confidenceText(int confidence) {
    if (confidence >= 2) return '최고';
    if (confidence == 1) return '좋음';
    if (confidence == 0) return '보통';
    if (confidence == -1) return '낮음';
    return '최저';
  }

  String _formText(FormTrend form) {
    switch (form) {
      case FormTrend.excellent:
        return '최상';
      case FormTrend.good:
        return '양호';
      case FormTrend.average:
        return '보통';
      case FormTrend.poor:
        return '부진';
    }
  }

  String _injuryText(InjuryStatus injury) {
    switch (injury) {
      case InjuryStatus.none:
        return '-';
      case InjuryStatus.minor:
        return '경미';
      case InjuryStatus.moderate:
        return '중간';
      case InjuryStatus.severe:
        return '심각';
    }
  }
}
