import 'package:tartile/core/utils/base/filter_base.dart';

/// Filter untuk LessonEntity (materi per bab dalam kategori)
class LessonFilterDto extends FilterBase {
  final String? id;
  final String? categoryId;
  final String? title;
  final bool? includeLocked;
  final int? minXp;
  final int? maxXp;

  const LessonFilterDto({
    this.id,
    this.categoryId,
    this.title,
    this.includeLocked,
    this.minXp,
    this.maxXp,
    super.page,
    super.limit,
    super.search,
    super.sortBy,
    super.sortDirection,
    super.startDate,
    super.endDate,
  });

  @override
  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'includeLocked': includeLocked,
      'minXp': minXp,
      'maxXp': maxXp,
    }..removeWhere((_, v) => v == null);
  }
}
