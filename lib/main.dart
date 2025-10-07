import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_themes.dart';
import 'core/presentation/widgets/widgets.dart';
import 'core/router/app_routes.dart';
import 'injection_container.dart' as di;

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(details: details);
  };

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    // options: DefaultFire.currentPlatform,
  );
  await di.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final mQ = MediaQuery.of(context);
    screenHeight = mQ.size.height;
    screenWidth = mQ.size.width;
    pendingScreenHeight =
        mQ.size.height - (mQ.viewPadding.top + mQ.viewPadding.bottom);
    return MaterialApp(
      title: 'CBT Kanban',
      scaffoldMessengerKey: messangerKey,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.appTheme,
      navigatorKey: navigatorKey,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
