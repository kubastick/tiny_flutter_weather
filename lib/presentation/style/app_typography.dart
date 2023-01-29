import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/presentation/style/app_colors.dart';

class AppTypography {
  AppTypography({
    required this.colors,
  });

  final AppThemeColors colors;

  TextStyle h1 = GoogleFonts.poppins(
    fontSize: 77,
  );

  TextStyle h2 = GoogleFonts.poppins(
    fontSize: 20,
  );

  TextStyle h3 = GoogleFonts.poppins(
    fontSize: 16,
  );

  TextStyle body = GoogleFonts.poppins(
    fontSize: 12,
  );
}
