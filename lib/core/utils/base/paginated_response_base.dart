class PaginatedResult<T> {
  final List<T> data;
  final MetaPagination metaPagination;

  PaginatedResult({required this.data, required this.metaPagination});
}

class MetaPagination {
  final int page;
  final int limit;
  final int? totalItems;
  final bool hasNext;

  MetaPagination({
    required this.page,
    required this.limit,
    this.totalItems,
    required this.hasNext,
  });
}
