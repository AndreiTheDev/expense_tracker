import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/chart.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/entities/incomes_details.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/repositories/viewall_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/domain/usecases/fetch_incomes_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_incomes_details_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ViewallRepository>()])
void main() {
  late FetchIncomesDetails sut;
  late MockViewallRepository mockViewallRepository;
  const IncomesDetailsEntity incomesDetailsEntity = IncomesDetailsEntity(
    incomesList: [],
    incomesChart: ChartEntity(monthlyList: [], maxMonthThreshold: 0),
  );

  setUp(() {
    mockViewallRepository = MockViewallRepository();
    sut = FetchIncomesDetails(mockViewallRepository);
  });

  test('FetchIncomesDetails returns IncomesDetailsEntity', () async {
    provideDummy<Either<Failure, IncomesDetailsEntity>>(
      const Right(incomesDetailsEntity),
    );
    when(mockViewallRepository.fetchIncomesDetails()).thenAnswer(
      (realInvocation) async => const Right(incomesDetailsEntity),
    );
    final result = await sut(accountId: 'test');
    expect(result, const Right(incomesDetailsEntity));
  });

  test('FetchIncomesDetails returns Failure', () async {
    provideDummy<Either<Failure, IncomesDetailsEntity>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(mockViewallRepository.fetchIncomesDetails())
        .thenThrow(const HomeFailure(message: 'test'));
    final result = await sut(accountId: 'test');
    expect(result, const Left(HomeFailure(message: 'test')));
  });
}
