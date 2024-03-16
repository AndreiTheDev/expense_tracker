import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/add_income.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_income_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AccountRepository>()])
void main() {
  late AddIncome sut;
  late MockAccountRepository mockAccountRepository;
  const AccountEntity account = AccountEntity(
    id: 'test',
    name: 'test',
    income: 100,
    expenses: 100,
    totalBalance: 0,
    transactions: [],
  );
  final IncomeEntity incomeEntity = IncomeEntity(
    id: 'test',
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(2000),
  );

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    sut = AddIncome(mockAccountRepository);
  });

  test('AddIncome adds the income and returns new account entity', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(const Right(account));
    when(mockAccountRepository.addIncome(incomeEntity: incomeEntity))
        .thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount())
        .thenAnswer((realInvocation) async => const Right(account));

    final result = await sut(incomeEntity);

    expect(result, const Right(account));
    verify(mockAccountRepository.addIncome(incomeEntity: incomeEntity))
        .called(1);
    verify(mockAccountRepository.fetchAccount()).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test('AddIncome fails to add income and returns failure for fetchaccount',
      () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(mockAccountRepository.addIncome(incomeEntity: incomeEntity))
        .thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount()).thenAnswer(
        (realInvocation) async => const Left(HomeFailure(message: 'test')));

    final result = await sut(incomeEntity);

    expect(result, const Left(HomeFailure(message: 'test')));
    verify(mockAccountRepository.addIncome(incomeEntity: incomeEntity))
        .called(1);
    verify(mockAccountRepository.fetchAccount()).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
