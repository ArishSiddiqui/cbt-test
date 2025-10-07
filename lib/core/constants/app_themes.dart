import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppThemes {
  static ThemeData appTheme = ThemeData(
    fontFamily: AppFonts.montserrat,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.deepBlack),
    useMaterial3: true,
  );
}
