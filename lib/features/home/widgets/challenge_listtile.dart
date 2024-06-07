import 'package:crystalclear/core/utils/utils.dart';
import 'package:crystalclear/core/widgets/shimmer_effect.dart';
import 'package:flutter/material.dart';

class ChallengeListTile extends StatelessWidget {
  const ChallengeListTile({
    super.key,
    required this.title,
    required this.subtitle,
    required this.points,
    this.achieved = false,
  });

  final String title;
  final String subtitle;
  final int points;
  final bool achieved;

  Widget? getCheck() {
    if (!achieved) {
      return null;
    }

    if (points > 300) {
      return const Icon(
        Icons.check_circle_outline,
        color: Color(0xFFFFC700),
      );
    }

    if (points >= 100 && points <= 300) {
      return const Icon(
        Icons.check_circle_outline,
        color: Color(0xFFC7C7CA),
      );
    }

    return const Icon(
      Icons.check_circle_outline,
      color: Color(0xFFE3824D),
    );
  }

  Color getBackgroundColor() {
    if (points > 300) {
      return const Color(0xFFFEF8ED);
    }

    if (points >= 100 && points <= 300) {
      return const Color(0xFFFAFAFA);
    }

    return const Color(0xFFf4eae5);
  }

  @override
  Widget build(BuildContext context) {
    return ShimmerEffect(
      color: getBackgroundColor().darken(0.02),
      duration: const Duration(milliseconds: 2000),
      interval: const Duration(seconds: 5),
      enabled: achieved,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: getCheck(),
        trailing: Text("$points pt"),
        tileColor: getBackgroundColor(),
        contentPadding: const EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    );
  }
}
