import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/datasources/home_firebase_datasource.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/datasources/home_firestore_datasource.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/dto/account.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/dto/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/dto/income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/dto/transaction.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/repositories/account_repository_impl.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'account_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<HomeFirebaseDataScource>(),
    MockSpec<HomeFirestoreDataSource>(),
  ],
)
void main() {
  late AccountRepositoryImpl sut;
  late MockHomeFirebaseDataScource mockFirebaseDataSource;
  late MockHomeFirestoreDataSource mockFirestoreDataSource;
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
  setUp(() {
    mockFirebaseDataSource = MockHomeFirebaseDataScource();
    mockFirestoreDataSource = MockHomeFirestoreDataSource();
    sut = AccountRepositoryImpl(
      mockFirebaseDataSource,
      mockFirestoreDataSource,
    );
  });

  test('Delete transaction returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteTransaction(
        'test',
        'test',
        TransactionDto.fromEntity(transactionEntity),
      ),
    ).thenAnswer((realInvocation) async => Future(() => null));

    final response = await sut.deleteTransaction(
      accountId: 'test',
      transactionEntity: transactionEntity,
    );
    expect(response, const Right(null));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteTransaction(
        'test',
        'test',
        TransactionDto.fromEntity(transactionEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Delete transaction returns HomeFailure from Firebase Exception',
      () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteTransaction(
        'test',
        'test',
        TransactionDto.fromEntity(transactionEntity),
      ),
    ).thenThrow(FirebaseException(plugin: '', code: 'test'));

    final response = await sut.deleteTransaction(
      accountId: 'test',
      transactionEntity: transactionEntity,
    );
    expect(response, const Left(HomeFailure(message: 'test')));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteTransaction(
        'test',
        'test',
        TransactionDto.fromEntity(transactionEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Delete transaction returns HomeFailure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteTransaction(
        'test',
        'test',
        TransactionDto.fromEntity(transactionEntity),
      ),
    ).thenThrow(Exception());

    final response = await sut.deleteTransaction(
      accountId: 'test',
      transactionEntity: transactionEntity,
    );
    expect(
      response,
      const Left(HomeFailure(message: 'An unknown error occured.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteTransaction(
        'test',
        'test',
        TransactionDto.fromEntity(transactionEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Fetch Account returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.fetchAccountDetails(
        'test',
        'test',
      ),
    ).thenAnswer(
      (realInvocation) async => Future(
        () => {
          'id': 'test',
          'name': 'test',
          'income': 100.toDouble(),
          'expenses': 100.toDouble(),
          'totalBalance': 0.toDouble(),
        },
      ),
    );
    when(
      mockFirestoreDataSource.fetchAccountTransactions(
        'test',
        'test',
      ),
    ).thenAnswer(
      (realInvocation) async => Future(
        () => [],
      ),
    );

    final response = await sut.fetchAccount(
      accountId: 'test',
    );
    expect(
      response,
      const Right(
        AccountDto(
          id: 'test',
          name: 'test',
          income: 100,
          expenses: 100,
          totalBalance: 0,
          transactions: [],
        ),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchAccountDetails(
        'test',
        'test',
      ),
    ).called(1);
    verify(
      mockFirestoreDataSource.fetchAccountTransactions(
        'test',
        'test',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Fetch Account returns HomeFailure from FirebaseException', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.fetchAccountDetails(
        'test',
        'test',
      ),
    ).thenThrow(FirebaseException(plugin: '', code: 'test'));

    final response = await sut.fetchAccount(
      accountId: 'test',
    );
    expect(response, const Left(HomeFailure(message: 'test')));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchAccountDetails(
        'test',
        'test',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Fetch Account returns HomeFailure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.fetchAccountDetails(
        'test',
        'test',
      ),
    ).thenThrow(Exception());

    final response = await sut.fetchAccount(
      accountId: 'test',
    );
    expect(
      response,
      const Left(HomeFailure(message: 'An unknown error occured.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchAccountDetails(
        'test',
        'test',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Add expense returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.addExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenAnswer((realInvocation) async => Future(() => null));

    final response = await sut.addExpense(
      accountId: 'test',
      expenseEntity: expenseEntity,
    );
    expect(response, const Right(null));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.addExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Add expense returns HomeFailure from Firebase Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.addExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenThrow(FirebaseException(plugin: '', code: 'test'));

    final response = await sut.addExpense(
      accountId: 'test',
      expenseEntity: expenseEntity,
    );
    expect(response, const Left(HomeFailure(message: 'test')));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.addExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Add expense returns HomeFailure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.addExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenThrow(Exception());

    final response = await sut.addExpense(
      accountId: 'test',
      expenseEntity: expenseEntity,
    );
    expect(
      response,
      const Left(HomeFailure(message: 'An unknown error occured.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.addExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Add income returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.addIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenAnswer((realInvocation) async => Future(() => null));

    final response = await sut.addIncome(
      accountId: 'test',
      incomeEntity: incomeEntity,
    );
    expect(response, const Right(null));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.addIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Add income returns HomeFailure from Firebase Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.addIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenThrow(FirebaseException(plugin: '', code: 'test'));

    final response = await sut.addIncome(
      accountId: 'test',
      incomeEntity: incomeEntity,
    );
    expect(response, const Left(HomeFailure(message: 'test')));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.addIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Add income returns HomeFailure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.addIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenThrow(Exception());

    final response = await sut.addIncome(
      accountId: 'test',
      incomeEntity: incomeEntity,
    );
    expect(
      response,
      const Left(HomeFailure(message: 'An unknown error occured.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.addIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Delete expense returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenAnswer((realInvocation) async => Future(() => null));

    final response = await sut.deleteExpense(
      accountId: 'test',
      expenseEntity: expenseEntity,
    );
    expect(response, const Right(null));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Delete expense returns HomeFailure from Firebase Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenThrow(FirebaseException(plugin: '', code: 'test'));

    final response = await sut.deleteExpense(
      accountId: 'test',
      expenseEntity: expenseEntity,
    );
    expect(response, const Left(HomeFailure(message: 'test')));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Delete expense returns HomeFailure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenThrow(Exception());

    final response = await sut.deleteExpense(
      accountId: 'test',
      expenseEntity: expenseEntity,
    );
    expect(
      response,
      const Left(HomeFailure(message: 'An unknown error occured.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteExpense(
        'test',
        'test',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Delete income returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenAnswer((realInvocation) async => Future(() => null));

    final response = await sut.deleteIncome(
      accountId: 'test',
      incomeEntity: incomeEntity,
    );
    expect(response, const Right(null));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Delete income returns HomeFailure from Firebase Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenThrow(FirebaseException(plugin: '', code: 'test'));

    final response = await sut.deleteIncome(
      accountId: 'test',
      incomeEntity: incomeEntity,
    );
    expect(response, const Left(HomeFailure(message: 'test')));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Delete income returns HomeFailure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('test');
    when(
      mockFirestoreDataSource.deleteIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenThrow(Exception());

    final response = await sut.deleteIncome(
      accountId: 'test',
      incomeEntity: incomeEntity,
    );
    expect(
      response,
      const Left(HomeFailure(message: 'An unknown error occured.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteIncome(
        'test',
        'test',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });
}
