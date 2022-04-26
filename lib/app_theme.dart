import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const _primaryColor = Color(0xFFC5FF29);

/// App theme
/// [AppTheme.light] for light theme
/// [AppTheme.dark] for dark theme
class AppTheme {
  /// Light [ThemeData]
  static ThemeData get light {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: _primaryColor,
        primary: _primaryColor,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(textTheme),
      // useMaterial3: true,
    );
  }

  /// Dark [ThemeData]
  static ThemeData get dark {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: _primaryColor,
          primary: _primaryColor,
          brightness: Brightness.dark),
      brightness: Brightness.dark,
      textTheme: GoogleFonts.poppinsTextTheme(textTheme),
      // useMaterial3: true,
    );
  }

  /// App [TextTheme]
  static const TextTheme textTheme = TextTheme(
    bodyText1: TextStyle(
      fontSize: 16,
      height: 1.5,
      fontWeight: FontWeight.w400,
    ),
    bodyText2: TextStyle(
      fontSize: 18,
      height: 1.5,
      fontWeight: FontWeight.w400,
    ),
    headline1: TextStyle(
      fontSize: 28,
      height: 1.5,
      fontWeight: FontWeight.w700,
    ),
    subtitle1: TextStyle(
      fontSize: 12,
      height: 1.5,
      fontWeight: FontWeight.w400,
    ),
  );
}
