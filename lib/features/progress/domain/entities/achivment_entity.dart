class AchievementEntity {
  final String id; // 🔑 Unique ID
  final String title; // Nama pencapaian
  final String description; // Deskripsi pencapaian
  final String icon; // Ikon
  final String category; // Kategori (streak, lesson, quiz, daily_task)
  final int targetValue; // Nilai target (contoh: 10 lesson)
  final int xpReward; // Reward XP
  final DateTime createdAt; // Tanggal dibuat
  final DateTime? updatedAt; // Terakhir diupdate

  AchievementEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.category,
    required this.targetValue,
    this.xpReward = 50,
    required this.createdAt,
    this.updatedAt,
  });
}
