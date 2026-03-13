import 'package:flutter/material.dart';
import 'package:movies/features/auth/ui/screens/forget_password/forget_password_screen.dart';
import 'package:movies/features/auth/ui/screens/login/login_screen.dart';
import 'package:movies/features/movie_details/ui/screens/movie_details_screen.dart';
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
  static MaterialPageRoute  movieDetailsScreen(int id) =>
      MaterialPageRoute(builder: (_) => MovieDetailsScreen(movieId: id,));
  static MaterialPageRoute get profileDetailsScreen =>
      MaterialPageRoute(builder: (_) => ProfileDetailsScreen());static MaterialPageRoute get forgetPasswordScreen =>
      MaterialPageRoute(builder: (_) => ForgetPasswordScreen());
}
