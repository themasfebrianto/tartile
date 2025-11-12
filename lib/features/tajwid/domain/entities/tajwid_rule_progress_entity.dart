class TajwidRuleProgress {
  final String userId;
  final String ruleId;
  int completedLessons; // number of times user practiced this rule
  double mastery; // 1 started, 2 learning, 3 mastered
  DateTime? lastPracticed;

  TajwidRuleProgress({
    required this.userId,
    required this.ruleId,
    this.completedLessons = 0,
    this.mastery = 0.0,
    this.lastPracticed,
  });
}
