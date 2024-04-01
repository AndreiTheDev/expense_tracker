import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TransactionEntity sut;

  setUp(() {
    sut = TransactionEntity(
      id: 'id',
      category: 'category',
      description: 'description',
      amount: 100,
      date: DateTime(1999),
      relatedDoc: 'relatedDoc',
    );
  });

  test('IncomeEntity props do not change', () {
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
