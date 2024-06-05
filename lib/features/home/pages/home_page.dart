import 'package:flutter/material.dart';
import 'package:project/core/widgets/bottom_bar.dart';
import 'package:project/core/widgets/collection_grid.dart';
import 'package:project/core/widgets/section_widget.dart';

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
                onPressed: () {},
                child: const Text("ver mais"),
              ),
              child: SizedBox(
                height: 270,
                child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  children: [
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: const DecorationImage(
                                image: NetworkImage("https://xsgames.co/randomusers/avatar.php?g=male"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Nome Sobrenome"),
                        ],
                      ),
                      leading: const Icon(
                        Icons.workspace_premium_outlined,
                        color: Color(0xFFFFC700),
                      ),
                      trailing: const Text("1000 pts"),
                      tileColor: const Color(0xFFFEF8ED),
                      contentPadding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: const DecorationImage(
                                image: NetworkImage("https://xsgames.co/randomusers/avatar.php?g=male"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Nome Sobrenome"),
                        ],
                      ),
                      leading: const Icon(
                        Icons.workspace_premium_outlined,
                        color: Color(0xFFC7C7CA),
                      ),
                      trailing: const Text("800 pts"),
                      tileColor: const Color(0xFFFAFAFA),
                      contentPadding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: const DecorationImage(
                                image: NetworkImage("https://xsgames.co/randomusers/avatar.php?g=male"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Nome Sobrenome"),
                        ],
                      ),
                      leading: const Icon(
                        Icons.workspace_premium_outlined,
                        color: Color(0xFFE3824D),
                      ),
                      trailing: const Text("700 pts"),
                      tileColor: const Color(0xFFf4eae5),
                      contentPadding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 5),
                    ListTile(
                      title: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6),
                              image: const DecorationImage(
                                image: NetworkImage("https://xsgames.co/randomusers/avatar.php?g=male"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text("Você"),
                        ],
                      ),
                      leading: const Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "8",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      trailing: const Text("400 pts"),
                      tileColor: const Color(0xFFe3e8f6),
                      contentPadding: const EdgeInsets.all(5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
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
