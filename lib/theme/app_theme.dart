import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Central place for the app's [ThemeData]. Keeping theme
/// configuration separate from [MaterialApp] keeps `app.dart` small
/// and makes it easy to add dark mode / multiple themes later.
class AppTheme {
  AppTheme._();

  static ThemeData get light => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        fontFamily: 'Roboto',
      );
}
