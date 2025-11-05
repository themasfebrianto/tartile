import 'package:flutter/material.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_category_repository.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';
import '../../domain/entities/tajwid_category_entity.dart';
import 'rule_list_screen.dart';

class HomeScreen extends StatefulWidget {
  final TajwidRulesRepository rulesRepository;
  final TajwidCategoryRepository categoryRepository;

  const HomeScreen({
    super.key,
    required this.rulesRepository,
    required this.categoryRepository,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<TajwidCategoryEntity>> _categoriesFuture;

  @override
  void initState() {
    super.initState();
    _categoriesFuture = widget.categoryRepository.getAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tartile Tajwid'),
        backgroundColor: Colors.teal,
      ),
      body: FutureBuilder<List<TajwidCategoryEntity>>(
        future: _categoriesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final categories = snapshot.data ?? [];
          if (categories.isEmpty) {
            return const Center(child: Text('Belum ada kategori tajwid.'));
          }

          final colors = [
            Colors.teal,
            Colors.indigo,
            Colors.deepOrange,
            Colors.purple,
            Colors.green,
            Colors.cyan,
          ];

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: GridView.builder(
              itemCount: categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.1,
              ),
              itemBuilder: (context, index) {
                final cat = categories[index];
                final color = colors[index % colors.length];

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => RuleListScreen(
                          categoryId: cat.id,
                          categoryName: cat.title,
                          repository: widget.rulesRepository,
                        ),
                      ),
                    );
                  },
                  child: Card(
                    color: color.withOpacity(0.85),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 4,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Text(
                          cat.title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
