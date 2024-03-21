import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';

class TransactionSwitcher extends StatelessWidget {
  const TransactionSwitcher({
    required this.isAddIncome,
    required this.incomeOnTap,
    required this.expenseOnTap,
    super.key,
  });

  final bool isAddIncome;
  final VoidCallback incomeOnTap;
  final VoidCallback expenseOnTap;

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
                onTap: incomeOnTap,
                overlayColor: const MaterialStatePropertyAll(Color(0x33dddddd)),
                borderRadius: BorderRadius.circular(xsSize + 2),
                child: Ink(
                  decoration: BoxDecoration(
                    color: !isAddIncome ? Colors.white : null,
                    gradient: isAddIncome ? buttonsGradient : null,
                    borderRadius: BorderRadius.circular(xsSize + 2),
                  ),
                  child: Align(
                    child: Text(
                      'Income',
                      style: TextStyle(
                        color: isAddIncome ? Colors.white : null,
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
                onTap: expenseOnTap,
                overlayColor: const MaterialStatePropertyAll(Color(0x33dddddd)),
                borderRadius: BorderRadius.circular(xsSize + 2),
                child: Ink(
                  decoration: BoxDecoration(
                    color: isAddIncome ? Colors.white : null,
                    gradient: !isAddIncome ? buttonsGradient : null,
                    borderRadius: BorderRadius.circular(xsSize + 2),
                  ),
                  child: Align(
                    child: Text(
                      'Expense',
                      style: TextStyle(
                        color: !isAddIncome ? Colors.white : null,
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
