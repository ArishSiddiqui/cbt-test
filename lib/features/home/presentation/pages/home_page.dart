import 'package:cbt_test/core/constants/app_constants.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/router/router.dart';
import '../../../../core/util/custom_utils.dart';
import '../provider/auth_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    // Disposing controllers to free up resources and prevent memory leaks
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: buildBody());
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        constraints: BoxConstraints(minHeight: pendingScreenHeight!),
        // height: pendingScreenHeight,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: loginKey,
          child: Consumer(
            builder: (context, ref, _) {
              final notifier = ref.read(authProvider.notifier);
              final state = ref.watch(authProvider);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LogoWidget(size: screenHeight! * 0.1),
                  const SizedBox(height: 48.0),
                  const Text(
                    'Welocme back',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  const Text(
                    'Welocme back! Please enter your details.',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: AppColors.deepBlack,
                    ),
                  ),
                  const SizedBox(height: 48.0),
                  CustomTextField(
                    controller: emailController,
                    label: 'Email address',
                    hint: "Enter your email address",
                    validator: InputValidators.validateEmail,
                  ),
                  const SizedBox(height: 16.0),
                  CustomTextField(
                    controller: passwordController,
                    isPasswordField: true,
                    label: 'Password',
                    validator: InputValidators.validatePassword,
                  ),
                  const SizedBox(height: 32.0),
                  CustomButton(
                    disable: state.status == ApiStatus.loading,
                    name: 'Log in',
                    onTap: () {
                      if (loginKey.currentState!.validate()) {
                        notifier.logIn(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                      }
                      return;
                    },
                  ),
                  const SizedBox(height: 32.0),
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.deepBlack,
                        fontSize: 15.0,
                      ),
                      children: [
                        const TextSpan(text: 'Don\'t have an account? '),
                        TextSpan(
                          text: 'Sign up',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Head.to(AppPages.signUp);
                            },
                          style: const TextStyle(
                            color: AppColors.violet,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
