// ignore_for_file: lines_longer_than_80_chars

import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/delete_income.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_income_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AccountRepository>()])
void main() {
  late DeleteIncome sut;
  late MockAccountRepository mockAccountRepository;
  final IncomeEntity incomeEntity = IncomeEntity(
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
    sut = DeleteIncome(mockAccountRepository);
  });

  test('DeleteIncome deletes the income and returns new account entity',
      () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(const Right(account));
    when(
      mockAccountRepository.deleteIncome(
        accountId: 'test',
        incomeEntity: incomeEntity,
      ),
    ).thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount())
        .thenAnswer((realInvocation) async => const Right(account));

    final result = await sut('test', incomeEntity);

    expect(result, const Right(account));
    verify(
      mockAccountRepository.deleteIncome(
        accountId: 'test',
        incomeEntity: incomeEntity,
      ),
    ).called(1);
    verify(mockAccountRepository.fetchAccount(accountId: 'test')).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test(
      'DeleteIncome fails to delete income and returns failure for fetchaccount',
      () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(
      mockAccountRepository.deleteIncome(
        accountId: 'test',
        incomeEntity: incomeEntity,
      ),
    ).thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount()).thenAnswer(
      (realInvocation) async => const Left(HomeFailure(message: 'test')),
    );

    final result = await sut('test', incomeEntity);

    expect(result, const Left(HomeFailure(message: 'test')));
    verify(
      mockAccountRepository.deleteIncome(
        accountId: 'test',
        incomeEntity: incomeEntity,
      ),
    ).called(1);
    verify(mockAccountRepository.fetchAccount(accountId: 'test')).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
