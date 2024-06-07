import 'package:crystalclear/core/widgets/section_widget.dart';
import 'package:crystalclear/features/home/widgets/challenge_listtile.dart';
import 'package:crystalclear/features/home/widgets/collection_grid.dart';
import 'package:crystalclear/features/home/widgets/rank_listtile.dart';
import 'package:crystalclear/features/home/widgets/sample_map.dart';
import 'package:flutter/material.dart';

class HomeInnerPage extends StatefulWidget {
  const HomeInnerPage({super.key});

  @override
  State<HomeInnerPage> createState() => _HomeInnerPageState();
}

class _HomeInnerPageState extends State<HomeInnerPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Wrap(
        runSpacing: 15,
        children: [
          Section(
            headerTitle: "Suas coletas",
            headerTrailing: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/collections'),
              child: const Text("ver mais"),
            ),
            child: const CollectionGrid(),
          ),
          Section(
            headerTitle: "Encontre entulhos próximos",
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: const SizedBox(
                width: double.infinity,
                height: 312,
                child: SampleMap(),
              ),
            ),
          ),
          const Section(
            headerTitle: "Desafios de hoje",
            child: Wrap(
              runSpacing: 5,
              children: [
                ChallengeListTile(
                  title: "Coletador de Entulho 1",
                  subtitle: "Coletar 10 garrafas de plástico",
                  points: 100,
                  achieved: true,
                ),
                ChallengeListTile(
                  title: "Coletador de Entulho 2",
                  subtitle: "Coletar 5 garrafas de vidro",
                  points: 300,
                  achieved: true,
                ),
                ChallengeListTile(
                  title: "Coletador de Entulho 3",
                  subtitle: "Coletar 30 garrafas de plástico",
                  points: 600,
                  achieved: true,
                ),
                ChallengeListTile(
                  title: "Coletador de Entulho 4",
                  subtitle: "Coletar 100 garrafas de plástico",
                  points: 1000,
                ),
              ],
            ),
          ),
          Section(
            headerTitle: "Placar de Líderes",
            headerTrailing: TextButton(
              onPressed: () => Navigator.pushNamed(context, '/leaderboard'),
              child: const Text("ver mais"),
            ),
            child: SizedBox(
              height: 270,
              child: ListView(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: const [
                  RankListTile(
                    name: "Nome Sobrenome",
                    points: 1000,
                    position: 1,
                  ),
                  RankListTile(
                    name: "Nome Sobrenome",
                    points: 900,
                    position: 2,
                  ),
                  RankListTile(
                    name: "Nome Sobrenome",
                    points: 800,
                    position: 3,
                  ),
                  RankListTile(
                    name: "Você",
                    points: 600,
                    position: 8,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
