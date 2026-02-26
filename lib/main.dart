import 'package:flutter/material.dart';
import 'package:movies/ui/screens/login/login_screen.dart';
import 'package:movies/ui/utils/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home:  LoginScreen(),
    );
  }
}

