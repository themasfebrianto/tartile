import 'package:tartile/core/utils/base/filter_base.dart';

/// Filter untuk CategoryEntity (misalnya sub-modul dalam Course)
class CategoryFilterDto extends FilterBase {
  final String? id;
  final String? courseId; // FK ke CourseEntity
  final String? title;
  final bool? isLocked;
  final int? requiredLevel;

  const CategoryFilterDto({
    this.id,
    this.courseId,
    this.title,
    this.isLocked,
    this.requiredLevel,
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
      'featureId': courseId,
      'title': title,
      'isLocked': isLocked,
      'requiredLevel': requiredLevel,
    }..removeWhere((_, v) => v == null);
  }
}
