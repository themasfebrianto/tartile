/// Base class untuk semua filter DTO.
/// Menyediakan fitur umum: pagination, search, sort, date range.
class FilterBase {
  /// Nomor halaman (mulai dari 1)
  final int? page;

  /// Jumlah item per halaman
  final int? limit;

  /// Kata kunci pencarian
  final String? search;

  /// Field untuk sorting
  final String? sortBy;

  /// Arah sorting: "asc" atau "desc"
  final String? sortDirection;

  /// Rentang waktu: tanggal mulai (opsional)
  final DateTime? startDate;

  /// Rentang waktu: tanggal akhir (opsional)
  final DateTime? endDate;

  const FilterBase({
    this.page = 1,
    this.limit = 20,
    this.search,
    this.sortBy,
    this.sortDirection = 'asc',
    this.startDate,
    this.endDate,
  });

  /// Untuk konversi ke map (misalnya ke query API / Firestore)
  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'limit': limit,
      'search': search,
      'sortBy': sortBy,
      'sortDirection': sortDirection,
      'startDate': startDate?.toIso8601String(),
      'endDate': endDate?.toIso8601String(),
    }..removeWhere((_, v) => v == null);
  }

  @override
  String toString() => 'FilterBase(${toMap()})';
}
