import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import '../constants/app_colors.dart';
import '../util/custom_utils.dart';

final ValueNotifier<List<ConnectivityResult>?> connection = ValueNotifier(null);

ConnectivityResult? previousState;

verifyConnection() {
  final Connectivity connectivity = Connectivity();
  connectivity.onConnectivityChanged.listen((connectionStatus) {
    connection.value = connectionStatus;
    if (connectionStatus.contains(ConnectivityResult.none)) {
      previousState = connectionStatus.first;
      showCustomSnackBar(
        message: 'No Internet Connection',
        icon: Icons.public_off_rounded,
        backgroundColor: AppColors.red,
        dismissDirection: DismissDirection.none,
        duration: const Duration(days: 1),
      );
    } else if (connectionStatus.contains(ConnectivityResult.mobile) &&
        previousState == ConnectivityResult.none) {
      previousState = connectionStatus.first;
      showCustomSnackBar(
        message: 'Back Online.',
        icon: Icons.network_cell_rounded,
        backgroundColor: AppColors.green,
      );
    } else if (connectionStatus.contains(ConnectivityResult.wifi) &&
        previousState == ConnectivityResult.none) {
      previousState = connectionStatus.first;
      showCustomSnackBar(
        message: 'Back Online.',
        icon: Icons.wifi_rounded,
        backgroundColor: AppColors.green,
      );
    }
  });
}
