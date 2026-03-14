import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies/features/auth/ui/screens/forget_password/forget_password_screen.dart';
import 'package:movies/features/auth/ui/screens/login/login_screen.dart';
import 'package:movies/features/splash_onboarding/screens/onboarding_screen.dart';
import 'core/di/di.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: LoginScreen(),
    );
  }
}

