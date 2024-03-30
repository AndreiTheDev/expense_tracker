import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expense.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expenses_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/repositories/viewall_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/usecases/delete_expense.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_expense_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ViewallRepository>()])
void main() {
  late DeleteExpense sut;
  late MockViewallRepository mockViewallRepository;
  final expenseEntity = ExpenseEntity(
    id: 'test',
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(1999),
    relatedDoc: 'test',
  );
  const ExpensesDetailsEntity expensesDetailsEntity =
      ExpensesDetailsEntity(expensesList: []);

  setUp(() {
    mockViewallRepository = MockViewallRepository();
    sut = DeleteExpense(mockViewallRepository);
  });

  test('DeleteExpense returns success and ExpensesDetailsEntity', () async {
    provideDummy<Either<Failure, void>>(
      const Right(null),
    );
    provideDummy<Either<Failure, ExpensesDetailsEntity>>(
      const Right(expensesDetailsEntity),
    );
    when(
      mockViewallRepository.deleteExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).thenAnswer((realInvocation) async => Future.value(const Right(null)));
    when(mockViewallRepository.fetchExpensesDetails()).thenAnswer(
      (realInvocation) async => const Right(expensesDetailsEntity),
    );
    final response = await sut(accountId: 'test', expenseEntity: expenseEntity);
    expect(response, const Right(expensesDetailsEntity));
  });

  test('DeleteExpense returns Failure', () async {
    provideDummy<Either<Failure, void>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(
      mockViewallRepository.deleteExpense(
        accountId: 'test',
        expenseEntity: expenseEntity,
      ),
    ).thenAnswer(
      (realInvocation) async => const Left(HomeFailure(message: 'test')),
    );
    final response = await sut(accountId: 'test', expenseEntity: expenseEntity);
    expect(response, const Left(HomeFailure(message: 'test')));
  });
}
