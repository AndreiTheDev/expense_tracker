import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/dtos/income.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/income.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IncomeDto incomeDto;
  late IncomeEntity incomeEntity;

  setUp(() {
    incomeDto = IncomeDto(
      id: 'test',
      category: 'testCategory',
      description: 'testDescription',
      amount: 100,
      date: DateTime.fromMillisecondsSinceEpoch(
        Timestamp(0, 0).millisecondsSinceEpoch,
      ),
      relatedDoc: 'testDoc',
    );
    incomeEntity = IncomeEntity(
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

  test('Income is created from Json', () {
    final sut = IncomeDto.fromJson(creationJson);
    expect(sut, incomeDto);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(incomeDto.toJson(), expectedJson);
  });

  test('Correct Dto object is returned from fromEntity call', () {
    expect(IncomeDto.fromEntity(incomeEntity), incomeDto);
  });
}
