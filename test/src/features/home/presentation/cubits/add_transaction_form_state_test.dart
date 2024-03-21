import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/cubits/add_transaction/add_transaction_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/models/amount.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/models/category.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/models/date.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/models/description.dart'
    as description;
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  late AddTransactionFormState sut;

  setUp(() {
    sut = AddTransactionFormState(
      amount: const Amount.dirty(value: '100'),
      category: const Category.dirty(value: 'test'),
      description: const description.Description.dirty(value: 'test'),
      date: Date.dirty(value: DateFormat.yMMMd().format(DateTime(2000))),
    );
  });

  test(
    'AddTransactionFormState toIncomeEntity returns an income entity',
    () {
      final response = sut.toIncomeEntity();
      expect(response, isA<IncomeEntity>());
    },
  );

  test(
    'AddTransactionFormState toExpenseEntity returns an expense entity',
    () {
      final response = sut.toExpenseEntity();
      expect(response, isA<ExpenseEntity>());
    },
  );
}
