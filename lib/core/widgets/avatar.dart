import 'package:cached_network_image/cached_network_image.dart';
import 'package:crystalclear/core/utils/utils.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.name, this.photoURL});

  final String name;
  final String? photoURL;

  @override
  Widget build(BuildContext context) {
    if (photoURL != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: CachedNetworkImage(
          imageUrl: photoURL!,
          fit: BoxFit.cover,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: generateRandomColor(),
      ),
      child: Center(
        child: Text(
          name.split(" ").map((e) => e[0]).join(),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
