import 'package:flutter/material.dart';

import '../constants/app_constants.dart';

class AppPages {
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signUp';
  static const String home = '/home';
  static const String taskDetail = '/taskDetail';
}

class Head {
  static Future<Object?> to(String pageName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed(pageName, arguments: arguments);
  }

  static Future<Object?> off(String pageName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(
      pageName,
      arguments: arguments,
    );
  }

  static Future<Object?> offAll(String pageName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      pageName,
      (_) => false,
      arguments: arguments,
    );
  }

  static void back([Object? result]) {
    if (navigatorKey.currentState!.canPop()) {
      return navigatorKey.currentState!.pop(result);
    } else {
      return;
    }
  }

  static void backUntil(String pageName) {
    return navigatorKey.currentState!.popUntil(ModalRoute.withName(pageName));
  }
}
