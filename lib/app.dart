import 'package:flutter/material.dart';
import 'package:prayer_time/ui/screen/splash_screen.dart';
import 'package:prayer_time/ui/utility/app_colors.dart';

class PrayerTimeApp extends StatelessWidget {
  const PrayerTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: _buildLightThemeData(),
    );
  }

  ThemeData _buildLightThemeData() => ThemeData(
    textTheme: TextTheme(
      titleMedium: TextStyle(
        color: AppColors.textColor,
        fontSize: 20
      ),
      titleLarge: TextStyle(
        color: AppColors.textColor,
        fontSize: 32,
        fontWeight: FontWeight.bold
      ),
      titleSmall: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.bold,
        fontSize: 16
      )
    )
  );





}
