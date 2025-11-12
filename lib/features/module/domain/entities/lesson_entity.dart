/// Materi pembelajaran detail dalam kategori (berisi teks, video, audio)
class LessonEntity {
  final String id; // 🔑 Unique ID lesson
  final String categoryId; // 🔗 Relasi ke CategoryEntity
  final String title; // Judul lesson (contoh: Idgham Bighunnah)
  final String content; // Konten teks (markdown / html)
  final String? videoUrl; // URL video pendukung
  final String? audioUrl; // URL audio contoh bacaan
  final int ordering; // Urutan lesson dalam kategori
  final int estimatedMinutes; // Perkiraan waktu belajar
  final int xpReward; // XP reward setelah selesai
  final DateTime createdAt; // Tanggal dibuat
  final DateTime? updatedAt; // Terakhir diupdate

  LessonEntity({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.content,
    this.videoUrl,
    this.audioUrl,
    required this.ordering,
    required this.estimatedMinutes,
    this.xpReward = 10,
    required this.createdAt,
    this.updatedAt,
  });
}
