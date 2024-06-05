import 'package:flutter/material.dart';
import 'package:crystalclear/features/home/widgets/collection_grid.dart';
import 'package:crystalclear/core/widgets/section_widget.dart';

class CollectionsPage extends StatelessWidget {
  const CollectionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Suas coletas"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Wrap(
          runSpacing: 15,
          children: [
            const Section(
              headerTitle: "Suas coletas",
              child: CollectionGrid(),
            ),
            Section(
              headerTitle: "Últimas coletas realizadas",
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: 4,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        minVerticalPadding: 0,
                        leading: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              constraints: const BoxConstraints(
                                minWidth: 44,
                                minHeight: 44,
                                maxWidth: 55,
                                maxHeight: 55,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                image: const DecorationImage(
                                  image: NetworkImage("https://xsgames.co/randomusers/avatar.php?g=male"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        title: const Text(
                          "Metal e plástico",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        subtitle: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "12:00 - segunda-feira, 03.06.24",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              "Praia das Palmeiras",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        isThreeLine: false,
                        trailing: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                        // todo: add collection details page
                        onTap: () {},
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
