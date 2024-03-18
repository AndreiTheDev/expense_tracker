import 'package:expense_tracker_app_bloc/src/features/home/data/dto/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/expense.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExpenseDto expenseDto;
  late ExpenseEntity expenseEntity;

  setUp(() {
    expenseDto = ExpenseDto(
      id: 'test',
      category: 'testCategory',
      description: 'testDescription',
      amount: 100,
      date: DateTime(1999),
    );
    expenseEntity = ExpenseEntity(
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
    'relatedDoc': '',
  };

  test('Expense is created from Json', () {
    final sut = ExpenseDto.fromJson(json);
    expect(sut, expenseDto);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(expenseDto.toJson(), json);
  });

  test('Correct Dto object is returned from fromEntity call', () {
    expect(ExpenseDto.fromEntity(expenseEntity), expenseDto);
  });
}
