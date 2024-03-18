// ignore_for_file: lines_longer_than_80_chars

import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/delete_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_expense_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AccountRepository>()])
void main() {
  late DeleteExpense sut;
  late MockAccountRepository mockAccountRepository;
  final ExpenseEntity expenseEntity = ExpenseEntity(
    category: 'test',
    description: 'test',
    amount: -100,
    date: DateTime(2000),
  );
  const AccountEntity account = AccountEntity(
    id: 'test',
    name: 'test',
    income: 100,
    expenses: 100,
    totalBalance: 0,
    transactions: [],
  );

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    sut = DeleteExpense(mockAccountRepository);
  });

  test('DeleteExpense deletes the expense and returns new account entity',
      () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(const Right(account));
    when(
      mockAccountRepository.deleteExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount())
        .thenAnswer((realInvocation) async => const Right(account));

    final result = await sut('test', expenseEntity);

    expect(result, const Right(account));
    verify(
      mockAccountRepository.deleteExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).called(1);
    verify(mockAccountRepository.fetchAccount()).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test(
      'DeleteExpense fails to delete expense and returns failure for fetchaccount',
      () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(
      mockAccountRepository.deleteExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount()).thenAnswer(
      (realInvocation) async => const Left(HomeFailure(message: 'test')),
    );

    final result = await sut('test', expenseEntity);

    expect(result, const Left(HomeFailure(message: 'test')));
    verify(
      mockAccountRepository.deleteExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).called(1);
    verify(mockAccountRepository.fetchAccount()).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
