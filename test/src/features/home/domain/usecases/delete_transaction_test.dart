import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/delete_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_transaction_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AccountRepository>()])
void main() {
  late DeleteTransaction sut;
  late MockAccountRepository mockAccountRepository;

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    sut = DeleteTransaction(mockAccountRepository);
  });

  test('DeleteTransaction returns success', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    when(mockAccountRepository.deleteTransaction(id: 'test'))
        .thenAnswer((realInvocation) async => const Right(null));

    final result = await sut('test');

    expect(result, const Right(null));
    verify(mockAccountRepository.deleteTransaction(id: 'test')).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test('DeleteTransaction returns failure', () async {
    provideDummy<Either<Failure, void>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(mockAccountRepository.deleteTransaction(id: 'test')).thenAnswer(
      (realInvocation) async => const Left(HomeFailure(message: 'test')),
    );

    final result = await sut('test');

    expect(result, const Left(HomeFailure(message: 'test')));
    verify(mockAccountRepository.deleteTransaction(id: 'test')).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
