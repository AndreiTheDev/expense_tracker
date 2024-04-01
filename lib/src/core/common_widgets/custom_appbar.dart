import 'package:flutter/material.dart';

import '../utils/utils.dart';
import 'custom_appbar_button.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    this.leftButton,
    this.middleWidget,
    this.rightButton,
    super.key,
  });

  final CustomAppbarButton? leftButton;
  final Widget? middleWidget;
  final CustomAppbarButton? rightButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        leftButton ??
            const SizedBox(
              width: xsSize * 2 + iconSize,
            ),
        middleWidget ??
            const SizedBox(
              width: 1,
            ),
        rightButton ??
            const SizedBox(
              width: xsSize * 2 + iconSize,
            ),
      ],
    );
  }
}
