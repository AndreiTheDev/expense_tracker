import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/common_widgets/transactions_listview.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/utils.dart';
import '../bloc/account_bloc.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/home_bottom_navigation_bar.dart';
import '../widgets/home_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    getLogger(HomeView).d('build');
    const double appBarHeight = 90;
    context.read<AccountBloc>().add(const AccountFetchEvent());

    return Scaffold(
      body: BlocBuilder<AccountBloc, AccountState>(
        builder: (context, state) {
          if (state is AccountLoaded) {
            final currentAccount = state.account;
            return Column(
              children: [
                xlSeparator,
                const HomeAppBar(),
                smallSeparator,
                HomeCard(
                  currentAccount: currentAccount,
                ),
                mediumSeparator,
                const TransactionsListHeader(),
                if (currentAccount.transactions.isEmpty)
                  const Padding(
                    padding: EdgeInsets.only(top: mediumSize),
                    child: Text('There are no transactions yet.'),
                  ),
                if (currentAccount.transactions.isNotEmpty)
                  TransactionsListview(
                    transactionsListCards: [
                      for (final transaction in currentAccount.transactions)
                        TransactionsListCard(
                          transaction: transaction,
                          deleteTransactionCallback: () {
                            context.read<AccountBloc>().add(
                                  AccountDeleteTransactionEvent(
                                    transactionEntity: transaction,
                                  ),
                                );
                          },
                        ),
                    ],
                  ),
              ],
            );
          }
          if (state is AccountLoading) {
            return const Column(
              children: [
                xlSeparator,
                HomeAppBar(),
                smallSeparator,
                HomeCardLoading(),
                mediumSeparator,
                Skeletonizer(
                  child: TransactionsListHeader(),
                ),
                TransactionsListviewLoading(),
              ],
            );
          }
          return RefreshIndicator(
            onRefresh: () {
              return Future(
                () =>
                    context.read<AccountBloc>().add(const AccountFetchEvent()),
              );
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    xlSeparator,
                    const HomeAppBar(),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            state is AccountError
                                ? state.message
                                : 'An unknown error occured.',
                          ),
                          const Text(
                            'Please slide down to refresh the page.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.pushNamed(AppRoutes.addTransactions.name);
        },
        shape: const CircleBorder(),
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: buttonsGradientReversed,
          ),
          child: const Icon(
            Icons.add,
            size: largeSize,
          ),
        ),
      ),
      bottomNavigationBar: const HomeBottomNavigationBar(
        appBarHeight: appBarHeight,
      ),
    );
  }
}

class TransactionsListHeader extends StatelessWidget {
  const TransactionsListHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: mediumSize,
        right: mediumSize,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Transactions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            onPressed: () async {
              await context.pushNamed(AppRoutes.viewall.name);
            },
            style: ButtonStyle(
              overlayColor: MaterialStatePropertyAll(
                textDark.withOpacity(0.15),
              ),
            ),
            child: const Text(
              'View All',
              style: TextStyle(
                color: textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
