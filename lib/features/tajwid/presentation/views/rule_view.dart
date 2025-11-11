import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/core/constants/app_colors.dart';
import 'package:tartile/features/tajwid/presentation/controllers/tajwid_rule_controller.dart';
import 'package:tartile/features/tajwid/presentation/widgets/rule_card.dart';

class RuleView extends StatelessWidget {
  final String categoryName;

  const RuleView({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TajwidRuleController>();
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          color: colorScheme.onSurface,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          categoryName,
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Builder(
        builder: (_) {
          if (controller.isLoading) {
            return Center(
              child: CircularProgressIndicator(color: colorScheme.primary),
            );
          }

          if (controller.errorMessage != null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terjadi Kesalahan',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: colorScheme.onSurface,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      controller.errorMessage!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (controller.rules.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_rounded,
                    size: 64,
                    color: colorScheme.onSurfaceVariant.withAlpha(128),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Belum ada hukum tajwid',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: colorScheme.onSurfaceVariant,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 12),
            itemCount: controller.rules.length,
            itemBuilder: (context, index) {
              final rule = controller.rules[index];

              return TajwidRuleCard(
                key: ValueKey(index),
                rule: rule,
                color: cardColors[index % cardColors.length],
                isExpanded: controller.expandedIndex == index,
                onExpansionChanged: (expanded) =>
                    controller.toggleExpansion(index, expanded),
              );
            },
          );
        },
      ),
    );
  }
}
