import 'package:flutter/material.dart';

const Color backgroundColor = Color(0xfff3f4f6);
const Color textBlue = Color(0xff43648f);
const Color inactiveColor = Color(0xffc1cadb);
const Color textDark = Color(0xff354366);
const Color iconButtonsColor = Color(0xffa1b2c8);
const Color errorColor = Color(0xffe40e0e);
final LinearGradient backgroundGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    const Color(0xff4998d3).withOpacity(0.4),
    const Color(0xff9290e5).withOpacity(0.4),
    const Color(0xffca6ce5).withOpacity(0.4),
    const Color(0xffe686b3).withOpacity(0.4),
    const Color(0xfff9b15f).withOpacity(0.4),
  ],
);
const LinearGradient buttonsGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xff4998d3),
    Color(0xff9290e5),
    Color(0xffca6ce5),
    Color(0xffe686b3),
    Color(0xfff9b15f),
  ],
);
const LinearGradient buttonsGradientReversed = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    Color(0xfff9b15f),
    Color(0xffe686b3),
    Color(0xffca6ce5),
    Color(0xff9290e5),
    Color(0xff4998d3),
  ],
);
