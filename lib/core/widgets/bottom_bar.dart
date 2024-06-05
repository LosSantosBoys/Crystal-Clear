import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key, required this.scaffoldKey});

  final GlobalKey<ScaffoldState> scaffoldKey;

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
                onTap: () => scaffoldKey.currentState!.openEndDrawer(),
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
    );
  }
}
