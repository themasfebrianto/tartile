import 'package:flutter/material.dart';

/// ====== Progress Widget ======
class ProgressWidget extends StatelessWidget {
  final double progress;

  const ProgressWidget({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Belajar',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress.clamp(0.0, 1.0),
          minHeight: 10,
          backgroundColor: colorScheme.surfaceVariant,
          color: colorScheme.primary,
        ),
        const SizedBox(height: 8),
        Text(
          '${(progress * 100).toStringAsFixed(0)}% selesai',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
