
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const ApnaCodeApp());
}

class ApnaCodeApp extends StatelessWidget {
  const ApnaCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF1565C0);

    return MaterialApp(
      title: 'ApnaCode',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryBlue,
        ).copyWith(primary: primaryBlue),
        scaffoldBackgroundColor: Colors.white,

        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.blue.shade50,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: primaryBlue,
              width: 1.5,
            ),
          ),
        ),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryBlue,
            foregroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 52),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}