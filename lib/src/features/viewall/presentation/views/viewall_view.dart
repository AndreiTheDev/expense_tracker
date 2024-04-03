import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/custom_appbar.dart';
import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/common_widgets/custom_switcher.dart';
import '../../../../core/common_widgets/transactions_listview.dart';
import '../../../../core/utils/utils.dart';
import '../blocs/viewall_bloc.dart';
import '../cubit/viewall_view_cubit.dart';
import '../widgets/viewall_chart.dart';

class ViewallView extends StatefulWidget {
  const ViewallView({super.key});

  @override
  State<ViewallView> createState() => _ViewallViewState();
}

class _ViewallViewState extends State<ViewallView> {
  @override
  Widget build(BuildContext context) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ViewallViewCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<ViewallBloc>()
            ..add(
              const ViewallFetchIncomesDetailsEvent(),
            ),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: BlocConsumer<ViewallViewCubit, ViewallViewState>(
              listener: (context, viewState) {
                if (viewState is ViewallViewIncomes) {
                  context
                      .read<ViewallBloc>()
                      .add(const ViewallFetchIncomesDetailsEvent());
                }
                if (viewState is ViewallViewExpenses) {
                  context
                      .read<ViewallBloc>()
                      .add(const ViewallFetchExpensesDetailsEvent());
                }
              },
              builder: (context, viewState) {
                return Column(
                  children: [
                    xlSeparator,
                    Padding(
                      padding: const EdgeInsets.only(
                        left: mediumSize,
                        top: mediumSize,
                        right: mediumSize,
                      ),
                      child: CustomAppbar(
                        leftButton: CustomAppbarButton(
                          icon: isIos
                              ? Icons.arrow_back_ios_new
                              : Icons.arrow_back,
                          onTap: context.pop,
                        ),
                        middleWidget: const Text(
                          'Transactions',
                          style: TextStyle(
                            fontSize: mediumText,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        rightButton: CustomAppbarButton(
                          icon: Icons.tune,
                          onTap: () {},
                        ),
                      ),
                    ),
                    mediumSeparator,
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: mediumSize),
                      child: CustomSwitcher(
                        isFirstButtonActive: viewState is ViewallViewIncomes,
                        firstButtonOnTap: () {
                          context.read<ViewallViewCubit>().switchToIncomes();
                        },
                        firstButtonText: 'Incomes',
                        secondButtonOnTap: () {
                          context.read<ViewallViewCubit>().switchToExpenses();
                        },
                        secondButtonText: 'Expenses',
                      ),
                    ),
                    mediumSeparator,
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: mediumSize),
                      child: ViewallChart(),
                    ),
                    smallSeparator,
                    BlocBuilder<ViewallBloc, ViewallState>(
                      builder: (context, blocState) {
                        if (blocState is ViewallLoaded &&
                            viewState is ViewallViewIncomes &&
                            blocState.incomesDetails != null) {
                          return blocState
                                  .incomesDetails!.incomesList.isNotEmpty
                              ? TransactionsListview(
                                  transactionsList:
                                      blocState.incomesDetails!.incomesList,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: smallSize),
                                  child: Text('There are no incomes yet.'),
                                );
                        }
                        if (blocState is ViewallLoaded &&
                            viewState is ViewallViewExpenses &&
                            blocState.expensesDetails != null) {
                          return blocState
                                  .expensesDetails!.expensesList.isNotEmpty
                              ? TransactionsListview(
                                  transactionsList:
                                      blocState.expensesDetails!.expensesList,
                                )
                              : const Padding(
                                  padding: EdgeInsets.only(top: smallSize),
                                  child: Text('There are no expenses yet.'),
                                );
                        }
                        if (blocState is ViewallLoading) {
                          return const TransactionsListviewLoading();
                        }
                        if (blocState is ViewallLoaded &&
                            (blocState.incomesDetails == null ||
                                blocState.expensesDetails == null)) {
                          return const Text(
                            'Unable to fetch data. Please reload the page.',
                          );
                        }
                        return const Text('An unknown error occured.');
                      },
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
