import 'package:expense_tracker_app_bloc/src/features/home/data/dto/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TransactionDto transaction;

  setUp(() {
    transaction = TransactionDto(
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

  test('Transaction is created from Json', () {
    final sut = TransactionDto.fromJson(json);
    expect(sut, transaction);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(transaction.toJson(), json);
  });
}
