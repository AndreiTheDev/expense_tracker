import 'package:expense_tracker_app_bloc/src/features/home/data/dto/expense.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExpenseDto expense;

  setUp(() {
    expense = ExpenseDto(
      category: 'testCategory',
      description: 'testDescription',
      amount: 100,
      date: DateTime(1999),
    );
  });

  final json = {
    'category': 'testCategory',
    'description': 'testDescription',
    'amount': 100.0,
    'date': DateTime(1999),
  };

  test('Expense is created from Json', () {
    final sut = ExpenseDto.fromJson(json);
    expect(sut, expense);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(expense.toJson(), json);
  });
}
