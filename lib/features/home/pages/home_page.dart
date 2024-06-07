import 'package:crystalclear/core/services/auth_service.dart';
import 'package:crystalclear/core/widgets/avatar.dart';
import 'package:crystalclear/features/achievements/achievement_page.dart';
import 'package:crystalclear/features/home/pages/home_inner_page.dart';
import 'package:crystalclear/features/home/widgets/sample_map.dart';
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
  int index = 0;

  @override
  void initState() {
    super.initState();
    askForLocationPermission();

    pageController.addListener(() {
      setState(() {
        index = pageController.page!.round();
      });
    });
  }

  void askForLocationPermission() async {
    PermissionStatus status = await Permission.location.status;

    if (status.isDenied) {
      await Permission.location.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }

  String getAppbarTitle() {
    switch (index) {
      case 0:
        return "Crystal Clear";
      case 1:
        return "Conquistas";
      case 2:
        return "Feed";
      default:
        return "Crystal Clear";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(
          getAppbarTitle(),
          style: const TextStyle(
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
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeInnerPage(),
          AchievementPage(),
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
