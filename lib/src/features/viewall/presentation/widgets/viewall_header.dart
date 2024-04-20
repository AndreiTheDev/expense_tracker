import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/custom_appbar.dart';
import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/common_widgets/custom_switcher.dart';
import '../../../../core/utils/utils.dart';
import '../../../home/presentation/bloc/account_bloc.dart';
import '../cubit/viewall_view_cubit.dart';

class ViewallHeader extends StatelessWidget {
  const ViewallHeader({
    required this.isIos,
    required this.isIncomesActive,
    required this.accountId,
    super.key,
  });

  final bool isIos;
  final bool isIncomesActive;
  final String accountId;

  @override
  Widget build(BuildContext context) {
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
              icon: isIos ? Icons.arrow_back_ios_new : Icons.arrow_back,
              onTap: () {
                context
                    .read<AccountBloc>()
                    .add(AccountFetchEvent(accountId: accountId));
                context.pop();
              },
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
          padding: const EdgeInsets.symmetric(
            horizontal: mediumSize,
          ),
          child: CustomSwitcher(
            isFirstButtonActive: isIncomesActive,
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
      ],
    );
  }
}
