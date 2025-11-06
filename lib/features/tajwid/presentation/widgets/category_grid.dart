import 'package:flutter/material.dart';
import 'package:tartile/features/tajwid/domain/entities/tajwid_category_entity.dart';
import 'package:tartile/features/tajwid/domain/repositories/tajwid_rules_repository.dart';
import 'package:tartile/features/tajwid/presentation/screens/rule_list_screen.dart';

class CategoryGridWidget extends StatefulWidget {
  final List<TajwidCategoryEntity> categories;
  final TajwidRulesRepository rulesRepository;
  final List<Color> colors;

  const CategoryGridWidget({
    super.key,
    required this.categories,
    required this.rulesRepository,
    required this.colors,
  });

  @override
  State<CategoryGridWidget> createState() => _CategoryGridWidgetState();
}

class _CategoryGridWidgetState extends State<CategoryGridWidget> {
  int? _pressedIndex;

  @override
  Widget build(BuildContext context) {
    if (widget.categories.isEmpty) {
      return const Center(child: Text('Tidak ada hasil.'));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: GridView.builder(
        itemCount: widget.categories.length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1.1,
        ),
        itemBuilder: (context, index) {
          final cat = widget.categories[index];
          final color = widget.colors[index % widget.colors.length];
          final isPressed = _pressedIndex == index;

          return GestureDetector(
            onTapDown: (_) => setState(() => _pressedIndex = index),
            onTapUp: (_) => setState(() => _pressedIndex = null),
            onTapCancel: () => setState(() => _pressedIndex = null),
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              curve: Curves.easeOut,
              transform: Matrix4.identity()
                ..scaledByDouble(
                  isPressed ? 0.95 : 1.0, // scaleX
                  isPressed ? 0.95 : 1.0, // scaleY
                  1.0,
                  1.0,
                ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [color.withValues(alpha: 0.75), color],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.35),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            cat.icon,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'NotoSansArabic',
                              color: Colors.white,
                              fontSize: 42,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        cat.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          shadows: [
                            Shadow(
                              color: Colors.black26,
                              offset: const Offset(1, 1),
                              blurRadius: 2,
                            ),
                          ],
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
    );
  }
}
