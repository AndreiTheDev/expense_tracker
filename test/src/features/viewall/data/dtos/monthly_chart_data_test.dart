import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/dtos/monthly_chart_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MonthlyChartDataDto monthlyChartDataDto;

  setUp(() {
    monthlyChartDataDto = MonthlyChartDataDto(
      balance: 200,
      date: DateTime.fromMillisecondsSinceEpoch(
        Timestamp(0, 0).millisecondsSinceEpoch,
      ),
    );
  });

  final creationJson = {
    'total': 200,
    'filterDate': Timestamp(0, 0),
  };

  test('MonthlyChartDataDto is created from Json', () {
    final sut = MonthlyChartDataDto.fromJson(creationJson);
    expect(sut, monthlyChartDataDto);
  });
}
