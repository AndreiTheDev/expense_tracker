import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/custom_appbar.dart';
import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/utils.dart';
import '../../../home/presentation/bloc/account_bloc.dart';
import '../../domain/entities/account.dart';
import '../bloc/switch_account_bloc.dart';
import '../widgets/accounts_list_bottomsheet.dart';

class AllAccountsView extends StatelessWidget {
  const AllAccountsView({super.key});

  @override
  Widget build(BuildContext context) {
    getLogger(AllAccountsView).d('build');

    return Scaffold(
      body: BlocProvider<SwitchAccountBloc>(
        create: (context) => sl()..add(SwitchAccountFetchAccountsEvent()),
        child: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(mediumSize),
              child: Column(
                children: [
                  xlSeparator,
                  CustomAppbar(
                    leftButton: CustomAppbarButton(
                      onTap: context.pop,
                      icon: Icons.arrow_back,
                    ),
                    middleWidget: const Text(
                      'All accounts',
                      style: TextStyle(
                        fontSize: mediumText,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  smallSeparator,
                  Expanded(
                    child: BlocBuilder<SwitchAccountBloc, SwitchAccountState>(
                      builder: (context, state) {
                        switch (state) {
                          case SwitchAccountLoaded():
                            return AllAccountsListView(
                              accountsList: state.accountsList,
                            );
                          case SwitchAccountLoading():
                            return const AllAccountsListViewLoading();
                          default:
                            return RefreshIndicator(
                              onRefresh: () => Future(
                                () => context
                                    .read<SwitchAccountBloc>()
                                    .add(SwitchAccountFetchAccountsEvent()),
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraints) =>
                                    SingleChildScrollView(
                                  physics:
                                      const AlwaysScrollableScrollPhysics(),
                                  child: ConstrainedBox(
                                    constraints: BoxConstraints(
                                      minHeight: constraints.maxHeight,
                                      minWidth: constraints.maxWidth,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          state is SwitchAccountError
                                              ? state.message
                                              : 'An unknown error occured.',
                                        ),
                                        const Text(
                                          'Please slide down to refresh the page.',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                        }
                      },
                    ),
                  ),
                  smallSeparator,
                  GradientElevatedButton(
                    onTap: () async {
                      await showModalBottomSheet(
                        context: context,
                        builder: (innerContext) {
                          return BlocProvider.value(
                            value: context.read<SwitchAccountBloc>(),
                            child: const CreateAccountBottomSheet(),
                          );
                        },
                      );
                    },
                    displayWidget: const Text(
                      'Create new account',
                      style: TextStyle(color: textLight),
                    ),
                  ),
                  smallSeparator,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class AllAccountsListView extends StatelessWidget {
  const AllAccountsListView({
    required this.accountsList,
    super.key,
  });

  final List<AccountEntity> accountsList;

  @override
  Widget build(BuildContext context) {
    final amountFormatter = NumberFormat.compact(locale: 'en_US');

    return ListView.separated(
      padding: const EdgeInsets.only(top: smallSize),
      itemBuilder: (context, index) {
        final account = accountsList[index];
        return GestureDetector(
          onTap: () {
            context.read<AccountBloc>().add(
                  AccountFetchEvent(accountId: account.id),
                );
            context.pop();
          },
          child: Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(account.name),
                    smallSeparator,
                    Text(account.owner),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Balance:'),
                    smallSeparator,
                    Text(
                      '\$${amountFormatter.format(account.totalBalance)}',
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return smallSeparator;
      },
      itemCount: accountsList.length,
    );
  }
}

class AllAccountsListViewLoading extends StatelessWidget {
  const AllAccountsListViewLoading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: smallSize),
      itemBuilder: (context, index) {
        return Skeletonizer(
          child: Container(
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
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Default Account'),
                    smallSeparator,
                    Text('Emanuel'),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('Balance:'),
                    smallSeparator,
                    Text(r'$282'),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return smallSeparator;
      },
      itemCount: 4,
    );
  }
}
