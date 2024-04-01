import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/custom_appbar.dart';
import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/common_widgets/custom_switcher.dart';
import '../../../../core/common_widgets/transactions_listview.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/entities/transaction.dart';

class ViewallView extends StatefulWidget {
  const ViewallView({super.key});

  @override
  State<ViewallView> createState() => _ViewallViewState();
}

class _ViewallViewState extends State<ViewallView> {
  bool isShowIncome = true;

  @override
  Widget build(BuildContext context) {
    final isIos = Theme.of(context).platform == TargetPlatform.iOS;

    return Scaffold(
      body: Column(
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
            padding: const EdgeInsets.symmetric(horizontal: mediumSize),
            child: CustomSwitcher(
              isFirstButtonActive: isShowIncome,
              firstButtonOnTap: () {
                setState(() {
                  isShowIncome = true;
                });
              },
              firstButtonText: 'Incomes',
              secondButtonOnTap: () {
                setState(() {
                  isShowIncome = false;
                });
              },
              secondButtonText: 'Expenses',
            ),
          ),
          mediumSeparator,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: mediumSize),
            height: 280,
            child: const Placeholder(),
          ),
          mediumSeparator,
          TransactionsListview(
            transactionsList: [
              TransactionEntity(
                id: 'tessst',
                category: 'test',
                description: 'description',
                amount: -100,
                date: DateTime.now(),
                relatedDoc: 'teeest',
              ),
              TransactionEntity(
                id: 'tessst',
                category: 'test',
                description: 'description',
                amount: -100,
                date: DateTime.now(),
                relatedDoc: 'teeest',
              ),
              TransactionEntity(
                id: 'tessst',
                category: 'test',
                description: 'description',
                amount: -100,
                date: DateTime.now(),
                relatedDoc: 'teeest',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
