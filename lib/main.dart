import 'package:flutter/material.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const ApnaCodeApp());
}

class ApnaCodeApp extends StatelessWidget {
  const ApnaCodeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ApnaCode',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1565C0)),
      ),
      home: const HomeScreen(),
    );
  }
}