import 'package:equatable/equatable.dart';

import 'chart.dart';
import 'income.dart';

class IncomesDetailsEntity extends Equatable {
  final List<IncomeEntity> incomesList;
  final ChartEntity incomesChart;

  const IncomesDetailsEntity({
    required this.incomesList,
    required this.incomesChart,
  });

  @override
  List<Object> get props => [incomesList, incomesChart];
}
