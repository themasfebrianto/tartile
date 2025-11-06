import 'package:flutter/material.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_category_repository.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_rules_repository.dart';
import 'package:tartile/features/tajwid/presentation/screens/dashboard_screen.dart';

class AppDrawer extends StatelessWidget {
  final TajwidRulesRepository rulesRepository;
  final TajwidCategoryRepository categoryRepository;

  const AppDrawer({
    super.key,
    required this.rulesRepository,
    required this.categoryRepository,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: colorScheme.surface,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.teal),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.menu_book, color: Colors.teal, size: 30),
                ),
                SizedBox(height: 12),
                Text(
                  'Tartile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Belajar Tajwid Interaktif',
                  style: TextStyle(color: Colors.white70),
                ),
              ],
            ),
          ),
          // === Beranda ===
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => DashboardScreen(
                    rulesRepository: rulesRepository,
                    categoryRepository: categoryRepository,
                  ),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Belajar Tajwid'),
            onTap: () => Navigator.pop(context),
          ),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.pop(context);
              showAboutDialog(
                context: context,
                applicationName: 'Tartile',
                applicationVersion: '1.0.0',
                children: const [
                  Text(
                    'Aplikasi pembelajaran tajwid interaktif untuk membantu memahami cara membaca Al-Qur’an dengan benar.',
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
