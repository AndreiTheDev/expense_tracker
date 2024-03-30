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
      (realInvocation) async => Future.value(ChartDto()),
    );

    final response = await sut.fetchExpensesDetails();
    expect(
      response,
      Right(
        ExpensesDetailsDto(
          expensesList: [ExpenseDto.fromEntity(expenseEntity)],
        ),
      ),
    );
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
      (realInvocation) async => Future.value(ChartDto()),
    );

    final response = await sut.fetchIncomesDetails();
    expect(
      response,
      Right(
        IncomesDetailsDto(
          incomesList: [IncomeDto.fromEntity(incomeEntity)],
        ),
      ),
    );
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
  });
}
