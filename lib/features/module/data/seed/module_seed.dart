import 'package:tartile/features/module/data/data_sources/category_local_data_source.dart';
import 'package:tartile/features/module/data/data_sources/course_local_data_source.dart';
import 'package:tartile/features/module/data/data_sources/lesson_local_data_source.dart';
import 'package:tartile/features/module/domain/entities/course_entity.dart';
import 'package:tartile/features/module/domain/entities/category_entity.dart';
import 'package:tartile/features/module/domain/entities/lesson_entity.dart';

class ModuleSeed {
  final CourseLocalDataSource courseLocal;
  final CategoryLocalDataSource categoryLocal;
  final LessonLocalDataSource lessonLocal;

  ModuleSeed({
    required this.courseLocal,
    required this.categoryLocal,
    required this.lessonLocal,
  });

  /// Seed data courses, categories, lessons
  Future<void> seed() async {
    await _seedCourses();
    await _seedCategories();
    await _seedLessons();
  }

  Future<void> _seedCourses() async {
    final courses = [
      CourseEntity(
        id: 'tajwid',
        title: 'Tajwid',
        description: 'Belajar tajwid dari dasar hingga mahir',
        icon: 'assets/icons/tajwid.png',
        ordering: 1,
        createdAt: DateTime.now(),
      ),
      CourseEntity(
        id: 'yaumi',
        title: 'Yaumi',
        description: 'Latihan harian membaca Al-Qur’an',
        icon: 'assets/icons/yaumi.png',
        ordering: 2,
        createdAt: DateTime.now(),
      ),
      CourseEntity(
        id: 'iman',
        title: 'Iman & Islam',
        description: 'Materi dasar Iman dan Islam',
        icon: 'assets/icons/iman.png',
        ordering: 3,
        createdAt: DateTime.now(),
      ),
    ];

    await courseLocal.clearCourses();
    await courseLocal.insertCourses(courses);
  }

  Future<void> _seedCategories() async {
    final categories = [
      CategoryEntity(
        id: 'hukum_nun_sukun',
        courseId: 'tajwid',
        title: 'Hukum Nun Sukun',
        description: 'Aturan bacaan Nun Sukun dan tanwin',
        ordering: 1,
        createdAt: DateTime.now(),
      ),
      CategoryEntity(
        id: 'hukum_idgham',
        courseId: 'tajwid',
        title: 'Idgham',
        description: 'Belajar hukum Idgham dengan tajwid',
        ordering: 2,
        createdAt: DateTime.now(),
      ),
      CategoryEntity(
        id: 'sholat_fardhu',
        courseId: 'yaumi',
        title: 'Sholat Fardhu',
        description: 'Panduan sholat wajib dan tata caranya',
        ordering: 1,
        createdAt: DateTime.now(),
      ),
    ];

    await categoryLocal.clearCategories();
    await categoryLocal.insertCategories(categories);
  }

  Future<void> _seedLessons() async {
    final lessons = [
      LessonEntity(
        id: 'lesson1',
        categoryId: 'hukum_nun_sukun',
        title: 'Nun Sukun dan Tanwin',
        content: 'Penjelasan lengkap hukum Nun Sukun dan Tanwin',
        ordering: 1,
        estimatedMinutes: 10,
        createdAt: DateTime.now(),
      ),
      LessonEntity(
        id: 'lesson2',
        categoryId: 'hukum_idgham',
        title: 'Idgham Bighunnah',
        content: 'Belajar Idgham Bighunnah secara detail',
        ordering: 1,
        estimatedMinutes: 12,
        createdAt: DateTime.now(),
      ),
      LessonEntity(
        id: 'lesson3',
        categoryId: 'sholat_fardhu',
        title: 'Sholat Subuh',
        content: 'Tata cara sholat Subuh lengkap dengan bacaan',
        ordering: 1,
        estimatedMinutes: 8,
        createdAt: DateTime.now(),
      ),
    ];

    await lessonLocal.clearLessons();
    await lessonLocal.insertLessons(lessons);
  }
}
