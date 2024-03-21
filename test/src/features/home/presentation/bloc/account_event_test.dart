import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/transaction.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/bloc/account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final TransactionEntity transactionEntity = TransactionEntity(
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(2000),
  );
  final ExpenseEntity expenseEntity = ExpenseEntity(
    category: 'test',
    description: 'test',
    amount: -100,
    date: DateTime(2000),
  );
  final IncomeEntity incomeEntity = IncomeEntity(
    category: 'test',
    description: 'test',
    amount: -100,
    date: DateTime(2000),
  );

  test('AccountFetchEvent props are equal', () {
    const sut = AccountFetchEvent(accountId: 'test');
    expect(sut.props, ['test']);
  });

  test('AccountAddIncomeEvent props are equal', () {
    final sut = AccountAddIncomeEvent(
      accountId: 'test',
      incomeEntity: incomeEntity,
    );
    expect(sut.props, [incomeEntity, 'test']);
  });

  test('AccountAddExpenseEvent props are equal', () {
    final sut = AccountAddExpenseEvent(
      accountId: 'test',
      expenseEntity: expenseEntity,
    );
    expect(sut.props, [expenseEntity, 'test']);
  });

  test('AccountDeleteTransactionEvent props are equal', () {
    final sut = AccountDeleteTransactionEvent(
      accountId: 'test',
      transactionEntity: transactionEntity,
    );
    expect(sut.props, [transactionEntity, 'test']);
  });

  test('AccountErrorEvent props are equal', () {
    const sut = AccountErrorEvent(message: 'test');
    expect(sut.props, ['test']);
  });
}
