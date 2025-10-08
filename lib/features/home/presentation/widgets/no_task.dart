import 'package:cbt_test/core/constants/app_colors.dart';
import 'package:flutter/widgets.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/router/router.dart';

class NoTask extends StatelessWidget {
  const NoTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.noTask),
          const SizedBox(height: 20.0),
          Text(
            "No Tasks.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w800,
              color: AppColors.deepBlack,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            "You have no tasks in your list. Add new tasks to stay organized and productive",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
            ),
          ),
          const SizedBox(height: 40.0),
          CustomButton(
            name: "Add Task",
            onTap: () => Head.to(AppPages.taskDetail),
          ),
        ],
      ),
    );
  }
}
