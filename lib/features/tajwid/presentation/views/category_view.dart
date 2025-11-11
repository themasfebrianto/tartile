import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/core/constants/app_colors.dart';
import 'package:tartile/core/theme/app_theme.dart';
import 'package:tartile/features/dashboard/presentation/widgets/app_drawer.dart';
import 'package:tartile/features/tajwid/presentation/controllers/tajwid_category_controller.dart';
import 'package:tartile/features/tajwid/presentation/widgets/category_grid.dart';
import 'package:tartile/features/tajwid/presentation/widgets/search_bar.dart';

class CategoryView extends StatelessWidget {
  final void Function(String) onSearchChanged;

  const CategoryView({super.key, required this.onSearchChanged});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<TajwidCategoryController>();
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
          'Kategori Tajwid',
          style: AppTextStyles.appBarTitle(colorScheme.onSurface),
        ),
      ),
      drawer: AppDrawer(
        categoryRepository: controller.tajwidCategoryRepository,
        rulesRepository: controller.tajwidRulesRepository,
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadCategories,
        color: colorScheme.primary,
        child: controller.isLoading
            ? Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: SearchBarWidget(onChanged: onSearchChanged),
                  ),
                  Expanded(
                    child: CategoryGridWidget(
                      categories: controller.filteredCategories,
                      rulesRepository: controller.tajwidRulesRepository,
                      colors: cardColors,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
