import 'package:flutter/material.dart';
import '../../widgets/retro_theme.dart';
import '../../../domain/model/command.dart';

class TacticalControls extends StatelessWidget {
  final Function(CommandType) onShout;

  const TacticalControls({super.key, required this.onShout});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildShoutButton(context, CommandType.shoutEncourage, '👏 격려'),
          _buildShoutButton(context, CommandType.shoutDemand, '🤬 질책'),
          _buildShoutButton(context, CommandType.shoutCalm, '🧘 진정'),
        ],
      ),
    );
  }

  Widget _buildShoutButton(BuildContext context, CommandType type, String label) {
    Color color;
    switch (type) {
      case CommandType.shoutEncourage:
        color = RetroColors.success;
        break;
      case CommandType.shoutDemand:
        color = RetroColors.error;
        break;
      case CommandType.shoutCalm:
        color = RetroColors.primary;
        break;
      default:
        color = RetroColors.textPrimary;
    }

    return InkWell(
      onTap: () => onShout(type),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: BorderRadius.circular(4),
          color: color.withOpacity(0.1),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
