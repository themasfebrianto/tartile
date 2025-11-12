import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tartile/core/widgets/gesture/widget_gesture.dart';
import 'package:tartile/features/module/application/controllers/lesson_controller.dart';
import '../../../../core/widgets/layouts/spacing.dart';
import '../../../../core/widgets/containers/gradient_container.dart';
import '../../data/dtos/lesson/lesson_filter_dto.dart';

class LessonScreen extends StatelessWidget {
  final LessonFilterDto filter;

  const LessonScreen({super.key, required this.filter});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          LessonController(repository: context.read())..loadLessons(filter),
      child: Consumer<LessonController>(
        builder: (context, controller, _) {
          if (controller.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.error != null) {
            return Center(child: Text('Error: ${controller.error}'));
          }

          final lessons = controller.getLessons(filter);
          if (lessons.isEmpty) {
            return const Center(child: Text('No lessons found'));
          }

          return Scaffold(
            appBar: AppBar(title: const Text('Lessons')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemCount: lessons.length,
                separatorBuilder: (_, __) => Spacing.vertical(12),
                itemBuilder: (_, index) {
                  final lesson = lessons[index];
                  return GradientContainer(
                    gradient: const LinearGradient(
                      colors: [Colors.blue, Colors.blueAccent],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lesson.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            lesson.content,
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).buildGesture(
                    onTap: () {
                      // TODO: navigate to lesson detail or player
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
