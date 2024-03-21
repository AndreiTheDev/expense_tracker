import 'package:expense_tracker_app_bloc/src/features/home/data/dto/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AccountDto account;

  setUp(() {
    account = const AccountDto(
      id: 'testId',
      name: 'test',
      income: 100,
      expenses: 100,
      totalBalance: 0,
      transactions: [],
    );
  });

  final json = {
    'id': 'testId',
    'name': 'test',
    'income': 100.0,
    'expenses': 100.0,
    'totalBalance': 0.0,
    'transactions': <TransactionEntity>[],
  };

  test('Account is created from Json', () {
    final sut = AccountDto.fromJson(json);
    expect(sut, account);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(account.toJson(), json);
  });
}
