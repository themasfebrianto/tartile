import 'package:flutter/material.dart';
import 'package:tartile/core/theme/app_theme.dart';

class AchievementBadge extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String label;

  const AchievementBadge({
    super.key,
    required this.icon,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color.withValues(alpha: 0.2),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: AppTextStyles.body(
            Theme.of(context).colorScheme.onSurface,
          ).copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
