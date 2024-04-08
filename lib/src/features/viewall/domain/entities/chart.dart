// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'monthly_chart_data.dart';

class ChartEntity extends Equatable {
  final List<MonthlyChartDataEntity> monthlyList;
  final double maxMonthThreshold;

  const ChartEntity({
    required this.monthlyList,
    required this.maxMonthThreshold,
  });

  @override
  List<Object?> get props => [monthlyList, maxMonthThreshold];
}
