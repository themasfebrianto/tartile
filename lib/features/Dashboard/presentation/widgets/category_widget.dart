import 'package:flutter/material.dart';

/// ====== Category Button Widget ======
class CategoryButtonWidget extends StatelessWidget {
  final VoidCallback onPressed;

  const CategoryButtonWidget({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kategori Tajwid', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.menu_book_rounded),
            label: const Text('Lihat Daftar Kategori'),
            style: ElevatedButton.styleFrom(
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
