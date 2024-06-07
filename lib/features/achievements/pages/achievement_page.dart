import 'dart:math';

import 'package:crystalclear/features/achievements/enum/achievement_type.dart';
import 'package:crystalclear/features/achievements/models/achievement.dart';
import 'package:crystalclear/features/achievements/widgets/achievement_listtile.dart';
import 'package:flutter/material.dart';

class AchievementPage extends StatefulWidget {
  const AchievementPage({super.key});

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  List<Achievement> achievements = [];

  void generateRandomAchievements() {
    // Generate random achievements
    for (int i = 0; i < 6; i++) {
      AchievementType type = AchievementType.values[Random().nextInt(AchievementType.values.length)];
      String title = generateRandomTitle();
      String subtitle = generateRandomSubtitle();
      bool achieved = Random().nextBool();

      Achievement achievement = Achievement(
        title: title,
        subtitle: subtitle,
        type: type,
        achieved: achieved,
      );

      achievements.add(achievement);
    }

    achievements.sort((a, b) => a.achieved ? -1 : 1);
  }

  String generateRandomTitle() {
    List<String> titles = [
      "Praieiro",
      "Aprendiz de Limpeza",
      "Tudo no seu devido lugar",
      "Procurando Nemo",
      "Coletor",
      "Aventureiro",
      "Lenda",
      "Herói",
    ];

    return titles[Random().nextInt(titles.length)];
  }

  String generateRandomSubtitle() {
    List<String> subtitles = [
      "Colete entulho de 5 praias diferentes.",
      "Descubra todos os segredos do mapa.",
      "Vença 10 partidas consecutivas.",
      "Alcance o nível máximo em todas as habilidades.",
      "Colete todos os itens raros.",
      "Explore todas as regiões do Brasil.",
      "Se torne uma lenda viva.",
      "Salve o mundo de uma grande ameaça.",
    ];

    return subtitles[Random().nextInt(subtitles.length)];
  }

  @override
  void initState() {
    super.initState();

    generateRandomAchievements();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: ListView.builder(
        itemCount: achievements.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return AchievementListTile(
            title: achievements.elementAt(index).title,
            subtitle: achievements.elementAt(index).subtitle,
            type: achievements.elementAt(index).type,
            achieved: achievements.elementAt(index).achieved,
          );
        },
      ),
    );
  }
}
