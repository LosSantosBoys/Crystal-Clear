import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
        titleSpacing: 24,
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
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 73,
              width: 54,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.home),
                      Text("Home"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 73,
              width: 80,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.fitness_center),
                      Text("Desafios"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 40),
            SizedBox(
              height: 73,
              width: 80,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.forum),
                      Text("Feed"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 73,
              width: 54,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {},
                  child: const Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.menu),
                      Text("Mais"),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Wrap(
          runSpacing: 15,
          children: [
            Section(
              headerTitle: "Suas coletas",
              headerTrailing: TextButton(
                // todo: redirect to collection page
                onPressed: () {},
                child: const Text("ver mais"),
              ),
              child: StaggeredGrid.count(
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
                      child: const Column(
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
                            "12",
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
                            text: const TextSpan(
                              text: "6",
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
              ),
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
                  )),
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
