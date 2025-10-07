import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/router/router.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/util/custom_utils.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/get_user_logged_in_status.dart';

class SplashStateNotifier extends StateNotifier<void> {
  final GetUserLoggedInStatus getUserLoggedInStatus;
  SplashStateNotifier({required this.getUserLoggedInStatus}) : super(null);

  void goToNextPage() async {
    await Future.delayed(const Duration(seconds: 2));
    final loggedInOrNot = await getUserLoggedInStatus.call(NoParams());
    loggedInOrNot.fold(
      (failure) {
        showCustomSnackBar(
          message: failure.message ?? "Failed to check logged in status",
        );
      },
      (response) {
        if (response) {
          return Head.offAll(AppPages.login);
        } else {
          return Head.offAll(AppPages.login);
        }
      },
    );
  }
}

final splashProvider = StateNotifierProvider<SplashStateNotifier, void>(
  (ref) => sl<SplashStateNotifier>(),
);
