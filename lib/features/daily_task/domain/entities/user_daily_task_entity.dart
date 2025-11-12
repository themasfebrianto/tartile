/// Catatan penyelesaian task harian user
class UserDailyTaskEntity {
  final String id; // 🔑 Unique ID
  final String userId; // 🔗 Relasi ke AuthUser
  final String taskId; // 🔗 Relasi ke DailyTaskEntity
  final DateTime date; // Tanggal task (YYYY-MM-DD)
  final bool isCompleted; // Sudah selesai atau belum
  final DateTime? completedAt; // Waktu selesai

  UserDailyTaskEntity({
    required this.id,
    required this.userId,
    required this.taskId,
    required this.date,
    this.isCompleted = false,
    this.completedAt,
  });
}
