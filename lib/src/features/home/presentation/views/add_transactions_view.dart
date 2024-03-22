import 'package:control_style/control_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../../injection_container.dart';
import '../../../../core/common_widgets/custom_appbar_button.dart';
import '../../../../core/common_widgets/gradient_elevated_button.dart';
import '../../../../core/utils/utils.dart';
import '../bloc/account_bloc.dart';
import '../cubits/add_transaction/add_transaction_form_cubit.dart';
import '../widgets/transaction_switcher.dart';

class AddTransactionsView extends StatefulWidget {
  const AddTransactionsView({super.key});

  @override
  State<AddTransactionsView> createState() => _AddTransactionsViewState();
}

class _AddTransactionsViewState extends State<AddTransactionsView> {
  late TextEditingController _amountController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  late TextEditingController _dateController;
  bool isAddIncome = true;

  @override
  void initState() {
    super.initState();

    _amountController = TextEditingController();
    _categoryController = TextEditingController();
    _descriptionController = TextEditingController();
    _dateController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddTransactionFormCubit>(
      create: (context) => sl(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
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
                  TransactionSwitcher(
                    isAddIncome: isAddIncome,
                    incomeOnTap: () => setState(() {
                      isAddIncome = true;
                    }),
                    expenseOnTap: () => setState(() {
                      isAddIncome = false;
                    }),
                  ),
                  mediumSeparator,
                  BlocBuilder<AddTransactionFormCubit, AddTransactionFormState>(
                    buildWhen: (previous, current) =>
                        previous.amount != current.amount,
                    builder: (context, state) {
                      _amountController.value = _amountController.value
                          .copyWith(text: state.amount.value);
                      return TextField(
                        controller: _amountController,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: smallText + 4,
                          foreground: Paint()
                            ..shader = buttonsGradient.createShader(
                                const Rect.fromLTWH(0, 0, 200, 70)),
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
                          errorText: state.amount.displayError?.errorMessage,
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
                                Radius.circular(60),
                              ),
                            ),
                          ),
                        ),
                        onChanged: (value) => context
                            .read<AddTransactionFormCubit>()
                            .onAmountChanged(value),
                      );
                    },
                  ),
                  mediumSeparator,
                  BlocBuilder<AddTransactionFormCubit, AddTransactionFormState>(
                    buildWhen: (previous, current) =>
                        previous.category != current.category,
                    builder: (context, state) {
                      _categoryController.value = _categoryController.value
                          .copyWith(text: state.category.value);
                      return DefaultTextField(
                        controller: _categoryController,
                        hintText: 'Category',
                        icon: Icons.category,
                        onChanged: (final String value) => context
                            .read<AddTransactionFormCubit>()
                            .onCategoryChanged(value),
                        errorText: state.category.displayError?.errorMessage,
                      );
                    },
                  ),
                  smallSeparator,
                  BlocBuilder<AddTransactionFormCubit, AddTransactionFormState>(
                    buildWhen: (previous, current) =>
                        previous.description != current.description,
                    builder: (context, state) {
                      _descriptionController.value = _descriptionController
                          .value
                          .copyWith(text: state.description.value);
                      return DefaultTextField(
                        controller: _descriptionController,
                        hintText: 'Description',
                        icon: Icons.book,
                        onChanged: (final String value) => context
                            .read<AddTransactionFormCubit>()
                            .onDescriptionChanged(value),
                        errorText: state.description.displayError?.errorMessage,
                      );
                    },
                  ),
                  smallSeparator,
                  BlocBuilder<AddTransactionFormCubit, AddTransactionFormState>(
                    buildWhen: (previous, current) =>
                        previous.date != current.date,
                    builder: (context, state) {
                      _dateController.value = _dateController.value
                          .copyWith(text: state.date.value);
                      return DefaultTextField(
                        controller: _dateController,
                        hintText: 'Date',
                        icon: Icons.calendar_month,
                        errorText: state.date.displayError?.errorMessage,
                        isReadOnly: true,
                        onTap: () async {
                          final pickedDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now(),
                          );
                          if (context.mounted && pickedDate != null) {
                            context
                                .read<AddTransactionFormCubit>()
                                .onDateChanged(
                                  DateFormat.yMMMd().format(pickedDate),
                                );
                          }
                        },
                      );
                    },
                  ),
                  const Expanded(child: SizedBox()),
                  BlocBuilder<AddTransactionFormCubit, AddTransactionFormState>(
                    builder: (context, state) {
                      return GradientElevatedButton(
                        onTap: () {
                          final bool isFormValid = context
                              .read<AddTransactionFormCubit>()
                              .validateForm();
                          if (isFormValid && isAddIncome) {
                            context.read<AccountBloc>().add(
                                  AccountAddIncomeEvent(
                                    incomeEntity: state.toIncomeEntity(),
                                  ),
                                );
                            context.pop();
                          }
                          if (isFormValid && !isAddIncome) {
                            context.read<AccountBloc>().add(
                                  AccountAddExpenseEvent(
                                    expenseEntity: state.toExpenseEntity(),
                                  ),
                                );
                            context.pop();
                          }
                          FocusManager.instance.primaryFocus?.unfocus();
                        },
                        displayWidget: const Text(
                          'Add',
                          style: TextStyle(
                            color: textLight,
                          ),
                        ),
                        borderRadius: xsSize,
                      );
                    },
                  ),
                  smallSeparator,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DefaultTextField extends StatelessWidget {
  const DefaultTextField({
    required this.controller,
    required this.hintText,
    required this.icon,
    this.onChanged,
    this.errorText,
    this.isReadOnly,
    this.onTap,
    super.key,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final OnFieldChanged? onChanged;
  final String? errorText;
  final bool? isReadOnly;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: textDark.withOpacity(0.5),
        ),
        hintText: hintText,
        errorText: errorText,
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
      readOnly: isReadOnly ?? false,
      onChanged: onChanged,
      onTap: onTap,
    );
  }
}

typedef OnFieldChanged = void Function(String value);
