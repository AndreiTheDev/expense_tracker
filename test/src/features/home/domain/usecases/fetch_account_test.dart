import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/fetch_account.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_account_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AccountRepository>()])
void main() {
  late FetchAccount sut;
  late MockAccountRepository mockAccountRepository;
  const AccountEntity entity = AccountEntity(
    id: 'test',
    name: 'test',
    income: 100,
    expenses: 100,
    totalBalance: 0,
    transactions: [],
  );

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    sut = FetchAccount(mockAccountRepository);
  });

  test('FetchAccount returns success', () async {
    provideDummy<Either<Failure, AccountEntity>>(const Right(entity));
    when(mockAccountRepository.fetchAccount())
        .thenAnswer((realInvocation) async => const Right(entity));

    final result = await sut('test');

    expect(result, const Right(entity));
    verify(mockAccountRepository.fetchAccount(id: 'test')).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test('FetchAccount returns failure', () async {
    provideDummy<Either<Failure, AccountEntity>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(mockAccountRepository.fetchAccount()).thenAnswer(
      (realInvocation) async => const Left(HomeFailure(message: 'test')),
    );

    final result = await sut('test');

    expect(result, const Left(HomeFailure(message: 'test')));
    verify(mockAccountRepository.fetchAccount(id: 'test')).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
