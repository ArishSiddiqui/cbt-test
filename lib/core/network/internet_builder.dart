import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

import 'network.dart';

class InternetBuilder extends StatelessWidget {
  final Widget child;
  final Widget? noInternetWidget;
  const InternetBuilder({
    required this.child,
    this.noInternetWidget,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: connection,
      child: child,
      builder: (context, value, child) {
        return value?.contains(ConnectivityResult.none) ?? false
            ? noInternetWidget ?? const NoInternetWidget()
            : child ?? const SizedBox.shrink();
      },
    );
  }
}
