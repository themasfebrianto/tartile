import 'package:flutter/widgets.dart';
import 'package:tartile/features/module/data/data_sources/category_local_data_source.dart';
import 'package:tartile/features/module/data/data_sources/course_local_data_source.dart';
import 'package:tartile/features/module/data/data_sources/lesson_local_data_source.dart';
import 'package:tartile/features/module/data/seed/module_seed.dart';

class AppSeeder {
  static Future<void> seedApp() async {
    WidgetsFlutterBinding.ensureInitialized();

    final courseLocal = CourseLocalDataSource();
    final categoryLocal = CategoryLocalDataSource();
    final lessonLocal = LessonLocalDataSource();

    final seed = ModuleSeed(
      courseLocal: courseLocal,
      categoryLocal: categoryLocal,
      lessonLocal: lessonLocal,
    );

    await seed.seed(); // Seed data awal

    debugPrint('✅ AppSeeder: Data initial module seeded successfully.');
  }
}
