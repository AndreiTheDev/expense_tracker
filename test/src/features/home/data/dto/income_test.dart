import 'package:expense_tracker_app_bloc/src/features/home/data/dto/income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/income.dart';
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
      date: DateTime(1999),
    );
    incomeEntity = IncomeEntity(
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

  test('Income is created from Json', () {
    final sut = IncomeDto.fromJson(json);
    expect(sut, incomeDto);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(incomeDto.toJson(), json);
  });

  test('Correct Dto object is returned from fromEntity call', () {
    expect(IncomeDto.fromEntity(incomeEntity), incomeDto);
  });
}
