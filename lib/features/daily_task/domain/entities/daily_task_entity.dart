/// Template tugas harian (contoh: Sholat, Dzikir, Tilawah)
class DailyTaskEntity {
  final String id; // 🔑 Unique ID task
  final String title; // Nama task (contoh: Shalat Subuh)
  final String description; // Deskripsi task
  final String icon; // Ikon
  final int xpReward; // XP yang diberikan
  final String category; // Kategori (prayer, quran, dhikr)
  final bool isDefault; // Apakah task bawaan sistem
  final DateTime createdAt;
  final DateTime? updatedAt;

  DailyTaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    this.xpReward = 5,
    required this.category,
    this.isDefault = true,
    required this.createdAt,
    this.updatedAt,
  });
}
