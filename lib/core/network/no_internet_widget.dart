import 'package:flutter/material.dart';

class NoInternetWidget extends StatelessWidget {
  const NoInternetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'No Internet Connection',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10.0),
          const Text(
            'Please check your internet connection\nand try again',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
