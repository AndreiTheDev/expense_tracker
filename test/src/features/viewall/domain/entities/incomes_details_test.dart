import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/chart.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/incomes_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IncomesDetailsEntity sut;

  setUp(() {
    sut = IncomesDetailsEntity(
      incomesList: const [],
      incomesChart: ChartEntity(),
    );
  });

  test('IncomesDetailsEntity props do not change', () {
    expect(
      sut.props,
      [
        const [],
        ChartEntity(),
      ],
    );
  });
}
