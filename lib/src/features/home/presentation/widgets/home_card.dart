import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utils.dart';
import '../bloc/account_bloc.dart';

class HomeCard extends StatelessWidget {
  const HomeCard({super.key});

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
            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountLoaded) {
                  return Text(
                    '\$ ${state.account.totalBalance.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: largeText,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                return const Text(
                  'unknown',
                  style: TextStyle(
                    fontSize: largeText,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              },
            ),
            const Expanded(child: SizedBox()),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IncomeRow(),
                ExpenseRow(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeRow extends StatelessWidget {
  const IncomeRow({
    super.key,
  });

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
          child: const Icon(
            Icons.arrow_downward,
            color: Color(0xff3fe444),
            size: 18,
          ),
        ),
        xsSeparator,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Income',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountLoaded) {
                  return Text(
                    state.account.income.toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),
                  );
                }
                return const Text(
                  'test',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class ExpenseRow extends StatelessWidget {
  const ExpenseRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Expenses',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            ),
            BlocBuilder<AccountBloc, AccountState>(
              builder: (context, state) {
                if (state is AccountLoaded) {
                  return Text(
                    state.account.expenses.abs().toStringAsFixed(2),
                    style: const TextStyle(color: Colors.white),
                  );
                }
                return const Text(
                  'test',
                  style: TextStyle(color: Colors.white),
                );
              },
            ),
          ],
        ),
        xsSeparator,
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: const Color(0x33f4f4f4),
            borderRadius: BorderRadius.circular(99),
          ),
          child: const Icon(
            Icons.arrow_upward,
            color: Color(0xfffb5d67),
            size: 18,
          ),
        ),
      ],
    );
  }
}
