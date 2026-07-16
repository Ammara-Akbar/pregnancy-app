import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/preferences/user_preferences.dart';
import 'core/theme/app_colors.dart';
import 'features/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const SehatMaaApp());
}

class SehatMaaApp extends StatelessWidget {
  const SehatMaaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: UserPreferences.instance,
      builder: (context, _) {
        return MaterialApp(
          title: 'Sehat Maa',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.magenta,
              primary: AppColors.burgundyDeep,
              secondary: AppColors.magenta,
              surface: AppColors.softPink,
            ),
            scaffoldBackgroundColor: AppColors.softPink,
            fontFamily: 'serif',
            textTheme: const TextTheme(
              displayLarge: TextStyle(
                fontFamily: 'serif',
                fontWeight: FontWeight.w700,
                color: AppColors.burgundy,
              ),
              headlineMedium: TextStyle(
                fontFamily: 'serif',
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
              bodyMedium: TextStyle(
                fontFamily: 'sans-serif',
                color: AppColors.textDark,
              ),
            ),
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
