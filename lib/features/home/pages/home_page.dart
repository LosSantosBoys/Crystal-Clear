import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project/core/widgets/bottom_bar.dart';
import 'package:project/core/widgets/more_drawer.dart';
import 'package:project/features/home/widgets/collection_grid.dart';
import 'package:project/core/widgets/section_widget.dart';
import 'package:project/features/home/widgets/rank_listtile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

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
      bottomNavigationBar: BottomBar(
        scaffoldKey: scaffoldKey,
      ),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: const MoreDrawer(),
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
