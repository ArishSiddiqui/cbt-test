import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/constants/app_constants.dart';
import 'core/constants/app_themes.dart';
import 'core/network/network.dart';
import 'core/presentation/app/initialization_error_app.dart';
import 'core/presentation/widgets/widgets.dart';
import 'core/router/app_routes.dart';
import 'injection_container.dart' as di;

void main() async {
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return CustomErrorWidget(details: details);
  };

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    await di.init();

    runApp(const ProviderScope(child: MyApp()));
  } catch (e, _) {
    // Log the error or show a fallback screen
    debugPrint('Error during app initialization: $e');

    runApp(const InitializationErrorApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();
    verifyConnection();
  }

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
