import 'package:flutter/material.dart';
import '../../widgets/retro_theme.dart';

class MomentumBar extends StatelessWidget {
  final int momentum;

  const MomentumBar({super.key, required this.momentum});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'MOMENTUM',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: RetroColors.textSecondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              _buildMomentumLabel(context),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            height: 12,
            decoration: BoxDecoration(
              color: RetroColors.surface,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: RetroColors.divider),
            ),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final center = width / 2;

                double barWidth = (momentum.abs() / 3) * (width / 2);
                if (barWidth == 0) barWidth = 2; // 최소 표시

                return Stack(
                  children: [
                    // 중앙선
                    Positioned(
                      left: center - 1,
                      width: 2,
                      top: 0,
                      bottom: 0,
                      child: Container(color: RetroColors.textSecondary),
                    ),

                    // 모멘텀 바
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      left: momentum >= 0 ? center : center - barWidth,
                      width: barWidth,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          color: momentum > 0
                              ? RetroColors.primary
                              : momentum < 0
                                  ? RetroColors.error
                                  : RetroColors.textSecondary,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMomentumLabel(BuildContext context) {
    String text;
    Color color;

    if (momentum > 1) {
      text = 'DOMINATING 🔥';
      color = RetroColors.primary;
    } else if (momentum > 0) {
      text = 'GOOD FLOW';
      color = RetroColors.success;
    } else if (momentum < -1) {
      text = 'CRITICAL ⚠️';
      color = RetroColors.error;
    } else if (momentum < 0) {
      text = 'UNDER PRESSURE';
      color = RetroColors.warning;
    } else {
      text = 'NEUTRAL';
      color = RetroColors.textSecondary;
    }

    return Text(
      text,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: color,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
