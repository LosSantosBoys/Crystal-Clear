import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:project/core/widgets/section_widget.dart';
import 'package:project/features/home/widgets/rank_listtile.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Placar de Líderes"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Section(
              headerTitle: "Placar de Líderes",
              headerTrailing: DropdownButtonHideUnderline(
                child: DropdownButton2(
                  enableFeedback: true,
                  value: "daily",
                  onChanged: (value) {},
                  buttonStyleData: ButtonStyleData(
                    elevation: 0,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFAFAFA),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  dropdownStyleData: const DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Color(0xFFFAFAFA),
                    ),
                    elevation: 0,
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: "daily",
                      child: Text("Diário"),
                    ),
                    DropdownMenuItem(
                      value: "weekly",
                      child: Text("Semanal"),
                    ),
                    DropdownMenuItem(
                      value: "monthly",
                      child: Text("Mensal"),
                    ),
                  ],
                ),
              ),
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
                    name: "Nome Sobrenome",
                    points: 700,
                    position: 4,
                  ),
                  RankListTile(
                    name: "Nome Sobrenome",
                    points: 650,
                    position: 5,
                  ),
                  RankListTile(
                    name: "Nome Sobrenome",
                    points: 550,
                    position: 6,
                  ),
                  RankListTile(
                    name: "Nome Sobrenome",
                    points: 500,
                    position: 7,
                  ),
                  RankListTile(
                    name: "Você",
                    points: 400,
                    position: 8,
                  ),
                  RankListTile(
                    name: "Nome Sobrenome",
                    points: 300,
                    position: 9,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
