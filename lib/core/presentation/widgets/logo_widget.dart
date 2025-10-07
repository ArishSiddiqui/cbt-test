import 'package:cbt_test/core/constants/app_constants.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class LogoWidget extends StatelessWidget {
  final double? size;
  const LogoWidget({this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: AppColors.greyLight,
              offset: Offset(0, 2),
              blurRadius: 8.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        height: size ?? screenHeight! * 0.15,
        width: size ?? screenHeight! * 0.15,
        child: FittedBox(
          child: Text(
            "CB",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: AppColors.deepBlack,
            ),
          ),
        ),
      ),
    );
  }
}
