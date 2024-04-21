import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/usecases/create_new_account.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/usecases/fetch_accounts_list.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/presentation/bloc/switch_account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'switch_account_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<CreateNewAccount>(),
  MockSpec<FetchAccountsList>(),
])
void main() {
  late SwitchAccountBloc switchAccountBloc;
  late MockCreateNewAccount mockCreateNewAccount;
  late MockFetchAccountsList mockFetchAccountsList;
  setUp(() {
    mockCreateNewAccount = MockCreateNewAccount();
    mockFetchAccountsList = MockFetchAccountsList();
    switchAccountBloc = SwitchAccountBloc(
      createNewAccount: mockCreateNewAccount,
      fetchAccountsList: mockFetchAccountsList,
    );
  });
  final AccountEntity accountEntity =
      AccountEntity(name: 'name', createdBy: 'createdBy', owner: 'owner');

  blocTest(
    'SwtichAccountCreateAccountEvent creates a new account in database',
    build: () => switchAccountBloc,
    setUp: () async {
      provideDummy<Either<Failure, void>>(const Right(null));
      provideDummy<Either<Failure, List<AccountEntity>>>(
        Right([accountEntity]),
      );
      when(mockCreateNewAccount.call(account: accountEntity)).thenAnswer(
        (realInvocation) async => const Right(null),
      );
      when(mockFetchAccountsList.call()).thenAnswer(
        (realInvocation) async => Right(
          [accountEntity],
        ),
      );
    },
    act: (bloc) => switchAccountBloc.add(
      SwtichAccountCreateAccountEvent(accountEntity: accountEntity),
    ),
    expect: () => [
      SwitchAccountLoading(),
      SwitchAccountLoaded([accountEntity]),
    ],
  );

  blocTest(
    'SwtichAccountCreateAccountEvent emits error because of create account failure',
    build: () => switchAccountBloc,
    setUp: () async {
      provideDummy<Either<Failure, void>>(
        const Left(SwitchAccountFailure(message: 'Create error')),
      );
      when(mockCreateNewAccount.call(account: accountEntity)).thenAnswer(
        (realInvocation) async => const Left(
          SwitchAccountFailure(message: 'Create error'),
        ),
      );
    },
    act: (bloc) => switchAccountBloc.add(
      SwtichAccountCreateAccountEvent(accountEntity: accountEntity),
    ),
    expect: () => [
      SwitchAccountLoading(),
      const SwitchAccountError('Create error'),
    ],
  );

  blocTest(
    'SwtichAccountCreateAccountEvent emits error because of fetch account failure',
    build: () => switchAccountBloc,
    setUp: () async {
      provideDummy<Either<Failure, void>>(const Right(null));
      provideDummy<Either<Failure, List<AccountEntity>>>(
        const Left(
          SwitchAccountFailure(message: 'Fetch error.'),
        ),
      );
      when(mockCreateNewAccount.call(account: accountEntity)).thenAnswer(
        (realInvocation) async => const Right(null),
      );
      when(mockFetchAccountsList.call()).thenAnswer(
        (realInvocation) async => const Left(
          SwitchAccountFailure(message: 'Fetch error.'),
        ),
      );
    },
    act: (bloc) => switchAccountBloc.add(
      SwtichAccountCreateAccountEvent(accountEntity: accountEntity),
    ),
    expect: () => [
      SwitchAccountLoading(),
      const SwitchAccountError('Fetch error.'),
    ],
  );

  blocTest(
    'SwtichAccountFetchAccountsEvent emits error because of fetch account failure',
    build: () => switchAccountBloc,
    setUp: () async {
      provideDummy<Either<Failure, List<AccountEntity>>>(
        Right([accountEntity]),
      );
      when(mockFetchAccountsList.call()).thenAnswer(
        (realInvocation) async => Right(
          [accountEntity],
        ),
      );
    },
    act: (bloc) => switchAccountBloc.add(
      SwitchAccountFetchAccountsEvent(),
    ),
    expect: () => [
      SwitchAccountLoading(),
      SwitchAccountLoaded([accountEntity]),
    ],
  );

  blocTest(
    'SwtichAccountFetchAccountsEvent fetches all acounts from database',
    build: () => switchAccountBloc,
    setUp: () async {
      provideDummy<Either<Failure, List<AccountEntity>>>(
        const Left(
          SwitchAccountFailure(message: 'Fetch error.'),
        ),
      );
      when(mockFetchAccountsList.call()).thenAnswer(
        (realInvocation) async => const Left(
          SwitchAccountFailure(message: 'Fetch error.'),
        ),
      );
    },
    act: (bloc) => switchAccountBloc.add(
      SwitchAccountFetchAccountsEvent(),
    ),
    expect: () => [
      SwitchAccountLoading(),
      const SwitchAccountError('Fetch error.'),
    ],
  );
}
