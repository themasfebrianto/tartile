import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tartile/features/auth/presentation/screens/login_screen.dart';
import 'package:tartile/features/dashboard/presentation/widgets/about_app_widget.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_category_repository.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_rules_repository.dart';
import 'package:tartile/features/Dashboard/presentation/screens/dashboard_screen.dart';
import 'package:tartile/features/tajwid/presentation/screens/category_screen.dart';

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
                  'Tartil.in',
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
          // === Belajar Tajwid ===
          ListTile(
            leading: const Icon(Icons.book),
            title: const Text('Belajar Tajwid'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryScreen(
                    rulesRepository: rulesRepository,
                    categoryRepository: categoryRepository,
                  ),
                ),
              );
            },
          ),
          // === Tentang Aplikasi ===
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Tentang Aplikasi'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (context) => const AboutAppDialog(),
              );
            },
          ),
          // === Logout ===
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              Navigator.pop(context); // tutup drawer
              await FirebaseAuth.instance.signOut(); // logout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
