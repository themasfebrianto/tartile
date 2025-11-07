import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tartile/core/constants/app_colors.dart';
import 'package:tartile/core/theme/app_theme.dart';
import 'package:tartile/features/tajwid/presentation/widgets/app_drawer.dart';
import 'package:tartile/features/tajwid/presentation/widgets/category_grid.dart';
import 'package:tartile/features/tajwid/presentation/widgets/search_bar.dart';
import '../../domain/entities/tajwid_category_entity.dart';
import '../../domain/repositories/tajwid_category_repository.dart';
import '../../domain/repositories/tajwid_rules_repository.dart';

class CategoryScreen extends StatefulWidget {
  final TajwidRulesRepository rulesRepository;
  final TajwidCategoryRepository categoryRepository;

  const CategoryScreen({
    super.key,
    required this.rulesRepository,
    required this.categoryRepository,
  });

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
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
      debugPrint('🔹 Memulai Seed Database...');
      final categories = await widget.categoryRepository.getAllCategories();
      debugPrint('✅ Selesai Seed Database...');
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
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.surface,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu_rounded),
            color: colorScheme.onSurface,
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Text(
          'Tartile Tajwid',
          style: AppTextStyles.appBarTitle(colorScheme.onSurface),
        ),
      ),
      drawer: AppDrawer(
        categoryRepository: widget.categoryRepository,
        rulesRepository: widget.rulesRepository,
      ),
      body: RefreshIndicator(
        onRefresh: _loadCategories,
        color: colorScheme.primary,
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              )
            : Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: SearchBarWidget(onChanged: _onSearchChanged),
                  ),
                  Expanded(
                    child: CategoryGridWidget(
                      categories: _filteredCategories,
                      rulesRepository: widget.rulesRepository,
                      colors: cardColors,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
