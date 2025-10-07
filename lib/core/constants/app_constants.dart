// Declare variables that can globally used through out the App.

import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> messangerKey =
    GlobalKey<ScaffoldMessengerState>();

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

enum ApiStatus { initial, loading, success, error }

const String connectionTimeOutMessage =
    'Connection timed out. Please try again.';
const String unexpectedErrorMessage =
    'An unexpected error occurred. Please try again.';
const timeoutDuration = Duration(seconds: 10);

double? screenHeight;
double? pendingScreenHeight;
double? screenWidth;
String? userUID;

// Keys used for shared prefs
const String isLoggedInKey = "isLoggedInKey";
const String userUIDKey = "userUIDKey";
const String tasksKey = "tasksKey";
// Cloud BD names
const String userDB = "users";
const String taskDB = "tasks";
