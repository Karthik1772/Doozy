import 'package:Doozy/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static _borderTheme([Color borderColor = Colors.grey, double width = 1]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: borderColor, width: width),
      );

  static final ThemeData lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: AppBarTheme(
      //__________________________________________________________APP_BAR
      backgroundColor: AppColors.orange,
      iconTheme: IconThemeData(color: AppColors.white),
      actionsIconTheme: IconThemeData(color: AppColors.white),
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        color: AppColors.white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      //_____________________________________TEXT_FIELD
      suffixIconColor: AppColors.orange,
      prefixIconColor: AppColors.orange,
      errorBorder: _borderTheme(AppColors.red, 2),
      focusedBorder: _borderTheme(AppColors.orange, 2),
      enabledBorder: _borderTheme(),
      disabledBorder: _borderTheme(),
      border: _borderTheme(),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: const WidgetStatePropertyAll(AppColors.orange),
      ),
    ),
  );
}
