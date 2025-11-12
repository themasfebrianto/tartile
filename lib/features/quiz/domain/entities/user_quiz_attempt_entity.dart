/// Percobaan menjawab kuis oleh user
class UserQuizAttemptEntity {
  final String id; // 🔑 Unique ID
  final String userId; // 🔗 Relasi ke AuthUser
  final String quizId; // 🔗 Relasi ke QuizEntity
  final int selectedAnswerIndex; // Jawaban yang dipilih user
  final bool isCorrect; // Apakah jawaban benar
  final DateTime attemptedAt; // Waktu percobaan

  UserQuizAttemptEntity({
    required this.id,
    required this.userId,
    required this.quizId,
    required this.selectedAnswerIndex,
    required this.isCorrect,
    required this.attemptedAt,
  });
}
