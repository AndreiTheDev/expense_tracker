import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/entities/transaction.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/repositories/account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/home/domain/usecases/add_transaction.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_transaction_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AccountRepository>()])
void main() {
  late AddTransaction sut;
  late MockAccountRepository mockAccountRepository;
  final TransactionEntity transaction = TransactionEntity(
    id: 'test',
    category: 'test',
    description: 'test',
    amount: 100,
    date: DateTime(1999),
  );

  setUp(() {
    mockAccountRepository = MockAccountRepository();
    sut = AddTransaction(mockAccountRepository);
  });

  test('AddTransaction returns success', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    when(mockAccountRepository.addTransaction(entity: transaction))
        .thenAnswer((realInvocation) async => const Right(null));

    final result = await sut(transaction);

    expect(result, const Right(null));
    verify(mockAccountRepository.addTransaction(entity: transaction)).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });

  test('AddTransaction returns failure', () async {
    provideDummy<Either<Failure, void>>(
      const Left(HomeFailure(message: 'test')),
    );
    when(mockAccountRepository.addTransaction(entity: transaction)).thenAnswer(
      (realInvocation) async => const Left(HomeFailure(message: 'test')),
    );

    final result = await sut(transaction);

    expect(result, const Left(HomeFailure(message: 'test')));
    verify(mockAccountRepository.addTransaction(entity: transaction)).called(1);
    verifyNoMoreInteractions(mockAccountRepository);
  });
}
