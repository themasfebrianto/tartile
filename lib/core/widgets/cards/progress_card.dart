import 'package:flutter/material.dart';

class ProgressCard extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  final String label;

  const ProgressCard({super.key, required this.progress, required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              color: cs.primary,
              backgroundColor: cs.primary.withValues(alpha: 0.2),
            ),
          ],
        ),
      ),
    );
  }
}
