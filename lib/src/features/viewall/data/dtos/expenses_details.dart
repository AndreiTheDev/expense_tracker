import '../../domain/entities/expenses_details.dart';
import 'chart.dart';
import 'expense.dart';

class ExpensesDetailsDto extends ExpensesDetailsEntity {
  const ExpensesDetailsDto({
    required super.expensesList,
    required super.expensesChart,
  });

  factory ExpensesDetailsDto.fromDtos(
    final List<ExpenseDto> expensesListDtos,
    final ChartDto expensesChartDto,
  ) {
    return ExpensesDetailsDto(
      expensesList: [
        ...expensesListDtos,
      ],
      expensesChart: expensesChartDto,
    );
  }
}
