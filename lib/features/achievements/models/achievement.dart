import 'package:crystalclear/features/achievements/enum/achievement_type.dart';

class Achievement {
  final String title;
  final String subtitle;
  final AchievementType type;
  final bool achieved;

  Achievement({
    required this.title,
    required this.subtitle,
    required this.type,
    required this.achieved,
  });
}