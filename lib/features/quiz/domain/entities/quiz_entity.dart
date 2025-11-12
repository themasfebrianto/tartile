/// Soal kuis dalam setiap lesson
class QuizEntity {
  final String id; // 🔑 Unique ID
  final String lessonId; // 🔗 Relasi ke LessonEntity
  final String question; // Pertanyaan
  final List<String> options; // Pilihan jawaban ["A", "B", "C", "D"]
  final int correctAnswerIndex; // Index jawaban benar
  final String explanation; // Penjelasan jawaban benar
  final int ordering; // Urutan kuis
  final DateTime createdAt;
  final DateTime? updatedAt;

  QuizEntity({
    required this.id,
    required this.lessonId,
    required this.question,
    required this.options,
    required this.correctAnswerIndex,
    required this.explanation,
    required this.ordering,
    required this.createdAt,
    this.updatedAt,
  });
}
