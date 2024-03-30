import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expense.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ExpenseEntity sut;

  setUp(() {
    sut = ExpenseEntity(
      id: 'id',
      category: 'category',
      description: 'description',
      amount: 100,
      date: DateTime(1999),
      relatedDoc: 'relatedDoc',
    );
  });

  test('ExpenseEntity props do not change', () {
    expect(
      sut.props,
      [
        'id',
        'category',
        'description',
        100,
        DateTime(1999),
        'relatedDoc',
      ],
    );
  });
}
