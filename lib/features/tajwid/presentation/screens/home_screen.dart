import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tartile/features/tajwid/presentation/widgets/app_drawer.dart';
import 'package:tartile/features/tajwid/presentation/widgets/category_grid.dart';
import 'package:tartile/features/tajwid/presentation/widgets/search_bar.dart';
import '../../domain/entities/tajwid_category_entity.dart';
import '../../domain/repositories/tajwid_category_repository.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';

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
      drawer: AppDrawer(
        categoryRepository: widget.categoryRepository,
        rulesRepository: widget.rulesRepository,
      ),
      body: RefreshIndicator(
        onRefresh: _loadCategories,
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  SearchBarWidget(onChanged: _onSearchChanged),
                  Expanded(
                    child: CategoryGridWidget(
                      categories: _filteredCategories,
                      rulesRepository: widget.rulesRepository,
                      colors: colors,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
