import 'package:tartile/core/utils/base/filter_base.dart';

/// Filter untuk CourseEntity (misalnya Tajwid, Ibadah, Konsep Islam)
class CourseFilterDto extends FilterBase {
  final String? id;
  final String? title;
  final bool? isLocked;

  const CourseFilterDto({
    this.id,
    this.title,
    this.isLocked,
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
    return {...super.toMap(), 'id': id, 'title': title, 'isLocked': isLocked}
      ..removeWhere((_, v) => v == null);
  }
}
