import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFC41E24); // Rojo FESC actualizado según la imagen
  static const Color textColor = Color(0xFF4A4A4A); // Color gris oscuro para texto
  static const Color backgroundColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    fontFamily: 'Roboto', // Asegúrate de incluir esta fuente en pubspec.yaml
    inputDecorationTheme: InputDecorationTheme(
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor.withOpacity(0.7), width: 1),
      ),
      labelStyle: TextStyle(color: textColor),
      hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(color: textColor),
      titleMedium: TextStyle(color: textColor, fontWeight: FontWeight.w500),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
        textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  );
}