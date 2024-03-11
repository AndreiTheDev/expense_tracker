import 'package:flutter/material.dart';

import '../utils/utils.dart';

class GradientElevatedButton extends StatelessWidget {
  const GradientElevatedButton({
    required this.onTap,
    required this.displayWidget,
    this.gradient = buttonsGradient,
    super.key,
  });

  final VoidCallback onTap;
  final Widget displayWidget;
  final LinearGradient gradient;

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
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(70),
          boxShadow: const [
            BoxShadow(
              color: Color(0xffcccccc),
              offset: Offset(0, 5),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          gradient: gradient,
        ),
        width: double.maxFinite,
        child: ConstrainedBox(
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
