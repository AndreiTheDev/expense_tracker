import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/utils/utils.dart';
import '../../domain/entities/account.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({required this.currentAccount, super.key});

  final AccountEntity currentAccount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: mediumSize,
        right: mediumSize,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: mediumSize,
          horizontal: smallSize,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mediumSize),
          boxShadow: const [
            BoxShadow(
              offset: Offset(-4, 6),
              color: Color(0xffc4c4c4),
              blurRadius: 10,
            ),
          ],
          gradient: buttonsGradient,
        ),
        height: 200,
        width: double.infinity,
        child: Column(
          children: [
            const Text(
              'Total Balance',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            xsSeparator,
            Text(
              '\$ ${currentAccount.totalBalance.toStringAsFixed(2)}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: largeText,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Expanded(child: SizedBox()),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DetailRow(
                  amount: currentAccount.income,
                  icon: const Icon(
                    Icons.arrow_downward,
                    color: Color(0xff3fe444),
                    size: 18,
                  ),
                  description: 'Income',
                ),
                DetailRow(
                  amount: currentAccount.expenses,
                  icon: const Icon(
                    Icons.arrow_upward,
                    color: Color(0xfffb5d67),
                    size: 18,
                  ),
                  description: 'Expenses',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeCardLoading extends StatelessWidget {
  const HomeCardLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: Padding(
        padding: const EdgeInsets.only(
          left: mediumSize,
          right: mediumSize,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: mediumSize,
            horizontal: smallSize,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(mediumSize),
            boxShadow: const [
              BoxShadow(
                offset: Offset(-4, 6),
                color: Color(0xffc4c4c4),
                blurRadius: 10,
              ),
            ],
            gradient: buttonsGradient,
          ),
          height: 200,
          width: double.infinity,
          child: const Column(
            children: [
              Text(
                'Total Balance',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              xsSeparator,
              Text(
                r'$ placeholder',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: largeText,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(child: SizedBox()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DetailRow(
                    amount: 100,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Color(0xff3fe444),
                      size: 18,
                    ),
                    description: 'Placeholder',
                  ),
                  DetailRow(
                    amount: 100,
                    icon: Icon(
                      Icons.arrow_downward,
                      color: Color(0xfffb5d67),
                      size: 18,
                    ),
                    description: 'Placeholder',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailRow extends StatelessWidget {
  const DetailRow({
    required this.amount,
    required this.icon,
    required this.description,
    super.key,
  });

  final double amount;
  final Icon icon;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0x33f4f4f4),
            borderRadius: BorderRadius.circular(99),
          ),
          child: icon,
        ),
        xsSeparator,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            Text(
              amount.abs().toStringAsFixed(2),
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}
