import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/chart.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expenses_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExpensesDetailsEntity sut;

  setUp(() {
    sut = const ExpensesDetailsEntity(
      expensesList: [],
      expensesChart: ChartEntity(monthlyList: []),
    );
  });

  test('ExpensesDetailsEntity props do not change', () {
    expect(
      sut.props,
      [
        const [],
        const ChartEntity(monthlyList: []),
      ],
    );
  });
}
