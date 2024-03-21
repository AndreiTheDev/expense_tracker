import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/transaction.dart';

class HomeTransactionsListview extends StatelessWidget {
  const HomeTransactionsListview({required this.transactionsList, super.key});

  final List<TransactionEntity> transactionsList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          vertical: smallSize,
          horizontal: mediumSize,
        ),
        itemCount: transactionsList.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(smallSize),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(smallSize),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffdddddd),
                  offset: Offset(0, 6),
                  blurRadius: 10,
                ),
              ],
            ),
            height: 80,
            child: Row(
              children: [
                const IconContainer(
                  icon: Icons.shopping_bag,
                ),
                xsSeparator,
                Text(
                  transactionsList[index].category,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${transactionsList[index].amount.toStringAsFixed(2)}\$',
                    ),
                    Text(
                      transactionsList[index]
                          .date
                          .toIso8601String()
                          .substring(0, 10),
                      style: TextStyle(
                        color: textDark.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return smallSeparator;
        },
      ),
    );
  }
}

class HomeTransactionsListviewLoading extends StatelessWidget {
  const HomeTransactionsListviewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Skeletonizer(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(
            vertical: smallSize,
            horizontal: mediumSize,
          ),
          itemCount: 6,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(smallSize),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(smallSize),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffdddddd),
                    offset: Offset(0, 6),
                    blurRadius: 10,
                  ),
                ],
              ),
              height: 80,
              child: const Row(
                children: [
                  IconContainer(
                    icon: Icons.shopping_bag,
                  ),
                  xsSeparator,
                  Text(
                    'Placeholder',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: SizedBox()),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Placeholder',
                      ),
                      Text(
                        'Placeholder',
                        style: TextStyle(
                          color: textDark,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return smallSeparator;
          },
        ),
      ),
    );
  }
}

class IconContainer extends StatelessWidget {
  const IconContainer({
    required this.icon,
    super.key,
  });

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(xsSize),
      decoration: BoxDecoration(
        color: const Color(0xffffc54d),
        borderRadius: BorderRadius.circular(99),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: mediumSize,
      ),
    );
  }
}
