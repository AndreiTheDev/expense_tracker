import 'package:equatable/equatable.dart';

import 'chart.dart';
import 'expense.dart';

class ExpensesDetailsEntity extends Equatable {
  final List<ExpenseEntity> expensesList;
  final ChartEntity? expensesChart;

  const ExpensesDetailsEntity({
    required this.expensesList,
    this.expensesChart,
  });

  @override
  List<Object?> get props => [expensesList, expensesChart];
}
