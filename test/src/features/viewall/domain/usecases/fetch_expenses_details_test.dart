import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/expenses_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/repositories/viewall_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/usecases/fetch_expenses_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_expenses_details_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ViewallRepository>()])
void main() {
  late FetchExpensesDetails sut;
  late MockViewallRepository mockViewallRepository;
  const ExpensesDetailsEntity expensesDetailsEntity =
      ExpensesDetailsEntity(expensesList: []);

  setUp(() {
    mockViewallRepository = MockViewallRepository();
    sut = FetchExpensesDetails(mockViewallRepository);
  });

  test('FetchExpensesDetails returns ExpensesDetailsEntity', () async {
    provideDummy<Either<Failure, ExpensesDetailsEntity>>(
      const Right(expensesDetailsEntity),
    );
    when(mockViewallRepository.fetchExpensesDetails()).thenAnswer(
      (realInvocation) async => const Right(expensesDetailsEntity),
    );
    final result = await sut(accountId: 'test');
    expect(result, const Right(expensesDetailsEntity));
  });

  test('FetchExpensesDetails returns Failure', () async {
    provideDummy<Either<Failure, ExpensesDetailsEntity>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(mockViewallRepository.fetchExpensesDetails())
        .thenThrow(const HomeFailure(message: 'test'));
    final result = await sut(accountId: 'test');
    expect(result, const Left(HomeFailure(message: 'test')));
  });
}
