import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_themes.dart';

class InitializationErrorApp extends StatelessWidget {
  const InitializationErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CBT Kanban',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.appTheme,
      home: Scaffold(
        body: Center(
          child: Text(
            'Something went wrong while starting the app.\nPlease restart.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.red, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
