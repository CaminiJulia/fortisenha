import 'package:flutter/material.dart';

const Color kFortiBlack  = Color(0xFF0B0B0D);
const Color kFortiBlue   = Color(0xFF0D2C54);
const Color kFortiYellow = Color(0xFFF9D342);
const Color kSurface     = Color(0xFF121318);

ThemeData buildFortiTheme() {
  final base = ThemeData(brightness: Brightness.dark, useMaterial3: true);

  final scheme = ColorScheme.fromSeed(
    seedColor: kFortiBlue,
    brightness: Brightness.dark,
    primary: kFortiBlue,
    secondary: kFortiYellow,
    surface: kSurface,
  ).copyWith(
    surface: kFortiBlack, // se sua SDK não aceitar, remova esta linha
  );

  return base.copyWith(
    colorScheme: scheme,
    scaffoldBackgroundColor: kFortiBlack,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: kFortiBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: kFortiYellow),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kSurface,
      labelStyle: const TextStyle(color: Colors.white70),
      hintStyle: const TextStyle(color: Colors.white38),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
    ),
    
  );
}
