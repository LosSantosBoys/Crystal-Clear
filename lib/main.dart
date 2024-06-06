import 'package:crystalclear/core/services/auth_service.dart';
import 'package:crystalclear/features/more/settings_page.dart';
import 'package:crystalclear/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:crystalclear/features/auth/pages/forgot_password_page.dart';
import 'package:crystalclear/features/auth/pages/login_basic_page.dart';
import 'package:crystalclear/features/auth/pages/login_screen.dart';
import 'package:crystalclear/features/auth/pages/sign_up_page.dart';
import 'package:crystalclear/features/home/pages/collection_page.dart';
import 'package:crystalclear/features/home/pages/home_page.dart';
import 'package:crystalclear/features/home/pages/leaderboard_page.dart';
import 'package:crystalclear/features/home/pages/map_page.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        primaryColor: const Color(0xFF386BF6),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
          titleSpacing: 24,
        ),
        textTheme: GoogleFonts.interTextTheme(
          Theme.of(context).textTheme,
        ),
        fontFamily: GoogleFonts.inter().fontFamily,
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
        '/': (context) => FutureBuilder<bool>(
              future: AuthService().isAuthenticated(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return snapshot.data! ? const HomePage() : LoginScreen();
                  default:
                    return const Scaffold(
                      body: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                }
              },
            ),
        '/login': (context) => LoginScreen(),
        '/login/basic': (context) => const LoginBasicPage(),
        '/signup': (context) => const SignUpPage(),
        '/forgot-password': (context) => ForgotPasswordPage(),
        '/home': (context) => const HomePage(),
        '/collections': (context) => const CollectionsPage(),
        '/map': (context) => const MapPage(),
        '/leaderboard': (context) => const LeaderboardPage(),
        '/settings': (context) => const SettingsPage(),
      },
      initialRoute: '/',
    );
  }
}
