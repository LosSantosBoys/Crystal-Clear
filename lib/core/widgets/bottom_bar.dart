import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    super.key,
    required this.scaffoldKey,
    required this.pageController,
  });

  final GlobalKey<ScaffoldState> scaffoldKey;
  final PageController pageController;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int index = 0;

  @override
  void initState() {
    super.initState();
    widget.pageController.addListener(() {
      setState(() {
        index = widget.pageController.page!.round();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
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
                onTap: () {
                  widget.pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      color: index == 0 ? const Color(0xFF386BF6) : const Color(0xFF9DB2CE),
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                        color: index == 0 ? const Color(0xFF386BF6) : const Color(0xFF9DB2CE),
                      ),
                    ),
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
                onTap: () {
                  widget.pageController.animateToPage(
                    1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.fitness_center,
                      color: index == 1 ? const Color(0xFF386BF6) : const Color(0xFF9DB2CE),
                    ),
                    Text(
                      "Conquistas",
                      style: TextStyle(
                        color: index == 1 ? const Color(0xFF386BF6) : const Color(0xFF9DB2CE),
                      ),
                    ),
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
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.forum,
                      color: index == 2 ? const Color(0xFF386BF6) : const Color(0xFF9DB2CE),
                    ),
                    Text(
                      "Feed",
                      style: TextStyle(
                        color: index == 2 ? const Color(0xFF386BF6) : const Color(0xFF9DB2CE),
                      ),
                    ),
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
                onTap: () => widget.scaffoldKey.currentState!.openEndDrawer(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.menu,
                      color: index == 3 ? const Color(0xFF386BF6) : const Color(0xFF9DB2CE),
                    ),
                    Text(
                      "Mais",
                      style: TextStyle(
                        color: index == 3 ? const Color(0xFF386BF6) : const Color(0xFF9DB2CE),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
