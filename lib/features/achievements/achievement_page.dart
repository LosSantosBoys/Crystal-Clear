import 'package:crystalclear/features/achievements/enum/achievement_type.dart';
import 'package:crystalclear/features/achievements/widgets/achievement_listtile.dart';
import 'package:flutter/material.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        itemCount: 1,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return const AchievementListTile(
            title: "Praieiro",
            subtitle: "Colete entulho de 5 praias diferentes.",
            type: AchievementType.epic,
            achieved: true,
          );
        },
      ),
    );
  }
}
