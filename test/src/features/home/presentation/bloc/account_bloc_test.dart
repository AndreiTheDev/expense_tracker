import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/transaction.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/add_expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/add_income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/delete_transaction.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/fetch_account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/bloc/account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'account_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AddExpense>(),
  MockSpec<AddIncome>(),
  MockSpec<DeleteTransaction>(),
  MockSpec<FetchAccount>(),
])
void main() {
  late MockAddExpense mockAddExpense;
  late MockAddIncome mockAddIncome;
  late MockDeleteTransaction mockDeleteTransaction;
  late MockFetchAccount mockFetchAccount;
  late AccountBloc accountBloc;

  final TransactionEntity transactionEntity = TransactionEntity(
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(2000),
  );
  final ExpenseEntity expenseEntity = ExpenseEntity(
    category: 'test',
    description: 'test',
    amount: -100,
    date: DateTime(2000),
  );
  final IncomeEntity incomeEntity = IncomeEntity(
    category: 'test',
    description: 'test',
    amount: -100,
    date: DateTime(2000),
  );
  const AccountEntity accountEntity = AccountEntity(
    id: 'test',
    name: 'test',
    income: 100,
    expenses: -100,
    totalBalance: 0,
    transactions: [],
  );

  setUp(() {
    mockAddExpense = MockAddExpense();
    mockAddIncome = MockAddIncome();
    mockDeleteTransaction = MockDeleteTransaction();
    mockFetchAccount = MockFetchAccount();
    accountBloc = AccountBloc(
      fetchAccount: mockFetchAccount,
      addIncome: mockAddIncome,
      addExpense: mockAddExpense,
      deleteTransaction: mockDeleteTransaction,
    );
  });

  blocTest(
    'Fetch account returns AccountLoaded state',
    build: () => accountBloc,
    setUp: () async {
      provideDummy<Either<Failure, AccountEntity>>(const Right(accountEntity));
      when(mockFetchAccount.call(accountId: 'test'))
          .thenAnswer((realInvocation) async => const Right(accountEntity));
    },
    act: (bloc) => bloc.add(const AccountFetchEvent()),
    expect: () => [AccountLoading(), const AccountLoaded(accountEntity)],
  );

  blocTest(
    'Fetch account returns AccountError state',
    build: () => accountBloc,
    setUp: () async {
      provideDummy<Either<Failure, AccountEntity>>(
        const Left(HomeFailure(message: 'test')),
      );
      when(mockFetchAccount.call(accountId: 'test')).thenAnswer(
        (realInvocation) async => const Left(HomeFailure(message: 'test')),
      );
    },
    act: (bloc) => bloc.add(const AccountFetchEvent()),
    expect: () => [AccountLoading(), AccountError()],
  );

  blocTest(
    'Add income returns AccountLoaded state',
    build: () => accountBloc,
    setUp: () async {
      provideDummy<Either<Failure, AccountEntity>>(const Right(accountEntity));
      when(
        mockAddIncome.call(accountId: 'test', incomeEntity: incomeEntity),
      ).thenAnswer((realInvocation) async => const Right(accountEntity));
    },
    act: (bloc) => bloc.add(AccountAddIncomeEvent(incomeEntity: incomeEntity)),
    expect: () => [AccountLoading(), const AccountLoaded(accountEntity)],
  );

  blocTest(
    'Add income returns AccountError state',
    build: () => accountBloc,
    setUp: () async {
      provideDummy<Either<Failure, AccountEntity>>(
        const Left(HomeFailure(message: 'test')),
      );
      when(
        mockAddIncome.call(accountId: 'test', incomeEntity: incomeEntity),
      ).thenAnswer(
        (realInvocation) async => const Left(HomeFailure(message: 'test')),
      );
    },
    act: (bloc) => bloc.add(AccountAddIncomeEvent(incomeEntity: incomeEntity)),
    expect: () => [AccountLoading(), AccountError()],
  );

  blocTest(
    'Add Expense returns AccountLoaded state',
    build: () => accountBloc,
    setUp: () async {
      provideDummy<Either<Failure, AccountEntity>>(const Right(accountEntity));
      when(
        mockAddExpense.call(accountId: 'test', expenseEntity: expenseEntity),
      ).thenAnswer((realInvocation) async => const Right(accountEntity));
    },
    act: (bloc) =>
        bloc.add(AccountAddExpenseEvent(expenseEntity: expenseEntity)),
    expect: () => [AccountLoading(), const AccountLoaded(accountEntity)],
  );

  blocTest(
    'Add expense returns AccountError state',
    build: () => accountBloc,
    setUp: () async {
      provideDummy<Either<Failure, AccountEntity>>(
        const Left(HomeFailure(message: 'test')),
      );
      when(
        mockAddExpense.call(accountId: 'test', expenseEntity: expenseEntity),
      ).thenAnswer(
        (realInvocation) async => const Left(HomeFailure(message: 'test')),
      );
    },
    act: (bloc) => bloc.add(
      AccountAddExpenseEvent(expenseEntity: expenseEntity),
    ),
    expect: () => [AccountLoading(), AccountError()],
  );

  blocTest(
    'Delete Transaction returns AccountLoaded state',
    build: () => accountBloc,
    setUp: () async {
      provideDummy<Either<Failure, AccountEntity>>(const Right(accountEntity));
      when(
        mockDeleteTransaction.call(
          accountId: 'test',
          transactionEntity: transactionEntity,
        ),
      ).thenAnswer((realInvocation) async => const Right(accountEntity));
    },
    act: (bloc) => bloc.add(
      AccountDeleteTransactionEvent(transactionEntity: transactionEntity),
    ),
    expect: () => [AccountLoading(), const AccountLoaded(accountEntity)],
  );

  blocTest(
    'Delete Transaction returns AccountError state',
    build: () => accountBloc,
    setUp: () async {
      provideDummy<Either<Failure, AccountEntity>>(
        const Left(HomeFailure(message: 'test')),
      );
      when(
        mockDeleteTransaction.call(
            accountId: 'test', transactionEntity: transactionEntity),
      ).thenAnswer(
        (realInvocation) async => const Left(HomeFailure(message: 'test')),
      );
    },
    act: (bloc) => bloc.add(
      AccountDeleteTransactionEvent(transactionEntity: transactionEntity),
    ),
    expect: () => [AccountLoading(), AccountError()],
  );
}
