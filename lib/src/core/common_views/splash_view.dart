import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: backgroundGradient,
        ),
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 3,
          ),
        ),
      ),
    );
  }
}
