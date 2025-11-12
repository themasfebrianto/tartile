/// Progress user terhadap pelajaran (lesson)
class UserProgressEntity {
  final String id; // 🔑 Unique ID progress
  final String userId; // 🔗 Relasi ke AuthUser
  final String lessonId; // 🔗 Relasi ke LessonEntity
  final bool isCompleted; // Apakah lesson sudah diselesaikan
  final DateTime? completedAt; // Waktu selesai
  final int attempts; // Jumlah percobaan kuis / latihan
  final double? quizScore; // Skor kuis terakhir
  final DateTime createdAt; // Tanggal entry dibuat
  final DateTime? updatedAt; // Terakhir diupdate

  UserProgressEntity({
    required this.id,
    required this.userId,
    required this.lessonId,
    this.isCompleted = false,
    this.completedAt,
    this.attempts = 0,
    this.quizScore,
    required this.createdAt,
    this.updatedAt,
  });
}
