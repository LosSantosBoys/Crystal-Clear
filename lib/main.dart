import 'package:flutter/material.dart';
import 'package:project/features/auth/pages/login_screen.dart';
import 'package:project/features/auth/pages/sign_up_screen.dart';
import 'package:project/features/home/pages/collection_page.dart';
import 'package:project/features/home/pages/home_page.dart';
import 'package:project/features/home/pages/leaderboard_page.dart';
import 'package:project/features/home/pages/map_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
          titleSpacing: 24,
        ),
        snackBarTheme: const SnackBarThemeData(
          backgroundColor: Colors.white,
          contentTextStyle: TextStyle(color: Colors.black),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomePage(),
        '/collections': (context) => const CollectionsPage(),
        '/map': (context) => const MapPage(),
        '/leaderboard': (context) => const LeaderboardPage(),
      },
      initialRoute: '/home',
    );
  }
}
