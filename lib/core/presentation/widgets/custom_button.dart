import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final VoidCallback? onTap;
  final bool disable;

  const CustomButton({
    super.key,
    required this.name,
    this.onTap,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: disable ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 60.0,
        padding: const EdgeInsets.symmetric(vertical: 13),
        decoration: BoxDecoration(
          color: disable ? AppColors.greyLight : null,
          gradient: disable
              ? null
              : const LinearGradient(
                  colors: [AppColors.violet, AppColors.indigo],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            name,
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
              color: disable ? AppColors.grey : AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
