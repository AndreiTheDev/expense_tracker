import 'package:flutter/material.dart';

import '../utils/utils.dart';

class GradientText extends StatelessWidget {
  const GradientText({
    required this.text,
    this.gradient = buttonsGradient,
    this.alignment = TextAlign.center,
    this.fontSize,
    super.key,
  });

  final String text;
  final LinearGradient gradient;
  final TextAlign alignment;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      blendMode: BlendMode.srcIn,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
        ),
        textAlign: alignment,
      ),
    );
  }
}
