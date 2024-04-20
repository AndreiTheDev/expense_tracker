import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/repository/switch_account_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/usecases/fetch_accounts_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_accounts_list_test.mocks.dart';

@GenerateNiceMocks([MockSpec<SwitchAccountRepository>()])
void main() {
  late FetchAccountsList sut;
  late MockSwitchAccountRepository mockSwitchAccountRepository;
  setUp(() {
    mockSwitchAccountRepository = MockSwitchAccountRepository();
    sut = FetchAccountsList(mockSwitchAccountRepository);
  });
  final accountsList = [
    AccountEntity(
      id: 'test',
      name: 'test',
      createdBy: 'test',
      owner: 'test',
      income: 100,
      expenses: 100,
    ),
  ];

  test('FetchAccountsList fetches accounts from the database', () async {
    provideDummy<Either<Failure, List<AccountEntity>>>(Right(accountsList));
    when(
      mockSwitchAccountRepository.fetchAccountsList(),
    ).thenAnswer((realInvocation) async => Right(accountsList));

    final result = await sut();

    expect(result, Right<Failure, List<AccountEntity>>(accountsList));
    verify(
      mockSwitchAccountRepository.fetchAccountsList(),
    ).called(1);
    verifyNoMoreInteractions(mockSwitchAccountRepository);
  });

  test('FetchAccountsList failes to fetch accounts from database', () async {
    provideDummy<Either<Failure, void>>(
      const Left(SwitchAccountFailure(message: 'failure')),
    );
    when(
      mockSwitchAccountRepository.fetchAccountsList(),
    ).thenAnswer(
      (realInvocation) async =>
          const Left(SwitchAccountFailure(message: 'failure')),
    );

    final result = await sut();

    expect(result, const Left(SwitchAccountFailure(message: 'failure')));
    verify(
      mockSwitchAccountRepository.fetchAccountsList(),
    ).called(1);
    verifyNoMoreInteractions(mockSwitchAccountRepository);
  });
}
