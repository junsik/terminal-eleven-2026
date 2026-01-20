// 훈련 화면

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers.dart';
import '../../domain/model/models.dart';
import '../../domain/model/game_snapshot.dart' show TrainingIntensity, TrainingIntensityX, TrainingType, TrainingTypeX;
import '../../domain/model/training_event.dart';
import '../../presentation/widgets/retro_theme.dart';

/// 선택된 훈련 강도 상태
final selectedIntensityProvider = StateProvider<TrainingIntensity>((ref) {
  return TrainingIntensity.normal;
});

class TrainingScreen extends ConsumerWidget {
  const TrainingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pc = ref.watch(engineCharacterProvider);
    final weeklyActions = ref.watch(engineWeeklyActionsProvider);
    final selectedIntensity = ref.watch(selectedIntensityProvider);

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
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _statusItem('피로', pc.status.fatigue, RetroColors.error),
                        _statusItem('행동', weeklyActions, RetroColors.primary),
                        if (pc.status.injury != InjuryStatus.none)
                          _statusItem('부상', pc.status.injuryWeeksRemaining, RetroColors.warning),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildConditionEfficiency(pc.status.fatigue, pc.status.confidence),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 훈련 강도 선택
            Text(
              '훈련 강도',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            _IntensitySelector(
              selected: selectedIntensity,
              onChanged: (intensity) {
                ref.read(selectedIntensityProvider.notifier).state = intensity;
              },
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
                    intensity: selectedIntensity,
                    enabled: canTrain,
                    onTap: canTrain
                        ? () {
                            // 훈련 실행 전 이전 이벤트 확인
                            final prevEvent = ref.read(engineLastTrainingEventProvider);

                            ref.read(orchestratorProvider).executeTraining(
                                  training,
                                  intensity: selectedIntensity,
                                );

                            // 훈련 실행 후 새 이벤트 확인
                            final newEvent = ref.read(engineLastTrainingEventProvider);

                            // 새로운 이벤트가 발생했는지 확인 (이전과 다른 경우)
                            final hasNewEvent = newEvent != null && newEvent != prevEvent;

                            if (hasNewEvent) {
                              _showEventDialog(context, newEvent, training);
                            } else {
                              final intensityText = selectedIntensity ==
                                      TrainingIntensity.normal
                                  ? ''
                                  : ' (${selectedIntensity.displayName})';
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${training.displayName}$intensityText 완료!'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            }
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

  void _showEventDialog(
    BuildContext context,
    TrainingEventResult event,
    TrainingType training,
  ) {
    final isPositive = event.eventType.isPositive;
    final color = isPositive ? Colors.green : Colors.orange;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: RetroColors.surface,
        title: Row(
          children: [
            Text(
              event.eventType.emoji,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                event.eventType.displayName,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.message ?? event.eventType.description,
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 16),
            _buildEventEffects(event),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('확인'),
          ),
        ],
      ),
    );
  }

  Widget _buildEventEffects(TrainingEventResult event) {
    final effects = <Widget>[];

    if (event.statMultiplier != 1.0) {
      final percent = ((event.statMultiplier - 1) * 100).round();
      final sign = percent >= 0 ? '+' : '';
      effects.add(_effectRow(
        '훈련 효과',
        '$sign$percent%',
        percent >= 0 ? Colors.green : Colors.red,
      ));
    }

    if (event.fatigueMultiplier != 1.0) {
      final percent = ((event.fatigueMultiplier - 1) * 100).round();
      final sign = percent >= 0 ? '+' : '';
      // 피로는 낮을수록 좋음
      effects.add(_effectRow(
        '피로 증가',
        '$sign$percent%',
        percent <= 0 ? Colors.green : Colors.red,
      ));
    }

    if (event.confidenceChange != 0) {
      final sign = event.confidenceChange >= 0 ? '+' : '';
      effects.add(_effectRow(
        '자신감',
        '$sign${event.confidenceChange}',
        event.confidenceChange >= 0 ? Colors.green : Colors.red,
      ));
    }

    if (event.trustChange != 0) {
      final sign = event.trustChange >= 0 ? '+' : '';
      effects.add(_effectRow(
        '신뢰도',
        '$sign${event.trustChange}',
        event.trustChange >= 0 ? Colors.green : Colors.red,
      ));
    }

    if (effects.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '효과',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: RetroColors.textSecondary,
          ),
        ),
        const SizedBox(height: 4),
        ...effects,
      ],
    );
  }

  Widget _effectRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConditionEfficiency(int fatigue, int confidence) {
    // 컨디션 효율 계산 (TrainingEngine과 동일한 로직)
    double efficiency = 1.0;

    // 피로도 패널티
    if (fatigue > 50) {
      final penalty = ((fatigue - 50) * 0.01).clamp(0.0, 0.3);
      efficiency -= penalty;
    }

    // 자신감 보너스
    efficiency += confidence * 0.05;
    efficiency = efficiency.clamp(0.5, 1.5);

    final percent = (efficiency * 100).round();
    final color = percent >= 100
        ? Colors.green
        : percent >= 80
            ? RetroColors.primary
            : Colors.orange;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            percent >= 100 ? Icons.trending_up : Icons.trending_down,
            size: 16,
            color: color,
          ),
          const SizedBox(width: 8),
          Text(
            '훈련 효율: $percent%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 13,
            ),
          ),
          if (fatigue > 50 || confidence != 0) ...[
            const SizedBox(width: 8),
            Text(
              _getEfficiencyHint(fatigue, confidence),
              style: TextStyle(
                fontSize: 11,
                color: color.withValues(alpha: 0.8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getEfficiencyHint(int fatigue, int confidence) {
    final hints = <String>[];
    if (fatigue > 50) hints.add('피로↑');
    if (confidence > 0) hints.add('자신감↑');
    if (confidence < 0) hints.add('자신감↓');
    return hints.isEmpty ? '' : '(${hints.join(', ')})';
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

/// 훈련 강도 선택 UI
class _IntensitySelector extends StatelessWidget {
  final TrainingIntensity selected;
  final ValueChanged<TrainingIntensity> onChanged;

  const _IntensitySelector({
    required this.selected,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: TrainingIntensity.values.map((intensity) {
        final isSelected = intensity == selected;
        return Expanded(
          child: GestureDetector(
            onTap: () => onChanged(intensity),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: isSelected ? _getIntensityColor(intensity) : RetroColors.surface,
                border: Border.all(
                  color: isSelected ? _getIntensityColor(intensity) : RetroColors.divider,
                  width: isSelected ? 2 : 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Icon(
                    _getIntensityIcon(intensity),
                    color: isSelected ? Colors.white : RetroColors.textSecondary,
                    size: 20,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    intensity.displayName,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.white : RetroColors.textPrimary,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    _getShortDescription(intensity),
                    style: TextStyle(
                      fontSize: 9,
                      color: isSelected ? Colors.white70 : RetroColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  IconData _getIntensityIcon(TrainingIntensity intensity) {
    switch (intensity) {
      case TrainingIntensity.light:
        return Icons.spa;
      case TrainingIntensity.normal:
        return Icons.fitness_center;
      case TrainingIntensity.intense:
        return Icons.local_fire_department;
    }
  }

  Color _getIntensityColor(TrainingIntensity intensity) {
    switch (intensity) {
      case TrainingIntensity.light:
        return Colors.green;
      case TrainingIntensity.normal:
        return RetroColors.primary;
      case TrainingIntensity.intense:
        return Colors.deepOrange;
    }
  }

  String _getShortDescription(TrainingIntensity intensity) {
    switch (intensity) {
      case TrainingIntensity.light:
        return '효과↓ 피로↓';
      case TrainingIntensity.normal:
        return '기본';
      case TrainingIntensity.intense:
        return '효과↑ 피로↑ 위험↑';
    }
  }
}

class _TrainingCard extends StatelessWidget {
  final TrainingType training;
  final TrainingIntensity intensity;
  final bool enabled;
  final VoidCallback? onTap;

  const _TrainingCard({
    required this.training,
    required this.intensity,
    required this.enabled,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 휴식/재활은 강도 영향 없음
    final showIntensityEffect = !training.isRest;

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
            Row(
              children: [
                Icon(
                  _getIcon(training),
                  color: enabled ? RetroColors.primary : RetroColors.divider,
                  size: 24,
                ),
                if (showIntensityEffect && enabled) ...[
                  const Spacer(),
                  _buildIntensityBadge(),
                ],
              ],
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
              _getDescription(),
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

  Widget _buildIntensityBadge() {
    final (color, text) = switch (intensity) {
      TrainingIntensity.light => (Colors.green, '70%'),
      TrainingIntensity.normal => (RetroColors.primary, '100%'),
      TrainingIntensity.intense => (Colors.deepOrange, '150%'),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }

  String _getDescription() {
    // 휴식/재활은 기본 설명
    if (training.isRest) return training.description;

    // 강도별 설명 수정
    final baseDesc = training.description;

    // 피로 수치 추출 및 강도 적용
    final fatigueMatch = RegExp(r'피로 \+(\d+)').firstMatch(baseDesc);
    if (fatigueMatch != null) {
      final baseFatigue = int.parse(fatigueMatch.group(1)!);
      final multiplier = switch (intensity) {
        TrainingIntensity.light => 0.7,
        TrainingIntensity.normal => 1.0,
        TrainingIntensity.intense => 1.5,
      };
      final adjustedFatigue = (baseFatigue * multiplier).round();
      return baseDesc.replaceFirst('피로 +$baseFatigue', '피로 +$adjustedFatigue');
    }

    return baseDesc;
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
