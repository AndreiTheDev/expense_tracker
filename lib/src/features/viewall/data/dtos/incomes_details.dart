import '../../domain/entities/incomes_details.dart';
import 'chart.dart';
import 'income.dart';

class IncomesDetailsDto extends IncomesDetailsEntity {
  const IncomesDetailsDto({
    required super.incomesList,
    required super.incomesChart,
  });

  factory IncomesDetailsDto.fromDtos(
    final List<IncomeDto> incomesListDtos,
    final ChartDto incomesChartDto,
  ) {
    return IncomesDetailsDto(
      incomesList: [
        ...incomesListDtos,
      ],
      incomesChart: incomesChartDto,
    );
  }
}
