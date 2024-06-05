import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CollectionGrid extends StatelessWidget {
  const CollectionGrid({
    super.key,
    this.plasticCollections = 12,
    this.metalCollections = 4,
    this.glassCollections = 3,
  });

  final double? plasticCollections;
  final double? metalCollections;
  final double? glassCollections;

  @override
  Widget build(BuildContext context) {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2.4,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_drink_outlined,
                      size: 28,
                      color: Color(0xff699BF7),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Plástico",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                // todo: change the number of plastic collections
                Text(
                  "${plasticCollections ?? 0}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                Text(
                  "vezes",
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 16,
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1.2,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.iron,
                      size: 24,
                      color: Color(0xff545454),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Metal",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // todo: change the number of metal collections
                RichText(
                  text: TextSpan(
                    text: "${metalCollections ?? 0}",
                    children: [
                      TextSpan(
                        text: " vezes",
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                    ],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 1.2,
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.local_bar_outlined,
                      size: 24,
                      color: Color(0xffFF9A62),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Vidro",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // todo: change the number of glass collections
                RichText(
                  text: const TextSpan(
                    text: "4",
                    children: [
                      TextSpan(
                        text: " vezes",
                        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 14),
                      ),
                    ],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
