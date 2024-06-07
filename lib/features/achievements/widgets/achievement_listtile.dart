import 'package:crystalclear/features/achievements/enum/achievement_type.dart';
import 'package:flutter/material.dart';

class AchievementListTile extends StatelessWidget {
  const AchievementListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.type,
    this.achieved = false,
  });

  final String title;
  final String subtitle;
  final AchievementType type;
  final bool achieved;

  Color getColorByType() {
    if (!achieved) {
      return const Color(0xFFe6e6e6);
    }

    switch (type) {
      case AchievementType.common:
        return const Color(0xFFd77b49);
      case AchievementType.rare:
        return const Color(0xFFbdbdc0);
      case AchievementType.epic:
        return const Color(0xFFf2bd00);
      default:
        return const Color(0xFFd77b49);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: TextStyle(
          color: achieved ? Colors.black : const Color(0xFF8F9098),
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: achieved ? Colors.black : const Color(0xFFC5C6CC),
        ),
      ),
      leading: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          color: getColorByType(),
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(
          Icons.emoji_events_outlined,
          color: Colors.white,
        ),
      ),
    );
  }
}
