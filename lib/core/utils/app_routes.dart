import 'package:flutter/material.dart';
import 'package:movies/features/auth/ui/screens/login/login_screen.dart';
import 'package:movies/features/navigation/ui/screens/tabs/home/movie_details/movie_details_screen.dart';
import 'package:movies/features/navigation/ui/screens/navigation_screen.dart';
import 'package:movies/features/auth/ui/screens/register/register_screen.dart';
import 'package:movies/features/navigation/ui/screens/tabs/profile_details/profile_details_screen.dart';

abstract final class AppRoutes {
  static MaterialPageRoute get loginScreen =>
      MaterialPageRoute(builder: (_) => LoginScreen());
  static MaterialPageRoute get registerScreen =>
      MaterialPageRoute(builder: (_) => RegisterScreen());
  static MaterialPageRoute get navigationScreen =>
      MaterialPageRoute(builder: (_) => NavigationScreen());
  static MaterialPageRoute get movieDetailsScreen =>
      MaterialPageRoute(builder: (_) => MovieDetailsScreen());
  static MaterialPageRoute get profileDetailsScreen =>
      MaterialPageRoute(builder: (_) => ProfileDetailsScreen());
}
