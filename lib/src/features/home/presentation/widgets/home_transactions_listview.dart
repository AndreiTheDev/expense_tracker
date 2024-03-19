import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utils.dart';
import '../bloc/account_bloc.dart';

class HomeTransactionsListview extends StatelessWidget {
  const HomeTransactionsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoaded) {
            final accountTransactions = state.account.transactions;
            return ListView.separated(
              padding: const EdgeInsets.symmetric(
                vertical: smallSize,
                horizontal: mediumSize,
              ),
              itemCount: accountTransactions.length,
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
                        accountTransactions[index].category,
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
                            accountTransactions[index]
                                .amount
                                .toStringAsFixed(2),
                          ),
                          Text(
                            accountTransactions[index]
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
            );
          }
          return const Text('No data');
        },
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
