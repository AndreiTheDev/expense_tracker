import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/monthly_chart_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MonthlyChartDataEntity sut;

  setUp(() {
    sut = MonthlyChartDataEntity(
      balance: 200,
      date: DateTime(2000),
    );
  });

  test('MonthlyChartDataEntity props do not change', () {
    expect(
      sut.props,
      [
        200,
        DateTime(2000),
      ],
    );
  });
}
