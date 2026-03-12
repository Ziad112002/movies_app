import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies/features/movie_details/ui/screens/movie_details_screen.dart';
import 'package:movies/features/navigation/ui/screens/navigation_screen.dart';
import 'core/di/di.dart';
import 'firebase_options.dart';

void main() async{
  initDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      home: NavigationScreen(),
    );
  }
}

