import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/chart.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ChartEntity sut;

  setUp(() {
    sut = ChartEntity();
  });

  test('ChartEntity props do not change', () {
    expect(
      sut.props,
      [],
    );
  });
}
