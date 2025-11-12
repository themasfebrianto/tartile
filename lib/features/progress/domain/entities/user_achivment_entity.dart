/// Relasi user dengan achievement yang sudah dibuka
class UserAchievementEntity {
  final String id; // 🔑 Unique ID
  final String userId; // 🔗 Relasi ke AuthUser
  final String achievementId; // 🔗 Relasi ke AchievementEntity
  final DateTime unlockedAt; // Tanggal terbuka
  final bool isNew; // Untuk menampilkan notifikasi baru

  UserAchievementEntity({
    required this.id,
    required this.userId,
    required this.achievementId,
    required this.unlockedAt,
    this.isNew = true,
  });
}
