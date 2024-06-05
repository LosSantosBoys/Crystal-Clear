import 'package:flutter/material.dart';
import 'package:project/core/widgets/section_widget.dart';

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
              headerTrailing: DropdownButton(
                items: [
                  DropdownMenuItem(
                    child: Text("Diário"),
                    value: "daily",
                  ),
                  DropdownMenuItem(
                    child: Text("Semanal"),
                    value: "weekly",
                  ),
                  DropdownMenuItem(
                    child: Text("Mensal"),
                    value: "monthly",
                  ),
                ],
                onChanged: (value) {},
              ),
              child: ListView(
                shrinkWrap: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
