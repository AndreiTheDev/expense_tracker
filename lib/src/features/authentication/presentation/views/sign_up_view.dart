import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';

import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/common_widgets/gradient_text_button.dart';
import '../../../../core/utils/utils.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(smallSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Sign Up',
            style: TextStyle(
              fontSize: textXl,
              color: textDark,
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
          TextField(
            decoration: InputDecoration(
              hintText: 'Enter your password...',
              border: DecoratedInputBorder(
                shadow: const [
                  GradientShadow(
                    gradient: buttonsGradientReversed,
                    blurRadius: 14,
                    spreadRadius: -4,
                  ),
                ],
                child: const OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              ),
            ),
          ),
          mediumSeparator,
          GradientElevatedButton(
            onTap: () {},
            displayWidget: const Text(
              'Sign Up',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          mediumSeparator,
          GradientTextButton(
            onTap: () {},
            text: 'Sign in your account.',
            gradient: buttonsGradientReversed,
          ),
          xsSeparator,
          const Text('OR'),
          xsSeparator,
          GradientTextButton(
            onTap: () {},
            text: 'Recover your password.',
          ),
        ],
      ),
    );
  }
}
