import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Test TransactionEntity constructor autogenerates Uuid', () {
    final sut = TransactionEntity(
      category: 'test',
      description: 'test',
      amount: 10,
      date: DateTime(1999),
    );
    expect(sut.id, isA<String>());
    expect(sut.id, isNotEmpty);
  });
}
