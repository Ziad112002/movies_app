import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:movies/core/locale_cubit/local_cubit.dart';
import 'package:movies/core/utils/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movies/features/auth/ui/screens/login/login_screen.dart';
import 'core/di/di.dart';
import 'features/splash_onboarding/screens/onboarding_screen.dart';
import 'firebase_options.dart';
import 'l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  initDependencies();

  runApp(
      BlocProvider(
          create: (_) =>LocaleCubit() ,
          child: const MyApp()
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, Locale>(
      builder: (context, locale) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          locale: locale,
          theme: AppTheme.themeData,
          supportedLocales: const [Locale('en'), Locale('ar')],
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          home:  LoginScreen(),
        );
      },
    );
  }
}
