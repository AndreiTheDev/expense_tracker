import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/presentation/blocs/viewall_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final ExpenseEntity expenseEntity = ExpenseEntity(
    id: 'testId',
    category: 'testCategory',
    description: 'testDescription',
    amount: -100,
    date: DateTime(2000),
    relatedDoc: 'testDoc',
  );
  final IncomeEntity incomeEntity = IncomeEntity(
    id: 'testId',
    category: 'testCategory',
    description: 'testDescription',
    amount: 100,
    date: DateTime(2000),
    relatedDoc: 'testDoc',
  );

  test('ViewallDeleteExpenseEvent props are equal', () {
    final sut = ViewallDeleteExpenseEvent(
      accountId: 'test',
      expenseEntity: expenseEntity,
    );
    expect(sut.props, ['test', expenseEntity]);
  });

  test('ViewallDeleteIncomeEvent props are equal', () {
    final sut = ViewallDeleteIncomeEvent(
      accountId: 'test',
      incomeEntity: incomeEntity,
    );
    expect(sut.props, ['test', incomeEntity]);
  });

  test('ViewallFetchExpensesDetailsEvent props are equal', () {
    const sut = ViewallFetchExpensesDetailsEvent(
      accountId: 'test',
    );
    expect(sut.props, ['test']);
  });

  test('ViewallFetchIncomesDetailsEvent props are equal', () {
    const sut = ViewallFetchIncomesDetailsEvent(
      accountId: 'test',
    );
    expect(sut.props, ['test']);
  });
}
