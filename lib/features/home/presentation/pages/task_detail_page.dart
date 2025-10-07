import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/router/router.dart';
import '../../../../core/util/custom_utils.dart';
import '../provider/auth_provider.dart';

class TaskDetailPage extends StatefulWidget {
  const TaskDetailPage({super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    // Disposing controllers to free up resources and prevent memory leaks
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          constraints: BoxConstraints(minHeight: pendingScreenHeight!),
          height: screenHeight,
          padding: const EdgeInsets.all(16.0),
          child: Consumer(
            builder: (context, ref, _) {
              final state = ref.watch(authProvider);
              final notifier = ref.read(authProvider.notifier);
              return Form(
                key: signUpKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoWidget(size: screenHeight! * 0.1),
                    const SizedBox(height: 36.0),
                    const Text(
                      'Create an account',
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w600,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 36.0),
                    CustomTextField(
                      controller: firstNameController,
                      label: 'First name',
                      hint: "Enter your first name",
                      validator: InputValidators.validateFirstName,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller: lastNameController,
                      label: 'Last name',
                      hint: "Enter your last name",
                      validator: InputValidators.validateLastName,
                    ),
                    const SizedBox(height: 16.0),
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
                      hint: "Create a password",
                      validator: InputValidators.validatePassword,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 36.0),
                      child: CustomButton(
                        name: 'Get started',
                        onTap: () {
                          if (signUpKey.currentState?.validate() ?? false) {
                            notifier.signUp(
                              email: emailController.text,
                              password: passwordController.text,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                            );
                          }
                        },
                        disable: state.status == ApiStatus.loading,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          color: AppColors.deepBlack,
                          fontSize: 15.0,
                        ),
                        children: [
                          const TextSpan(text: 'Already have an account? '),
                          TextSpan(
                            text: 'Log in',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Head.offAll(AppPages.login);
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
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
