import 'package:flutter/material.dart';
import 'package:project/core/widgets/bottom_bar.dart';
import 'package:project/features/home/widgets/collection_grid.dart';
import 'package:project/core/widgets/section_widget.dart';
import 'package:project/features/home/widgets/rank_listtile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Crystal Clear",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: SizedBox(
              width: 48,
              height: 48,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    // todo: redirect to profile page
                    onTap: () {},
                    // todo: change the image URL
                    child: const CircleAvatar(
                      backgroundImage: NetworkImage("https://xsgames.co/randomusers/avatar.php?g=male"),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const BottomBar(),
      body: SingleChildScrollView(
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
                child: Container(
                  width: double.infinity,
                  height: 312,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      // todo: change to working map
                      image: NetworkImage("https://www.cnnbrasil.com.br/wp-content/uploads/sites/12/2024/02/google-maps-e1707316052388.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
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
      ),
      floatingActionButton: SizedBox.square(
        dimension: 58,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () {},
            elevation: 0,
            tooltip: "Sinalizar entulho",
            backgroundColor: const Color(0xFF386BF6),
            shape: RoundedRectangleBorder(
              side: const BorderSide(color: Color(0xFFA9C0FF), width: 6, strokeAlign: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Icon(
              Icons.camera_alt_outlined,
              color: Colors.white,
              size: 28,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
