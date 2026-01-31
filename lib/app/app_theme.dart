import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // -------------------------
  // LIGHT THEME
  // -------------------------
  static ThemeData get lightTheme => ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,

    appBarTheme: AppBarTheme( // Removed 'const' because GoogleFonts isn't const
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      elevation: 0,
      scrolledUnderElevation: 0,
      // SAFER: Explicitly use GoogleFonts.sen
      titleTextStyle: GoogleFonts.sen(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: Colors.white,
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    filledButtonTheme: _filledButtonThemeData,
    inputDecorationTheme: _inputDecorationThemeData,
    // This line ensures 'Sen' is the default font for everything, including AppBar
    fontFamily: GoogleFonts.sen().fontFamily,
    textTheme: GoogleFonts.senTextTheme(_textTheme),
  );

  // -------------------------
  // DARK THEME
  // -------------------------
  static ThemeData get darkTheme => ThemeData(
    colorSchemeSeed: AppColors.themeColor,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),

    appBarTheme: AppBarTheme( // Removed 'const'
      backgroundColor: const Color(0xFF121212),
      foregroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      // SAFER: Explicitly use GoogleFonts.sen
      titleTextStyle: GoogleFonts.sen(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),

    cardTheme: CardThemeData(
      color: const Color(0xFF1E1E1E),
      surfaceTintColor: Colors.transparent,
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),

    inputDecorationTheme: _inputDecorationThemeData.copyWith(
      fillColor: const Color(0xFF2C2C2C),
      filled: true,
      hintStyle: TextStyle(color: Colors.grey[400]),
      enabledBorder: const OutlineInputBorder(borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.themeColor),
      ),
    ),

    filledButtonTheme: _filledButtonThemeData,
    // This ensures body text is white, but AppBar uses the titleTextStyle above
    textTheme: GoogleFonts.senTextTheme(_textTheme).apply(
      bodyColor: Colors.white,
      displayColor: Colors.white,
    ),
    fontFamily: GoogleFonts.sen().fontFamily,
  );

  // -------------------------
  // SHARED STYLES
  // -------------------------
  static FilledButtonThemeData get _filledButtonThemeData =>
      FilledButtonThemeData(
        style: FilledButton.styleFrom(
          fixedSize: const Size.fromWidth(double.maxFinite),
          backgroundColor: AppColors.themeColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          textStyle: GoogleFonts.sen(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      );

  static InputDecorationTheme get _inputDecorationThemeData =>
      InputDecorationTheme(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 16,
        ),
        hintStyle: TextStyle(fontSize: 14, color: Colors.grey[500]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.themeColor, width: 1.5),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
      );

  static TextTheme get _textTheme => const TextTheme(
    titleLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
  );
}