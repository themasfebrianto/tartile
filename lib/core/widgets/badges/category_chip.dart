import 'package:flutter/material.dart';
import 'package:tartile/core/theme/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final VoidCallback? onTap;
  final bool selected;

  const CategoryChip({
    super.key,
    required this.label,
    this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: selected ? cs.primary : cs.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: selected ? cs.primary : cs.onSurface.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.body(
            selected ? cs.onPrimary : cs.onSurface,
          ).copyWith(fontSize: 13),
        ),
      ),
    );
  }
}
