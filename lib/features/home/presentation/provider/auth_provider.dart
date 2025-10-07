import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/router.dart';
import '../../../../core/util/custom_utils.dart';
import '../../../../injection_container.dart';
import '../../domain/usecases/log_out_user.dart';
import '../../domain/usecases/sign_up_user.dart';
import '../../domain/usecases/log_in_user.dart';
import 'auth_state.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final SignUpUser signUpUser;
  final LogInUser loginUser;
  final LogOutUser logOutUser;
  AuthStateNotifier({
    required this.signUpUser,
    required this.logOutUser,
    required this.loginUser,
  }) : super(const AuthState());

  void logIn({required String email, required String password}) async {
    state = state.copywith(status: ApiStatus.loading);
    final result = await loginUser.call(
      LoginUserParams(email: email, password: password),
    );
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(message: failure.message ?? "Failed to log in");
      },
      (response) {
        state = state.copywith(status: ApiStatus.success);
        userUID = response.user?.uid;
        Head.offAll(AppPages.home);
      },
    );
  }

  void signUp({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    state = state.copywith(status: ApiStatus.loading);
    final result = await signUpUser.call(
      SignUpUserParams(
        email: email,
        password: password,
        firstName: firstName,
        lastName: lastName,
      ),
    );
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(message: failure.message ?? "Failed to log in");
      },
      (response) {
        state = state.copywith(status: ApiStatus.success);
        userUID = response.user?.uid;
        Head.offAll(AppPages.home);
      },
    );
  }
}

final authProvider = StateNotifierProvider<AuthStateNotifier, AuthState>(
  (ref) => sl<AuthStateNotifier>(),
);
