import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/income.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/incomes_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/repositories/viewall_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/usecases/delete_income.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_income_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ViewallRepository>()])
void main() {
  late DeleteIncome sut;
  late MockViewallRepository mockViewallRepository;
  final incomeEntity = IncomeEntity(
    id: 'test',
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(1999),
    relatedDoc: 'test',
  );
  const IncomesDetailsEntity incomesDetailsEntity =
      IncomesDetailsEntity(incomesList: []);

  setUp(() {
    mockViewallRepository = MockViewallRepository();
    sut = DeleteIncome(mockViewallRepository);
  });

  test('DeleteIncome returns success and IncomesDetailsEntity', () async {
    provideDummy<Either<Failure, void>>(
      const Right(null),
    );
    provideDummy<Either<Failure, IncomesDetailsEntity>>(
      const Right(incomesDetailsEntity),
    );
    when(
      mockViewallRepository.deleteIncome(
        accountId: 'test',
        incomeEntity: incomeEntity,
      ),
    ).thenAnswer((realInvocation) async => Future.value(const Right(null)));
    when(mockViewallRepository.fetchIncomesDetails()).thenAnswer(
      (realInvocation) async => const Right(incomesDetailsEntity),
    );
    final response = await sut(accountId: 'test', incomeEntity: incomeEntity);
    expect(response, const Right(incomesDetailsEntity));
  });

  test('DeleteIncome returns Failure', () async {
    provideDummy<Either<Failure, void>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(
      mockViewallRepository.deleteIncome(
        accountId: 'test',
        incomeEntity: incomeEntity,
      ),
    ).thenAnswer(
      (realInvocation) async => const Left(HomeFailure(message: 'test')),
    );
    final response = await sut(accountId: 'test', incomeEntity: incomeEntity);
    expect(response, const Left(HomeFailure(message: 'test')));
  });
}
