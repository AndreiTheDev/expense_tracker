// ignore_for_file: lines_longer_than_80_chars

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/transactions_listview.dart';
import '../../../../core/utils/logger.dart';
import '../../../../core/utils/utils.dart';
import '../../../home/presentation/bloc/account_bloc.dart';
import '../blocs/viewall_bloc.dart';
import '../cubit/viewall_view_cubit.dart';
import '../widgets/viewall_chart.dart';
import '../widgets/viewall_header.dart';

class ViewallView extends StatelessWidget {
  const ViewallView({super.key});

  @override
  Widget build(BuildContext context) {
    getLogger(ViewallView).d('build');

    final isIos = Theme.of(context).platform == TargetPlatform.iOS;
    final accountState = context.read<AccountBloc>().state;
    final accountId =
        accountState is AccountLoaded ? accountState.account.id : 'default';
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ViewallViewCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ViewallBloc>()
            ..add(ViewallFetchIncomesDetailsEvent(accountId: accountId)),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocConsumer<ViewallViewCubit, ViewallViewState>(
              listener: (context, viewState) {
                if (viewState is ViewallViewIncomes) {
                  context.read<ViewallBloc>().add(
                        ViewallFetchIncomesDetailsEvent(
                          accountId: accountId,
                        ),
                      );
                }
                if (viewState is ViewallViewExpenses) {
                  context.read<ViewallBloc>().add(
                        ViewallFetchExpensesDetailsEvent(
                          accountId: accountId,
                        ),
                      );
                }
              },
              builder: (context, viewState) {
                switch (viewState) {
                  case ViewallViewIncomes():
                    return Column(
                      children: [
                        ViewallHeader(
                          isIos: isIos,
                          isIncomesActive: true,
                          accountId: accountId,
                        ),
                        mediumSeparator,
                        Expanded(
                          child: BlocBuilder<ViewallBloc, ViewallState>(
                            builder: (context, blocState) {
                              switch (blocState) {
                                case ViewallLoaded()
                                    when blocState.incomesDetails != null:
                                  return Column(
                                    children: [
                                      ViewallChart(
                                        chart: blocState
                                            .incomesDetails!.incomesChart,
                                      ),
                                      smallSeparator,
                                      if (blocState.incomesDetails!.incomesList
                                          .isNotEmpty)
                                        TransactionsListview(
                                          transactionsListCards: [
                                            for (final incomeEntity in blocState
                                                .incomesDetails!.incomesList)
                                              TransactionsListCard(
                                                transaction: incomeEntity,
                                                deleteTransactionCallback: () {
                                                  context
                                                      .read<ViewallBloc>()
                                                      .add(
                                                        ViewallDeleteIncomeEvent(
                                                          incomeEntity:
                                                              incomeEntity,
                                                          accountId: accountId,
                                                        ),
                                                      );
                                                },
                                              ),
                                          ],
                                        )
                                      else
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            top: smallSize,
                                          ),
                                          child: Text(
                                            'There are no incomes yet.',
                                          ),
                                        ),
                                    ],
                                  );
                                case ViewallLoaded()
                                    when blocState.incomesDetails == null:
                                  return const Padding(
                                    padding: EdgeInsets.all(mediumSize),
                                    child: Text(
                                      'Unable to fetch data. Please reload the page.',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                case ViewallLoading():
                                  return const Column(
                                    children: [
                                      ViewallChartLoading(),
                                      smallSeparator,
                                      TransactionsListviewLoading(),
                                    ],
                                  );
                                default:
                                  return RefreshIndicator(
                                    onRefresh: () => Future(
                                      () => context.read<ViewallBloc>().add(
                                            ViewallFetchIncomesDetailsEvent(
                                              accountId: accountId,
                                            ),
                                          ),
                                    ),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) =>
                                          SingleChildScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minHeight: constraints.maxHeight,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                blocState is ViewallError
                                                    ? blocState.message
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
                      ],
                    );
                  case ViewallViewExpenses():
                    return Column(
                      children: [
                        ViewallHeader(
                          isIos: isIos,
                          isIncomesActive: false,
                          accountId: accountId,
                        ),
                        mediumSeparator,
                        Expanded(
                          child: BlocBuilder<ViewallBloc, ViewallState>(
                            builder: (context, blocState) {
                              switch (blocState) {
                                case ViewallLoaded()
                                    when blocState.expensesDetails != null:
                                  return Column(
                                    children: [
                                      ViewallChart(
                                        chart: blocState
                                            .expensesDetails!.expensesChart,
                                      ),
                                      smallSeparator,
                                      if (blocState.expensesDetails!
                                          .expensesList.isNotEmpty)
                                        TransactionsListview(
                                          transactionsListCards: [
                                            for (final expenseEntity
                                                in blocState.expensesDetails!
                                                    .expensesList)
                                              TransactionsListCard(
                                                transaction: expenseEntity,
                                                deleteTransactionCallback: () {
                                                  context
                                                      .read<ViewallBloc>()
                                                      .add(
                                                        ViewallDeleteExpenseEvent(
                                                          expenseEntity:
                                                              expenseEntity,
                                                          accountId: accountId,
                                                        ),
                                                      );
                                                },
                                              ),
                                          ],
                                        )
                                      else
                                        const Padding(
                                          padding: EdgeInsets.only(
                                            top: smallSize,
                                          ),
                                          child: Text(
                                            'There are no expenses yet.',
                                          ),
                                        ),
                                    ],
                                  );
                                case ViewallLoaded()
                                    when blocState.expensesDetails == null:
                                  return const Padding(
                                    padding: EdgeInsets.all(mediumSize),
                                    child: Text(
                                      'Unable to fetch data. Please reload the page.',
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                case ViewallLoading():
                                  return const Column(
                                    children: [
                                      ViewallChartLoading(),
                                      smallSeparator,
                                      TransactionsListviewLoading(),
                                    ],
                                  );
                                default:
                                  return RefreshIndicator(
                                    onRefresh: () => Future(
                                      () => context.read<ViewallBloc>().add(
                                            ViewallFetchExpensesDetailsEvent(
                                              accountId: accountId,
                                            ),
                                          ),
                                    ),
                                    child: LayoutBuilder(
                                      builder: (context, constraints) =>
                                          SingleChildScrollView(
                                        physics:
                                            const AlwaysScrollableScrollPhysics(),
                                        child: ConstrainedBox(
                                          constraints: BoxConstraints(
                                            minHeight: constraints.maxHeight,
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                blocState is ViewallError
                                                    ? blocState.message
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
                      ],
                    );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
