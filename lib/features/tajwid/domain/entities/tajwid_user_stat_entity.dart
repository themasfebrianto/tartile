class UserTajwidStats {
  final String userId;
  int totalPoints; // gamification points
  int level; // SoloLearn style leveling
  int streak; // number of consecutive learning days
  DateTime? lastLogin;

  UserTajwidStats({
    required this.userId,
    this.totalPoints = 0,
    this.level = 1,
    this.streak = 0,
    this.lastLogin,
  });
}
