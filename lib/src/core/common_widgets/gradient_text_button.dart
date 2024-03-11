import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'gradient_text.dart';

class GradientTextButton extends StatelessWidget {
  const GradientTextButton({
    required this.onTap,
    required this.text,
    this.gradient,
    super.key,
  });

  final VoidCallback onTap;
  final String text;
  final LinearGradient? gradient;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      overlayColor: const MaterialStatePropertyAll(Color(0x33cccccc)),
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(70),
      ),
      child: Ink(
        padding: const EdgeInsets.symmetric(
          vertical: xsSize,
          horizontal: smallSize,
        ),
        child: GradientText(
          text: text,
          gradient: gradient ?? buttonsGradient,
        ),
      ),
    );
  }
}
