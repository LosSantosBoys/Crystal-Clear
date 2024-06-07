import 'package:crystalclear/core/services/auth_service.dart';
import 'package:crystalclear/core/widgets/avatar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:crystalclear/core/widgets/bottom_bar.dart';
import 'package:crystalclear/features/more/more_page.dart';
import 'package:crystalclear/features/home/widgets/collection_grid.dart';
import 'package:crystalclear/core/widgets/section_widget.dart';
import 'package:crystalclear/features/home/widgets/rank_listtile.dart';

import 'report_trash_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState() {
    super.initState();
    askForLocationPermission();
  }

  void askForLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      await Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
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
                    child: Avatar(
                      name: AuthService().getUser()?.displayName ?? "Usuário",
                      photoURL: AuthService().getUser()?.photoURL,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(
        scaffoldKey: scaffoldKey,
        pageController: pageController,
      ),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const MoreDrawer(),
      body: PageView(
        controller: pageController,
        onPageChanged: (int index) {},
        children: [
          SingleChildScrollView(
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
                    child: SizedBox(
                      width: double.infinity,
                      height: 312,
                      child: GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: const CameraPosition(
                          target: LatLng(-23.5505, -46.6333),
                          zoom: 11,
                        ),
                        zoomGesturesEnabled: false,
                        zoomControlsEnabled: false,
                        onTap: (_) => Navigator.pushNamed(context, '/map'),
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
          SingleChildScrollView(
            child: Column(),
          ),
        ],
      ),
      floatingActionButton: SizedBox.square(
        dimension: 58,
        child: FittedBox(
          child: FloatingActionButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ReportTrashPage()),
            ),
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
