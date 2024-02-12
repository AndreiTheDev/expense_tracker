import 'package:flutter/material.dart';

import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/common_widgets/gradient_text_button.dart';
import '../../../../core/utils/utils.dart';

class RecoverPasswordView extends StatelessWidget {
  const RecoverPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Recover your password',
            style: TextStyle(
              color: textDark,
              fontSize: textXl,
            ),
            textAlign: TextAlign.center,
          ),
          xlSeparator,
          const TextField(
            decoration: InputDecoration(
              hintText: 'Enter your email...',
            ),
          ),
          mediumSeparator,
          GradientElevatedButton(
            onTap: () {},
            displayWidget: const Text(
              'Send email',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            gradient: buttonsGradientReversed,
          ),
          mediumSeparator,
          GradientTextButton(
            onTap: () {},
            text: 'Sign in your account.',
          ),
          xsSeparator,
          const Text('OR'),
          xsSeparator,
          GradientTextButton(
            onTap: () {},
            text: 'Create a new account.',
            gradient: buttonsGradientReversed,
          ),
        ],
      ),
    );
  }
}
