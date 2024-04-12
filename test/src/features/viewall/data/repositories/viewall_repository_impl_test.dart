import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/datasources/viewall_firebase_datasource.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/datasources/viewall_firestore_datasource.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/dtos/chart.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/dtos/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/dtos/expenses_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/dtos/income.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/dtos/incomes_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/repositories/viewall_repository_impl.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/income.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'viewall_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<ViewallFirebaseDataSourceImpl>(),
  MockSpec<ViewallFirestoreDataSourceImpl>(),
])
void main() {
  late ViewallRepositoryImpl sut;
  late MockViewallFirebaseDataSourceImpl mockFirebaseDataSource;
  late MockViewallFirestoreDataSourceImpl mockFirestoreDataSource;
  final ExpenseEntity expenseEntity = ExpenseEntity(
    id: 'test',
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(1999),
    relatedDoc: 'test',
  );
  final IncomeEntity incomeEntity = IncomeEntity(
    id: 'test',
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(1999),
    relatedDoc: 'test',
  );

  setUp(() {
    mockFirebaseDataSource = MockViewallFirebaseDataSourceImpl();
    mockFirestoreDataSource = MockViewallFirestoreDataSourceImpl();
    sut = ViewallRepositoryImpl(
      mockFirebaseDataSource,
      mockFirestoreDataSource,
    );
  });

  test('DeleteExpense returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.deleteExpense(
        'uid',
        'default',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenAnswer(
      (realInvocation) async => Future.new,
    );

    final response = await sut.deleteExpense(
      accountId: 'default',
      expenseEntity: expenseEntity,
    );
    expect(response, const Right(null));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteExpense(
        'uid',
        'default',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('DeleteExpense returns Failure because user is not signed in', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn(null);

    final response = await sut.deleteExpense(
      accountId: 'default',
      expenseEntity: expenseEntity,
    );
    expect(
      response,
      const Left(
        HomeFailure(message: 'Unable to delete this expense.'),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
  });

  test('DeleteExpense returns Failure from FirebaseException', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.deleteExpense(
        'uid',
        'default',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenThrow(
      FirebaseException(plugin: '', code: 'test'),
    );

    final response = await sut.deleteExpense(
      accountId: 'default',
      expenseEntity: expenseEntity,
    );
    expect(response, const Left(HomeFailure(message: 'test')));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteExpense(
        'uid',
        'default',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('DeleteExpense returns Failure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.deleteExpense(
        'uid',
        'default',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).thenThrow(
      Exception(),
    );

    final response = await sut.deleteExpense(
      accountId: 'default',
      expenseEntity: expenseEntity,
    );
    expect(
      response,
      const Left(HomeFailure(message: 'An unknown error occured.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteExpense(
        'uid',
        'default',
        ExpenseDto.fromEntity(expenseEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('DeleteIncome returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.deleteIncome(
        'uid',
        'default',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenAnswer(
      (realInvocation) async => Future.new,
    );

    final response = await sut.deleteIncome(
      accountId: 'default',
      incomeEntity: incomeEntity,
    );
    expect(response, const Right(null));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteIncome(
        'uid',
        'default',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('DeleteIncome returns Failure because user is not signed in', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn(null);

    final response = await sut.deleteIncome(
      accountId: 'default',
      incomeEntity: incomeEntity,
    );
    expect(
      response,
      const Left(HomeFailure(message: 'Unable to delete this income.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
  });

  test('DeleteIncome returns Failure from FirebaseException', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.deleteIncome(
        'uid',
        'default',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenThrow(
      FirebaseException(plugin: '', code: 'test'),
    );

    final response = await sut.deleteIncome(
      accountId: 'default',
      incomeEntity: incomeEntity,
    );
    expect(response, const Left(HomeFailure(message: 'test')));
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteIncome(
        'uid',
        'default',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('DeleteIncome returns Failure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.deleteIncome(
        'uid',
        'default',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).thenThrow(
      Exception(),
    );

    final response = await sut.deleteIncome(
      accountId: 'default',
      incomeEntity: incomeEntity,
    );
    expect(
      response,
      const Left(HomeFailure(message: 'An unknown error occured.')),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.deleteIncome(
        'uid',
        'default',
        IncomeDto.fromEntity(incomeEntity),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('FetchExpensesDetails returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.fetchExpensesList(
        'uid',
        'default',
      ),
    ).thenAnswer(
      (realInvocation) async => Future.value(
        [
          ExpenseDto.fromEntity(expenseEntity),
        ],
      ),
    );
    when(
      mockFirestoreDataSource.fetchExpensesChart(
        'uid',
        'default',
      ),
    ).thenAnswer(
      (realInvocation) async => Future.value(
        const ChartDto(monthlyList: [], maxMonthThreshold: 0),
      ),
    );

    final response = await sut.fetchExpensesDetails();
    expect(
      response,
      Right(
        ExpensesDetailsDto(
          expensesList: [ExpenseDto.fromEntity(expenseEntity)],
          expensesChart: const ChartDto(monthlyList: [], maxMonthThreshold: 0),
        ),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchExpensesList(
        'uid',
        'default',
      ),
    ).called(1);
    verify(
      mockFirestoreDataSource.fetchExpensesChart(
        'uid',
        'default',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('FetchExpensesDetails returns Failure because user is not signed in',
      () async {
    when(mockFirebaseDataSource.getUid()).thenReturn(null);

    final response = await sut.fetchExpensesDetails();
    expect(
      response,
      const Left(
        HomeFailure(message: 'Unable to fetch expenses.'),
      ),
    );

    verify(mockFirebaseDataSource.getUid()).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
  });

  test('FetchExpensesDetails returns Failure from FirebaseException', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.fetchExpensesList(
        'uid',
        'default',
      ),
    ).thenAnswer(
      (realInvocation) async => Future.value(
        [
          ExpenseDto.fromEntity(expenseEntity),
        ],
      ),
    );
    when(
      mockFirestoreDataSource.fetchExpensesChart(
        'uid',
        'default',
      ),
    ).thenThrow(FirebaseException(plugin: '', code: 'test'));

    final response = await sut.fetchExpensesDetails();
    expect(
      response,
      const Left(
        HomeFailure(message: 'test'),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchExpensesList(
        'uid',
        'default',
      ),
    ).called(1);
    verify(
      mockFirestoreDataSource.fetchExpensesChart(
        'uid',
        'default',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('FetchExpensesDetails returns Failure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.fetchExpensesList(
        'uid',
        'default',
      ),
    ).thenAnswer(
      (realInvocation) async => Future.value(
        [
          ExpenseDto.fromEntity(expenseEntity),
        ],
      ),
    );
    when(
      mockFirestoreDataSource.fetchExpensesChart(
        'uid',
        'default',
      ),
    ).thenThrow(Exception());

    final response = await sut.fetchExpensesDetails();
    expect(
      response,
      const Left(
        HomeFailure(message: 'An unknown error occured.'),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchExpensesList(
        'uid',
        'default',
      ),
    ).called(1);
    verify(
      mockFirestoreDataSource.fetchExpensesChart(
        'uid',
        'default',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('FetchIncomesDetails returns success', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.fetchIncomesList(
        'uid',
        'default',
      ),
    ).thenAnswer(
      (realInvocation) async => Future.value(
        [
          IncomeDto.fromEntity(incomeEntity),
        ],
      ),
    );
    when(
      mockFirestoreDataSource.fetchIncomesChart(
        'uid',
        'default',
      ),
    ).thenAnswer(
      (realInvocation) async =>
          Future.value(const ChartDto(monthlyList: [], maxMonthThreshold: 0)),
    );

    final response = await sut.fetchIncomesDetails();
    expect(
      response,
      Right(
        IncomesDetailsDto(
          incomesList: [IncomeDto.fromEntity(incomeEntity)],
          incomesChart: const ChartDto(monthlyList: [], maxMonthThreshold: 0),
        ),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchIncomesList(
        'uid',
        'default',
      ),
    ).called(1);
    verify(
      mockFirestoreDataSource.fetchIncomesChart(
        'uid',
        'default',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('FetchIncomesDetails returns Failure because user is not signed in',
      () async {
    when(mockFirebaseDataSource.getUid()).thenReturn(null);

    final response = await sut.fetchIncomesDetails();
    expect(
      response,
      const Left(
        HomeFailure(message: 'Unable to fetch incomes.'),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
  });

  test('FetchIncomesDetails returns Failure from FirebaseException', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.fetchIncomesList(
        'uid',
        'default',
      ),
    ).thenAnswer(
      (realInvocation) async => Future.value(
        [
          IncomeDto.fromEntity(incomeEntity),
        ],
      ),
    );
    when(
      mockFirestoreDataSource.fetchIncomesChart(
        'uid',
        'default',
      ),
    ).thenThrow(FirebaseException(plugin: '', code: 'test'));

    final response = await sut.fetchIncomesDetails();
    expect(
      response,
      const Left(
        HomeFailure(message: 'test'),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchIncomesList(
        'uid',
        'default',
      ),
    ).called(1);
    verify(
      mockFirestoreDataSource.fetchIncomesChart(
        'uid',
        'default',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('FetchIncomesDetails returns Failure from Exception', () async {
    when(mockFirebaseDataSource.getUid()).thenReturn('uid');
    when(
      mockFirestoreDataSource.fetchIncomesList(
        'uid',
        'default',
      ),
    ).thenAnswer(
      (realInvocation) async => Future.value(
        [
          IncomeDto.fromEntity(incomeEntity),
        ],
      ),
    );
    when(
      mockFirestoreDataSource.fetchIncomesChart(
        'uid',
        'default',
      ),
    ).thenThrow(Exception());

    final response = await sut.fetchIncomesDetails();
    expect(
      response,
      const Left(
        HomeFailure(message: 'An unknown error occured.'),
      ),
    );
    verify(mockFirebaseDataSource.getUid()).called(1);
    verify(
      mockFirestoreDataSource.fetchIncomesList(
        'uid',
        'default',
      ),
    ).called(1);
    verify(
      mockFirestoreDataSource.fetchIncomesChart(
        'uid',
        'default',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });
}
