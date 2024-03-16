import 'package:expense_tracker_app_bloc/src/features/home/data/dto/income.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IncomeDto income;

  setUp(() {
    income = IncomeDto(
      id: 'test',
      category: 'testCategory',
      description: 'testDescription',
      amount: 100,
      date: DateTime(1999),
    );
  });

  final json = {
    'id': 'test',
    'category': 'testCategory',
    'description': 'testDescription',
    'amount': 100.0,
    'date': DateTime(1999),
  };

  test('Income is created from Json', () {
    final sut = IncomeDto.fromJson(json);
    expect(sut, income);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(income.toJson(), json);
  });
}
