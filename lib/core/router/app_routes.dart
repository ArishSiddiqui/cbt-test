import 'package:flutter/material.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/sign_up_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/home/presentation/pages/task_detail_page.dart';
import '../../features/splash/presentation/pages/splash_page.dart';
import '../presentation/widgets/widgets.dart';
import 'app_navigation.dart';

class AppRoutes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      AppPages.splash => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const SplashPage(),
      ),
      AppPages.login => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const LoginPage(),
      ),
      AppPages.signUp => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const SignUpPage(),
      ),
      AppPages.taskDetail => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) {
          // final data = settings.arguments as VerifyOtpPageData;
          return TaskDetailPage();
        },
      ),
      AppPages.home => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const HomePage(),
      ),
      _ => MaterialPageRoute(
        settings: settings,
        builder: (BuildContext context) => const CustomNoPageWidget(),
      ),
    };
  }
}
