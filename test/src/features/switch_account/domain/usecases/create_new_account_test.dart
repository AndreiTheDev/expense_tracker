import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/repository/switch_account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/usecases/create_new_account.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'create_new_account_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SwitchAccountRepository>()])
void main() {
  late CreateNewAccount sut;
  late MockSwitchAccountRepository mockSwitchAccountRepository;
  setUp(() {
    mockSwitchAccountRepository = MockSwitchAccountRepository();
    sut = CreateNewAccount(mockSwitchAccountRepository);
  });
  final AccountEntity accountEntity = AccountEntity(
    id: 'test',
    name: 'test',
    createdBy: 'test',
    owner: 'test',
    income: 100,
    expenses: 100,
  );

  test('CreateNewAccount creates new account in database', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    when(
      mockSwitchAccountRepository.createNewAccount(accountEntity),
    ).thenAnswer((realInvocation) async => const Right(null));

    final result = await sut(account: accountEntity);

    expect(result, const Right(null));
    verify(
      mockSwitchAccountRepository.createNewAccount(accountEntity),
    ).called(1);
    verifyNoMoreInteractions(mockSwitchAccountRepository);
  });

  test('CreateNewAccount failes to create new account in database', () async {
    provideDummy<Either<Failure, void>>(
      const Left(SwitchAccountFailure(message: 'failure')),
    );
    when(
      mockSwitchAccountRepository.createNewAccount(accountEntity),
    ).thenAnswer(
      (realInvocation) async =>
          const Left(SwitchAccountFailure(message: 'failure')),
    );

    final result = await sut(account: accountEntity);

    expect(result, const Left(SwitchAccountFailure(message: 'failure')));
    verify(
      mockSwitchAccountRepository.createNewAccount(accountEntity),
    ).called(1);
    verifyNoMoreInteractions(mockSwitchAccountRepository);
  });
}
