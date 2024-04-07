import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/monthly_chart_data.dart';

class MonthlyChartDataDto extends MonthlyChartDataEntity {
  const MonthlyChartDataDto({
    required super.balance,
    required super.date,
  });

  factory MonthlyChartDataDto.fromJson(final Map<String, dynamic> json) {
    final Timestamp date = json['date'];
    return MonthlyChartDataDto(
      balance: json['balance'],
      date: date.toDate(),
    );
  }
}
