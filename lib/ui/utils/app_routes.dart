import 'package:flutter/material.dart';
import 'package:movies/ui/screens/login/login_screen.dart';
import 'package:movies/ui/screens/navigation/navigation_screen.dart';
import 'package:movies/ui/screens/register/register_screen.dart';

abstract final class AppRoutes {
  static  MaterialPageRoute get loginScreen =>
      MaterialPageRoute(builder: (_) => LoginScreen());
  static MaterialPageRoute get registerScreen =>
      MaterialPageRoute(builder: (_) => RegisterScreen());static MaterialPageRoute get navigationScreen =>
      MaterialPageRoute(builder: (_) => NavigationScreen());
}
