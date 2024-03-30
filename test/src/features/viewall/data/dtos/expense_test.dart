import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/dtos/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expense.dart';
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
      date: DateTime.fromMillisecondsSinceEpoch(
        Timestamp(0, 0).millisecondsSinceEpoch,
      ),
      relatedDoc: 'testDoc',
    );
    expenseEntity = ExpenseEntity(
      id: 'test',
      category: 'testCategory',
      description: 'testDescription',
      amount: 100,
      date: DateTime.fromMillisecondsSinceEpoch(
        Timestamp(0, 0).millisecondsSinceEpoch,
      ),
      relatedDoc: 'testDoc',
    );
  });

  final creationJson = {
    'id': 'test',
    'category': 'testCategory',
    'description': 'testDescription',
    'amount': 100.0,
    'date': Timestamp(0, 0),
    'relatedDoc': 'testDoc',
  };
  final expectedJson = {
    'id': 'test',
    'category': 'testCategory',
    'description': 'testDescription',
    'amount': 100.0,
    'date': DateTime.fromMillisecondsSinceEpoch(
      Timestamp(0, 0).millisecondsSinceEpoch,
    ),
    'relatedDoc': 'testDoc',
  };

  test('Expense is created from Json', () {
    final sut = ExpenseDto.fromJson(creationJson);
    expect(sut, expenseDto);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(expenseDto.toJson(), expectedJson);
  });

  test('Correct Dto object is returned from fromEntity call', () {
    expect(ExpenseDto.fromEntity(expenseEntity), expenseDto);
  });
}
