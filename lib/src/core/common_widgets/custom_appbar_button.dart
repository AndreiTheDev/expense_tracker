import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomAppbarButton extends StatelessWidget {
  const CustomAppbarButton({
    required this.onTap,
    required this.icon,
    super.key,
  });

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Container(
        padding: const EdgeInsets.all(xsSize),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: iconButtonsColor,
        ),
      ),
    );
  }
}
