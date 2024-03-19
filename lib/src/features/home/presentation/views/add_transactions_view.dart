import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/utils/utils.dart';
import '../../data/datasources/home_firestore_datasource.dart';
import '../../data/dto/expense.dart';
import '../../data/dto/income.dart';

class AddTransactionsView extends StatefulWidget {
  const AddTransactionsView({super.key});

  @override
  State<AddTransactionsView> createState() => _AddTransactionsViewState();
}

class _AddTransactionsViewState extends State<AddTransactionsView> {
  bool isAddIncome = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(mediumSize),
        child: Column(
          children: [
            xlSeparator,
            Align(
              alignment: Alignment.centerLeft,
              child: CustomAppbarButton(
                onTap: () {
                  context.pop();
                },
                icon: Icons.arrow_back_ios_new,
              ),
            ),
            mediumSeparator,
            Text(
              isAddIncome ? 'Add Income' : 'Add Expense',
              style: const TextStyle(
                fontSize: largeText,
              ),
            ),
            mediumSeparator,
            Container(
              padding: EdgeInsets.all(xsSize),
              height: xxlSize,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    offset: Offset(-4, 6),
                    color: Color(0xffdddddd),
                    blurRadius: 10,
                  ),
                ],
                borderRadius: BorderRadius.circular(smallSize),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.circular(xsSize + 2),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isAddIncome = true;
                          });
                        },
                        overlayColor:
                            const MaterialStatePropertyAll(Color(0x33dddddd)),
                        borderRadius: BorderRadius.circular(xsSize + 2),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: !isAddIncome ? Colors.white : null,
                            gradient: isAddIncome ? buttonsGradient : null,
                            borderRadius: BorderRadius.circular(xsSize + 2),
                          ),
                          child: Align(
                            child: Text(
                              'Income',
                              style: TextStyle(
                                color: isAddIncome ? Colors.white : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  xsSeparator,
                  Expanded(
                    child: Material(
                      borderRadius: BorderRadius.circular(xsSize + 2),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            isAddIncome = false;
                          });
                        },
                        overlayColor:
                            const MaterialStatePropertyAll(Color(0x33dddddd)),
                        borderRadius: BorderRadius.circular(xsSize + 2),
                        child: Ink(
                          decoration: BoxDecoration(
                            color: isAddIncome ? Colors.white : null,
                            gradient: !isAddIncome ? buttonsGradient : null,
                            borderRadius: BorderRadius.circular(xsSize + 2),
                          ),
                          child: Align(
                            child: Text(
                              'Expense',
                              style: TextStyle(
                                color: !isAddIncome ? Colors.white : null,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            mediumSeparator,
            TextField(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: smallText + 4,
                foreground: Paint()
                  ..shader = buttonsGradient
                      .createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.attach_money,
                  color: textDark.withOpacity(0.5),
                ),
                hintText: '0',
                border: DecoratedInputBorder(
                  shadow: const [
                    BoxShadow(
                      offset: Offset(-4, 6),
                      color: Color(0xffc4c4c4),
                      blurRadius: 10,
                    ),
                  ],
                  child: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.all(
                      Radius.circular(60),
                    ),
                  ),
                ),
              ),
            ),
            mediumSeparator,
            const DefaultTextField(
              hintText: 'Category',
              icon: Icons.category,
            ),
            smallSeparator,
            const DefaultTextField(
              hintText: 'Description',
              icon: Icons.book,
            ),
            smallSeparator,
            const DefaultTextField(
              hintText: 'Date',
              icon: Icons.calendar_month,
            ),
            const Expanded(child: SizedBox()),
            GradientElevatedButton(
              onTap: () {
                HomeFirestoreDataSourceImpl(FirebaseFirestore.instance)
                    .addIncome(
                        'TmQC7eMDpnDECxVepvSD8xAhFlSu',
                        'default',
                        IncomeDto(
                            category: 'test2',
                            description: 'test2',
                            amount: 100,
                            date: DateTime.now()));
              },
              displayWidget: const Text(
                'Add',
                style: TextStyle(
                  color: textLight,
                ),
              ),
              borderRadius: xsSize,
            ),
            smallSeparator,
          ],
        ),
      ),
    );
  }
}

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    required this.hintText,
    required this.icon,
    super.key,
  });

  final String hintText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: textDark.withOpacity(0.5),
        ),
        hintText: hintText,
        border: DecoratedInputBorder(
          shadow: const [
            BoxShadow(
              offset: Offset(-4, 6),
              color: Color(0xffdddddd),
              blurRadius: 10,
            ),
          ],
          child: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(xsSize),
            ),
          ),
        ),
      ),
    );
  }
}
