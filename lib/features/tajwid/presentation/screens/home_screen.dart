import 'dart:async';
import 'package:flutter/material.dart';
import '../../domain/entities/tajwid_category_entity.dart';
import '../../domain/repositories/tajwid_category_repository.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';
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
  List<TajwidCategoryEntity> _allCategories = [];
  List<TajwidCategoryEntity> _filteredCategories = [];
  bool _isLoading = true;
  String _query = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() => _isLoading = true);

    try {
      debugPrint('🔹 Memulai load kategori...');
      final categories = await widget.categoryRepository.getAllCategories();
      debugPrint('✅ Selesai load kategori: ${categories.length} item');

      setState(() {
        _allCategories = categories;
        _filteredCategories = categories;
        _isLoading = false;
      });
    } catch (e, s) {
      debugPrint('❌ Error loading categories: $e');
      debugPrintStack(stackTrace: s);
      setState(() => _isLoading = false);
    }
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      setState(() {
        _query = value;
        if (_query.isEmpty) {
          _filteredCategories = _allCategories;
        } else {
          _filteredCategories = _allCategories
              .where(
                (cat) => cat.title.toLowerCase().contains(_query.toLowerCase()),
              )
              .toList();
        }
      });
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Colors.teal,
      Colors.indigo,
      Colors.deepOrange,
      Colors.purple,
      Colors.green,
      Colors.cyan,
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tartile Tajwid'),
        backgroundColor: Colors.teal,
      ),
      body: RefreshIndicator(
        onRefresh: _loadCategories,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  // 🔍 Search Bar
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 10,
                    ),
                    child: TextField(
                      onChanged: _onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Cari kategori tajwid...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                    ),
                  ),
                  Expanded(
                    child: _filteredCategories.isEmpty
                        ? const Center(child: Text('Tidak ada hasil.'))
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: GridView.builder(
                              itemCount: _filteredCategories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 1.1,
                                  ),
                              itemBuilder: (context, index) {
                                final cat = _filteredCategories[index];
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
                                    color: color.withValues(alpha: 0.75),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 4,
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.menu_book_rounded,
                                              color: Colors.white,
                                              size: 42,
                                            ),
                                            const SizedBox(height: 12),
                                            Text(
                                              cat.title,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                  ),
                ],
              ),
      ),
    );
  }
}
