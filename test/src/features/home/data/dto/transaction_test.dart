import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/dto/transaction.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late TransactionDto transactionDto;
  late TransactionEntity transactionEntity;

  setUp(() {
    transactionDto = TransactionDto(
      id: 'test',
      category: 'testCategory',
      description: 'testDescription',
      amount: 100,
      date: DateTime.fromMillisecondsSinceEpoch(
        Timestamp(0, 0).millisecondsSinceEpoch,
      ),
    );
    transactionEntity = TransactionEntity(
      id: 'test',
      category: 'testCategory',
      description: 'testDescription',
      amount: 100,
      date: DateTime.fromMillisecondsSinceEpoch(
        Timestamp(0, 0).millisecondsSinceEpoch,
      ),
    );
  });

  final creationJson = {
    'id': 'test',
    'category': 'testCategory',
    'description': 'testDescription',
    'amount': 100.0,
    'date': Timestamp(0, 0),
    'relatedDoc': '',
  };
  final expectedJson = {
    'id': 'test',
    'category': 'testCategory',
    'description': 'testDescription',
    'amount': 100.0,
    'date': DateTime.fromMillisecondsSinceEpoch(
      Timestamp(0, 0).millisecondsSinceEpoch,
    ),
    'relatedDoc': '',
  };

  test('Transaction is created from Json', () {
    final sut = TransactionDto.fromJson(creationJson);
    expect(sut, transactionDto);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(transactionDto.toJson(), expectedJson);
  });

  test('Correct Dto object is returned from fromEntity call', () {
    expect(TransactionDto.fromEntity(transactionEntity), transactionDto);
  });
}
