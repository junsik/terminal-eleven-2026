// 훈련 화면

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../../presentation/widgets/retro_theme.dart';

class TrainingScreen extends ConsumerWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pc = ref.watch(engineCharacterProvider);
    final weeklyActions = ref.watch(engineWeeklyActionsProvider);

    if (pc == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: RetroColors.background,
      appBar: AppBar(
        title: const Text('훈련'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 상태 표시
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _statusItem('피로', pc.status.fatigue, RetroColors.error),
                    _statusItem('행동', weeklyActions, RetroColors.primary),
                    if (pc.status.injury != InjuryStatus.none)
                      _statusItem('부상', pc.status.injuryWeeksRemaining, RetroColors.warning),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              '훈련 선택',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.3,
                children: TrainingType.values.map((training) {
                  final canTrain = _canDoTraining(pc, training, weeklyActions);

                  return _TrainingCard(
                    training: training,
                    enabled: canTrain,
                    onTap: canTrain
                        ? () {
                            ref.read(orchestratorProvider)
                                .executeTraining(training);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${training.displayName} 완료!'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          }
                        : null,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _canDoTraining(PlayerCharacter pc, TrainingType training, int actions) {
    if (actions <= 0) return false;

    // 피로도 30 미만이면 훈련 불가 (휴식/재활만 가능)
    if (pc.status.fatigue >= 70 && !training.isRest) return false;

    // 재활은 부상 시에만 가능
    if (training == TrainingType.rehab && pc.status.injury == InjuryStatus.none) {
      return false;
    }

    return true;
  }

  Widget _statusItem(String label, int value, Color color) {
    return Column(
      children: [
        Text(
          '$value',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
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
}

class _TrainingCard extends StatelessWidget {
  final TrainingType training;
  final bool enabled;
  final VoidCallback? onTap;

  const _TrainingCard({
    required this.training,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: enabled ? RetroColors.surface : RetroColors.background,
          border: Border.all(
            color: enabled ? RetroColors.primary : RetroColors.divider,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getIcon(training),
              color: enabled ? RetroColors.primary : RetroColors.divider,
              size: 24,
            ),
            const SizedBox(height: 8),
            Text(
              training.displayName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: enabled ? RetroColors.primary : RetroColors.divider,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              training.description,
              style: TextStyle(
                fontSize: 10,
                color: enabled ? RetroColors.textSecondary : RetroColors.divider,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIcon(TrainingType training) {
    switch (training) {
      case TrainingType.shooting:
        return Icons.sports_soccer;
      case TrainingType.passing:
        return Icons.swap_horiz;
      case TrainingType.dribbling:
        return Icons.run_circle;
      case TrainingType.positioning:
        return Icons.my_location;
      case TrainingType.stamina:
        return Icons.fitness_center;
      case TrainingType.composure:
        return Icons.psychology;
      case TrainingType.rest:
        return Icons.hotel;
      case TrainingType.rehab:
        return Icons.healing;
    }
  }
}
