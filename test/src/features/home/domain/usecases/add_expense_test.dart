import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/add_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_expense_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AccountRepository>()])
void main() {
  late AddExpense sut;
  late MockAccountRepository mockAccountRepository;
  const AccountEntity account = AccountEntity(
    id: 'test',
    name: 'test',
    income: 100,
    expenses: 100,
    totalBalance: 0,
    transactions: [],
  );
  final ExpenseEntity expenseEntity = ExpenseEntity(
    id: 'test',
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(2000),
  );

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    sut = AddExpense(mockAccountRepository);
  });

  test('AddExpense adds the expense and returns new account entity', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(const Right(account));
    when(
      mockAccountRepository.addExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).thenAnswer((realInvocation) async => const Right(null));
    when(mockAccountRepository.fetchAccount())
        .thenAnswer((realInvocation) async => const Right(account));

    final result = await sut('test', expenseEntity);

    expect(result, const Right(account));
    verify(
      mockAccountRepository.addExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).called(1);
    verify(mockAccountRepository.fetchAccount()).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test('AddExpense fails to add expense and returns failure for fetchaccount',
      () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    provideDummy<Either<Failure, AccountEntity>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(
      mockAccountRepository.addExpense(
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
      mockAccountRepository.addExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).called(1);
    verify(mockAccountRepository.fetchAccount()).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
