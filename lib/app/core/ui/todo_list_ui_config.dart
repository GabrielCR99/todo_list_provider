import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  useMaterial3: true,
  primaryColor: const Color(0xFF5C77CE),
  primaryColorLight: const Color(0xFFABC8F7),
  textTheme: GoogleFonts.mandaliTextTheme(),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF5C77CE)),
  ),
);
