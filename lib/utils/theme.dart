import 'package:flutter/material.dart';

final appThemeData = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: const Color(0xFF140F1F),
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFFFFEB3B),
    brightness: Brightness.dark,
  ).copyWith(surface: const Color(0xFF2A2A2E)),
  cardTheme: CardTheme(
    color: const Color(0xFF2A2A2E),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
    ),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF121212),
    elevation: 0,
  ),
  fontFamily: 'Cormorant',
  textTheme: const TextTheme(
    headlineLarge: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.bold),
    titleLarge: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.w600),
    titleMedium: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.w600),
    titleSmall: TextStyle(fontFamily: 'Cinzel', fontWeight: FontWeight.w400),
  ),
);
