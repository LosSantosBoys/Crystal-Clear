import 'package:flutter/material.dart';
import 'package:project/features/auth/pages/forgot_password_page.dart';
import 'package:project/features/auth/pages/login_basic_page.dart';
import 'package:project/features/auth/pages/login_screen.dart';
import 'package:project/features/auth/pages/sign_up_page.dart';
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
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0xFFFAFAFA),
          filled: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0XFF8395d6),
              width: 2,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0XFFFFADB9),
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0xFFC7C7CA),
            ),
          ),
          errorStyle: const TextStyle(
            color: Color(0XFFE30000),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color(0XFFE30000),
            ),
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/login/basic': (context) => const LoginBasicPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
        '/collections': (context) => const CollectionsPage(),
        '/map': (context) => const MapPage(),
        '/leaderboard': (context) => const LeaderboardPage(),
      },
      initialRoute: '/login',
    );
  }
}
