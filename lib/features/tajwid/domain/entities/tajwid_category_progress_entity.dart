class TajwidCategoryProgress {
  final String userId;
  final String categoryId;
  int completedRules; //count of rules fully mastered in the category.
  int totalRules; //helps calculate progress percentage
  double mastery; // average mastery of all rules in this category

  TajwidCategoryProgress({
    required this.userId,
    required this.categoryId,
    required this.completedRules,
    required this.totalRules,
    this.mastery = 0.0,
  });
}
