import 'package:flutter/material.dart';

import '../utils/utils.dart';

class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    required this.onTap,
    required this.displayWidget,
    this.gradient = buttonsGradient,
    this.borderRadius = 70,
    super.key,
  });

  final VoidCallback onTap;
  final Widget displayWidget;
  final LinearGradient gradient;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        gradient: gradient,
      ),
      child: InkWell(
        onTap: onTap,
        overlayColor: const MaterialStatePropertyAll(Color(0x33cccccc)),
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: xsSize),
          constraints: const BoxConstraints(
            minHeight: mediumSize,
          ),
          child: Align(
            child: displayWidget,
          ),
        ),
      ),
    );
  }
}
