import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/core/widgets/gesture/widget_gesture.dart';
import '../../../../core/widgets/layouts/spacing.dart';
import '../../../../core/widgets/cards/info_card.dart';
import '../../application/controllers/category_controller.dart';
import '../../data/dtos/category/category_filter_dto.dart';
import '../../data/dtos/lesson/lesson_filter_dto.dart';
import 'lesson_screen.dart';

class CategoryScreen extends StatelessWidget {
  final CategoryFilterDto filter;

  const CategoryScreen({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CategoryController(repository: context.read())
            ..loadCategories(filter),
      child: Consumer<CategoryController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(child: Text('Error: ${controller.error}'));
          }

          final categories = controller.getCategories(filter.courseId ?? '');
          if (categories.isEmpty) {
            return const Center(child: Text('No categories found'));
          }

          return Scaffold(
            appBar: AppBar(title: const Text('Categories')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemCount: categories.length,
                separatorBuilder: (_, __) => Spacing.vertical(12),
                itemBuilder: (_, index) {
                  final cat = categories[index];
                  return InfoCard(
                    icon: Icons.category_rounded,
                    iconColor: Colors.deepPurple,
                    value: cat.title,
                    label: cat.description,
                  ).buildGesture(
                    onTap: () {
                      final lessonFilter = LessonFilterDto(categoryId: cat.id);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LessonScreen(filter: lessonFilter),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
