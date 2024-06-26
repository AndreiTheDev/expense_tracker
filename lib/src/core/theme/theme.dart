import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';

import '../utils/utils.dart';

final ThemeData lightTheme = ThemeData(
  colorScheme: const ColorScheme.light(
    background: backgroundColor,
  ),
  textTheme: const TextTheme(
    bodyText2: TextStyle(
      color: textDark,
      fontSize: normalText,
    ),
  ).apply(
    displayColor: textDark,
    bodyColor: textDark,
  ),
  inputDecorationTheme: InputDecorationTheme(
    errorMaxLines: 2,
    errorStyle: const TextStyle(color: errorColor),
    contentPadding: const EdgeInsets.symmetric(
      vertical: smallSize,
      horizontal: mediumSize,
    ),
    filled: true,
    fillColor: Colors.white,
    border: DecoratedInputBorder(
      shadow: const [
        GradientShadow(
          gradient: buttonsGradient,
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
  bottomSheetTheme: const BottomSheetThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(mediumSize),
      ),
    ),
  ),
);
