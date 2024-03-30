// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expenses_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/incomes_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/usecases/delete_expense.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/usecases/delete_income.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/usecases/fetch_expenses_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/usecases/fetch_incomes_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/presentation/blocs/viewall_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'viewall_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<DeleteExpense>(),
  MockSpec<DeleteIncome>(),
  MockSpec<FetchExpensesDetails>(),
  MockSpec<FetchIncomesDetails>(),
])
void main() {
  late MockDeleteExpense mockDeleteExpense;
  late MockDeleteIncome mockDeleteIncome;
  late MockFetchExpensesDetails mockFetchExpensesDetails;
  late MockFetchIncomesDetails mockFetchIncomesDetails;
  late ViewallBloc viewallBloc;
  final ExpenseEntity expenseEntity = ExpenseEntity(
    id: 'testId',
    category: 'testCategory',
    description: 'testDescription',
    amount: -100,
    date: DateTime(2000),
    relatedDoc: 'testDoc',
  );
  final IncomeEntity incomeEntity = IncomeEntity(
    id: 'testId',
    category: 'testCategory',
    description: 'testDescription',
    amount: -100,
    date: DateTime(2000),
    relatedDoc: 'testDoc',
  );

  setUp(() {
    mockDeleteExpense = MockDeleteExpense();
    mockDeleteIncome = MockDeleteIncome();
    mockFetchExpensesDetails = MockFetchExpensesDetails();
    mockFetchIncomesDetails = MockFetchIncomesDetails();
    viewallBloc = ViewallBloc(
      deleteExpense: mockDeleteExpense,
      deleteIncome: mockDeleteIncome,
      fetchExpensesDetails: mockFetchExpensesDetails,
      fetchIncomesDetails: mockFetchIncomesDetails,
    );
  });

  blocTest(
    'Delete expense return ViewallLoaded state from initial state',
    build: () => viewallBloc,
    setUp: () async {
      provideDummy<Either<Failure, ExpensesDetailsEntity>>(
        const Right(
          ExpensesDetailsEntity(expensesList: []),
        ),
      );
      when(
        mockDeleteExpense.call(
          accountId: 'default',
          expenseEntity: expenseEntity,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(
          ExpensesDetailsEntity(expensesList: []),
        ),
      );
    },
    act: (bloc) => bloc.add(
      ViewallDeleteExpenseEvent(expenseEntity: expenseEntity),
    ),
    expect: () => [
      const ViewallLoaded(
        expensesDetails: ExpensesDetailsEntity(
          expensesList: [],
        ),
      ),
    ],
  );

  blocTest(
    'Delete expense return ViewallLoaded state from already loaded state',
    build: () {
      return viewallBloc;
    },
    setUp: () async {
      provideDummy<Either<Failure, ExpensesDetailsEntity>>(
        const Right(
          ExpensesDetailsEntity(expensesList: []),
        ),
      );
      when(
        mockDeleteExpense.call(
          accountId: 'default',
          expenseEntity: expenseEntity,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(
          ExpensesDetailsEntity(expensesList: []),
        ),
      );
    },
    act: (bloc) => bloc
      ..add(
        ViewallDeleteExpenseEvent(expenseEntity: expenseEntity),
      )
      ..add(ViewallDeleteExpenseEvent(expenseEntity: expenseEntity)),
    expect: () => [
      const ViewallLoaded(
        expensesDetails: ExpensesDetailsEntity(
          expensesList: [],
        ),
      ),
    ],
  );

  blocTest(
    'Delete income return ViewallLoaded state from initial state',
    build: () => viewallBloc,
    setUp: () async {
      provideDummy<Either<Failure, IncomesDetailsEntity>>(
        const Right(
          IncomesDetailsEntity(incomesList: []),
        ),
      );
      when(
        mockDeleteIncome.call(
          accountId: 'default',
          incomeEntity: incomeEntity,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(
          IncomesDetailsEntity(incomesList: []),
        ),
      );
    },
    act: (bloc) => bloc.add(
      ViewallDeleteIncomeEvent(incomeEntity: incomeEntity),
    ),
    expect: () => [
      const ViewallLoaded(
        incomesDetails: IncomesDetailsEntity(
          incomesList: [],
        ),
      ),
    ],
  );

  blocTest(
    'Delete expense return ViewallLoaded state from already loaded state',
    build: () => viewallBloc,
    setUp: () async {
      provideDummy<Either<Failure, IncomesDetailsEntity>>(
        const Right(
          IncomesDetailsEntity(incomesList: []),
        ),
      );
      when(
        mockDeleteIncome.call(
          accountId: 'default',
          incomeEntity: incomeEntity,
        ),
      ).thenAnswer(
        (realInvocation) async => const Right(
          IncomesDetailsEntity(incomesList: []),
        ),
      );
    },
    act: (bloc) => bloc
      ..add(
        ViewallDeleteIncomeEvent(incomeEntity: incomeEntity),
      )
      ..add(
        ViewallDeleteIncomeEvent(incomeEntity: incomeEntity),
      ),
    expect: () => [
      const ViewallLoaded(
        incomesDetails: IncomesDetailsEntity(
          incomesList: [],
        ),
      ),
    ],
  );

  blocTest(
    'Fetch Expenses Details return ViewallLoaded state from initial state',
    build: () => viewallBloc,
    setUp: () async {
      provideDummy<Either<Failure, ExpensesDetailsEntity>>(
        Right(
          ExpensesDetailsEntity(expensesList: [expenseEntity]),
        ),
      );
      when(
        mockFetchExpensesDetails.call(
          accountId: 'default',
        ),
      ).thenAnswer(
        (realInvocation) async => Right(
          ExpensesDetailsEntity(expensesList: [expenseEntity]),
        ),
      );
    },
    act: (bloc) => bloc.add(
      const ViewallFetchExpensesDetailsEvent(),
    ),
    expect: () => [
      ViewallLoaded(
        expensesDetails: ExpensesDetailsEntity(
          expensesList: [expenseEntity],
        ),
      ),
    ],
  );

  blocTest(
    'Fetch Expenses Details return ViewallLoaded state from already loaded state',
    build: () => viewallBloc,
    setUp: () async {
      provideDummy<Either<Failure, ExpensesDetailsEntity>>(
        Right(
          ExpensesDetailsEntity(expensesList: [expenseEntity]),
        ),
      );
      when(
        mockFetchExpensesDetails.call(
          accountId: 'default',
        ),
      ).thenAnswer(
        (realInvocation) async => Right(
          ExpensesDetailsEntity(expensesList: [expenseEntity]),
        ),
      );
    },
    act: (bloc) => bloc
      ..add(
        const ViewallFetchExpensesDetailsEvent(),
      )
      ..add(
        const ViewallFetchExpensesDetailsEvent(),
      ),
    expect: () => [
      ViewallLoaded(
        expensesDetails: ExpensesDetailsEntity(
          expensesList: [expenseEntity],
        ),
      ),
    ],
  );

  blocTest(
    'Fetch Incomes Details return ViewallLoaded state from initial state',
    build: () => viewallBloc,
    setUp: () async {
      provideDummy<Either<Failure, IncomesDetailsEntity>>(
        Right(
          IncomesDetailsEntity(incomesList: [incomeEntity]),
        ),
      );
      when(
        mockFetchIncomesDetails.call(
          accountId: 'default',
        ),
      ).thenAnswer(
        (realInvocation) async => Right(
          IncomesDetailsEntity(incomesList: [incomeEntity]),
        ),
      );
    },
    act: (bloc) => bloc.add(
      const ViewallFetchIncomesDetailsEvent(),
    ),
    expect: () => [
      ViewallLoaded(
        incomesDetails: IncomesDetailsEntity(
          incomesList: [incomeEntity],
        ),
      ),
    ],
  );

  blocTest(
    'Fetch Incomes Details return ViewallLoaded state from already loaded state',
    build: () => viewallBloc,
    setUp: () async {
      provideDummy<Either<Failure, IncomesDetailsEntity>>(
        Right(
          IncomesDetailsEntity(incomesList: [incomeEntity]),
        ),
      );
      when(
        mockFetchIncomesDetails.call(
          accountId: 'default',
        ),
      ).thenAnswer(
        (realInvocation) async => Right(
          IncomesDetailsEntity(incomesList: [incomeEntity]),
        ),
      );
    },
    act: (bloc) => bloc
      ..add(
        const ViewallFetchIncomesDetailsEvent(),
      )
      ..add(
        const ViewallFetchIncomesDetailsEvent(),
      ),
    expect: () => [
      ViewallLoaded(
        incomesDetails: IncomesDetailsEntity(
          incomesList: [incomeEntity],
        ),
      ),
    ],
  );
}
