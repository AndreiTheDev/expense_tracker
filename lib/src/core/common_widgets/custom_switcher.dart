import 'package:flutter/material.dart';

import '../utils/utils.dart';

class CustomSwitcher extends StatelessWidget {
  const CustomSwitcher({
    required this.isFirstButtonActive,
    required this.firstButtonOnTap,
    required this.firstButtonText,
    required this.secondButtonOnTap,
    required this.secondButtonText,
    super.key,
  });

  final bool isFirstButtonActive;
  final VoidCallback firstButtonOnTap;
  final String firstButtonText;
  final VoidCallback secondButtonOnTap;
  final String secondButtonText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(xsSize),
      height: xxlSize,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(-4, 6),
            color: Color(0xffdddddd),
            blurRadius: 10,
          ),
        ],
        borderRadius: BorderRadius.circular(smallSize),
      ),
      child: Row(
        children: [
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(xsSize + 2),
              child: InkWell(
                onTap: firstButtonOnTap,
                overlayColor: const MaterialStatePropertyAll(Color(0x33dddddd)),
                borderRadius: BorderRadius.circular(xsSize + 2),
                child: Ink(
                  decoration: BoxDecoration(
                    color: !isFirstButtonActive ? Colors.white : null,
                    gradient: isFirstButtonActive ? buttonsGradient : null,
                    borderRadius: BorderRadius.circular(xsSize + 2),
                  ),
                  child: Align(
                    child: Text(
                      firstButtonText,
                      style: TextStyle(
                        color: isFirstButtonActive ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          xsSeparator,
          Expanded(
            child: Material(
              borderRadius: BorderRadius.circular(xsSize + 2),
              child: InkWell(
                onTap: secondButtonOnTap,
                overlayColor: const MaterialStatePropertyAll(Color(0x33dddddd)),
                borderRadius: BorderRadius.circular(xsSize + 2),
                child: Ink(
                  decoration: BoxDecoration(
                    color: isFirstButtonActive ? Colors.white : null,
                    gradient: !isFirstButtonActive ? buttonsGradient : null,
                    borderRadius: BorderRadius.circular(xsSize + 2),
                  ),
                  child: Align(
                    child: Text(
                      secondButtonText,
                      style: TextStyle(
                        color: !isFirstButtonActive ? Colors.white : null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
