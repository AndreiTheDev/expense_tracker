import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/utils.dart';
import '../../../authentication/presentation/blocs/user_bloc/user_bloc.dart';
import '../bloc/account_bloc.dart';
import '../widgets/home_bottom_navigation_bar.dart';
import '../widgets/home_card.dart';
import '../widgets/home_transactions_listview.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    const double appBarHeight = 90;
    return BlocProvider<AccountBloc>(
      create: (context) => sl()..add(const AccountFetchEvent()),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: RefreshIndicator(
              onRefresh: () {
                return Future(
                  () => context
                      .read<AccountBloc>()
                      .add(const AccountFetchEvent()),
                );
              },
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - appBarHeight + 1,
                  child: Column(
                    children: [
                      xlSeparator,
                      Padding(
                        padding: const EdgeInsets.only(
                          left: mediumSize,
                          right: mediumSize,
                          top: mediumSize,
                        ),
                        child: Row(
                          children: [
                            BlocBuilder<UserBloc, UserState>(
                              builder: (context, state) {
                                if (state is UserAuthenticated) {
                                  return CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      state.user.photoUrl,
                                    ),
                                  );
                                }
                                return const CircleAvatar(
                                  backgroundColor: Colors.amber,
                                );
                              },
                            ),
                            smallSeparator,
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Welcome!',
                                  style: TextStyle(
                                    fontSize: smallText,
                                  ),
                                ),
                                BlocBuilder<UserBloc, UserState>(
                                  builder: (context, state) {
                                    if (state is UserAuthenticated) {
                                      return Text(
                                        state.user.completeName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: textDark,
                                        ),
                                      );
                                    }
                                    return const Text(
                                      'John Doe',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: textDark,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                            const Expanded(child: SizedBox()),
                            CustomAppbarButton(
                              onTap: () {},
                              icon: Icons.mode_standby,
                            ),
                          ],
                        ),
                      ),
                      smallSeparator,
                      const HomeCard(),
                      mediumSeparator,
                      Padding(
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
                              onPressed: () {},
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
                      ),
                      const HomeTransactionsListview(),
                    ],
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
        },
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
            onPressed: () {},
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
