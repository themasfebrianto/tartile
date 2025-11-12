/// Statistik umum user (XP, level, streak)
class UserStatsEntity {
  final String id; // 🔑 Primary key
  final String userId; // 🔗 Relasi ke AuthUser
  final int totalXp; // Total XP user
  final int level; // Level saat ini
  final int currentStreak; // Hari beruntun aktif
  final int longestStreak; // Rekor streak terpanjang
  final DateTime? lastActiveDate; // Terakhir aktif
  final int totalLessonsCompleted; // Jumlah lesson diselesaikan
  final int totalQuizzesPassed; // Jumlah kuis lulus
  final DateTime createdAt; // Tanggal dibuat
  final DateTime? updatedAt; // Terakhir diupdate

  UserStatsEntity({
    required this.id,
    required this.userId,
    this.totalXp = 0,
    this.level = 1,
    this.currentStreak = 0,
    this.longestStreak = 0,
    this.lastActiveDate,
    this.totalLessonsCompleted = 0,
    this.totalQuizzesPassed = 0,
    required this.createdAt,
    this.updatedAt,
  });
}
