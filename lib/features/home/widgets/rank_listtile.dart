import 'package:flutter/material.dart';

class RankListTile extends StatelessWidget {
  const RankListTile({
    super.key,
    required this.name,
    required this.points,
    required this.position,
    this.avatar,
  });

  final String name;
  final int points;
  final int position;
  final String? avatar;

  Widget getPosition() {
    switch (position) {
      case 1:
        return const Icon(
          Icons.workspace_premium_outlined,
          color: Color(0xFFFFC700),
        );
      case 2:
        return const Icon(
          Icons.workspace_premium_outlined,
          color: Color(0xFFC7C7CA),
        );
      case 3:
        return const Icon(
          Icons.workspace_premium_outlined,
          color: Color(0xFFE3824D),
        );
      default:
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Text(
            "$position",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        );
    }
  }

  Color getPositionColor() {
    switch (position) {
      case 1:
        return const Color(0xFFFEF8ED);
      case 2:
        return const Color(0xFFFAFAFA);
      case 3:
        return const Color(0xFFf4eae5);
      default:
        return Colors.transparent;
    }
  }

  Widget getAvatar() {
    if (avatar != null) {
      return Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: NetworkImage(avatar!),
          ),
        ),
      );
    }

    String initials = name.split(" ").map((e) => e[0]).join();

    return Container(
      width: 36,
      height: 36,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(6), color: getRandomColor()),
      child: Center(
        child: Text(
          initials,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Color getRandomColor() {
    final colors = [
      Colors.red,
      Colors.blue,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.pink,
      Colors.teal,
      Colors.amber,
      Colors.cyan,
      Colors.lime,
      Colors.indigo,
      Colors.brown,
    ];

    return colors[points % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          getAvatar(),
          const SizedBox(width: 10),
          Text(name),
        ],
      ),
      leading: getPosition(),
      trailing: Text("$points pts"),
      tileColor: getPositionColor(),
      contentPadding: const EdgeInsets.all(5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
