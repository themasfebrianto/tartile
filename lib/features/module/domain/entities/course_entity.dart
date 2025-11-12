/// Representasi satu kursus utama (contoh: Tajwid, Yaumi, Iman & Islam)
class CourseEntity {
  final String id; // 🔑 Unique ID untuk fitur (ex: tajwid, yaumi, blog)
  final String title; // Nama fitur (contoh: Tajwid)
  final String description; // Deskripsi singkat fitur
  final String icon; // Ikon fitur
  final int ordering; // Urutan tampil di dashboard
  final bool isLocked; // Apakah fitur terkunci
  final DateTime createdAt; // Tanggal fitur dibuat
  final DateTime? updatedAt; // Tanggal terakhir diupdate

  CourseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.ordering,
    this.isLocked = false,
    required this.createdAt,
    this.updatedAt,
  });
}
