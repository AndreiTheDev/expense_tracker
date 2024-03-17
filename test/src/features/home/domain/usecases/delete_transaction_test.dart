// ignore_for_file: lines_longer_than_80_chars

import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/delete_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_transaction_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AccountRepository>()])
void main() {
  late DeleteTransaction sut;
  late MockAccountRepository mockAccountRepository;
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
    sut = DeleteTransaction(mockAccountRepository);
  });

  test(
      'DeleteTransaction deletes the transaction and returns new account entity',
      () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(const Right(account));
    when(
      mockAccountRepository.deleteTransaction(
        accountId: 'test',
        transactionId: 'test',
      ),
    ).thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount())
        .thenAnswer((realInvocation) async => const Right(account));

    final result = await sut('test', 'test');

    expect(result, const Right(account));
    verify(
      mockAccountRepository.deleteTransaction(
        accountId: 'test',
        transactionId: 'test',
      ),
    ).called(1);
    verify(mockAccountRepository.fetchAccount()).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test(
      'DeleteTransaction fails to delete transaction and returns failure for fetchaccount',
      () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(
      mockAccountRepository.deleteTransaction(
        accountId: 'test',
        transactionId: 'test',
      ),
    ).thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount()).thenAnswer(
      (realInvocation) async => const Left(HomeFailure(message: 'test')),
    );

    final result = await sut('test', 'test');

    expect(result, const Left(HomeFailure(message: 'test')));
    verify(
      mockAccountRepository.deleteTransaction(
        accountId: 'test',
        transactionId: 'test',
      ),
    ).called(1);
    verify(mockAccountRepository.fetchAccount()).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
