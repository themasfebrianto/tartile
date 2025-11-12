import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/core/widgets/gesture/widget_gesture.dart';
import 'package:tartile/features/module/application/controllers/course_controller.dart';
import '../../../../core/widgets/layouts/spacing.dart';
import '../../../../core/widgets/cards/info_card.dart';
import '../../data/dtos/category/category_filter_dto.dart';
import 'category_screen.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          CourseController(repository: context.read())..loadCourses(),
      child: Consumer<CourseController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.error != null) {
            return Center(child: Text('Error: ${controller.error}'));
          }

          final courses = controller.courses;
          if (courses.isEmpty) {
            return const Center(child: Text('No courses available'));
          }

          return Scaffold(
            appBar: AppBar(title: const Text('Courses')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemCount: courses.length,
                separatorBuilder: (_, __) => Spacing.vertical(12),
                itemBuilder: (_, index) {
                  final course = courses[index];
                  return InfoCard(
                    icon: Icons.menu_book_rounded,
                    iconColor: Colors.blue,
                    value: course.title,
                    label: course.description,
                  ).buildGesture(
                    onTap: () {
                      // Buat filter untuk CategoryScreen
                      final categoryFilter = CategoryFilterDto(
                        courseId: course.id,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              CategoryScreen(filter: categoryFilter),
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
