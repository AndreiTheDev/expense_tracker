import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  const HomeBottomNavigationBar({required this.appBarHeight, super.key});

  final double appBarHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: xlSize),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(largeSize),
          topRight: Radius.circular(largeSize),
        ),
      ),
      height: appBarHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.grid_view_rounded,
            size: mediumSize + 4,
            color: textDark.withOpacity(0.4),
          ),
          Icon(
            Icons.expand_circle_down,
            size: mediumSize + 4,
            color: textDark.withOpacity(0.4),
          ),
        ],
      ),
    );
  }
}
