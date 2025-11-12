/// Sub-topik atau bab dalam Course (contoh: Hukum Nun Mati, Hukum Mim Mati)
class CategoryEntity {
  final String id; // 🔑 Unique ID kategori
  final String courseId; // 🔗 Relasi ke courseEntity
  final String title; // Nama kategori (contoh: Hukum Nun Sukun)
  final String description; // Penjelasan singkat kategori
  final String? icon; // Ikon opsional kategori
  final int ordering; // Urutan tampil di list
  final bool isLocked; // Apakah kategori terkunci
  final int? requiredLevel; // Level minimal untuk membuka
  final DateTime createdAt; // Tanggal dibuat
  final DateTime? updatedAt; // Terakhir diupdate

  CategoryEntity({
    required this.id,
    required this.courseId,
    required this.title,
    required this.description,
    this.icon,
    required this.ordering,
    this.isLocked = false,
    this.requiredLevel,
    required this.createdAt,
    this.updatedAt,
  });
}
