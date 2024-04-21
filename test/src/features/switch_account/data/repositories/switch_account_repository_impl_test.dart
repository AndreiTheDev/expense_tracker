import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/data/datasources/switch_account_firebase_datasource.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/data/datasources/switch_account_firestore_datasource.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/data/dtos/account.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/data/repository/switch_account_repository_impl.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/entities/account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'switch_account_repository_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<SwitchAccountFirebaseDataSource>(),
  MockSpec<SwitchAccountFirestoreDataSource>(),
  MockSpec<User>(),
])
void main() {
  late SwitchAccountRepositoryImpl sut;
  late MockSwitchAccountFirebaseDataSource mockFirebaseDataSource;
  late MockSwitchAccountFirestoreDataSource mockFirestoreDataSource;
  setUp(() {
    mockFirebaseDataSource = MockSwitchAccountFirebaseDataSource();
    mockFirestoreDataSource = MockSwitchAccountFirestoreDataSource();
    sut = SwitchAccountRepositoryImpl(
      mockFirebaseDataSource,
      mockFirestoreDataSource,
    );
  });
  final AccountEntity accountEntity = AccountEntity(
    name: 'name',
    createdBy: 'createdBy',
    owner: 'owner',
  );
  final AccountDto accountDto = AccountDto(
    id: 'testId',
    name: 'name',
    createdBy: 'createdBy',
    owner: 'owner',
    totalBalance: 0,
  );
  final mockUser = MockUser();

  test('Create new account returns success', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    when(mockFirebaseDataSource.getUser()).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testUid');
    when(
      mockFirestoreDataSource.createNewAccount(
        'testUid',
        AccountDto.fromEntity(accountEntity).toJson(),
      ),
    ).thenAnswer((realInvocation) => Future.value());
    final response = await sut.createNewAccount(accountEntity);
    expect(response, const Right(null));
    verify(mockFirebaseDataSource.getUser()).called(1);
    verify(mockUser.uid).called(1);
    verify(
      mockFirestoreDataSource.createNewAccount(
        'testUid',
        AccountDto.fromEntity(accountEntity).toJson(),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockUser);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Create new account returns failure from SwitchAccountFailure',
      () async {
    provideDummy<Either<Failure, void>>(
      const Left(
        SwitchAccountFailure(message: 'testError'),
      ),
    );
    when(mockFirebaseDataSource.getUser()).thenThrow(
      const SwitchAccountFailure(
        message: 'User is not authenticated, unable to execute the operation.',
      ),
    );
    final response = await sut.createNewAccount(accountEntity);
    expect(
      response,
      const Left(
        SwitchAccountFailure(
          message:
              'User is not authenticated, unable to execute the operation.',
        ),
      ),
    );
    verify(mockFirebaseDataSource.getUser()).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
  });

  test('Create new account returns failure from FirebaseException', () async {
    provideDummy<Either<Failure, void>>(
      const Left(
        SwitchAccountFailure(message: 'testError'),
      ),
    );
    when(mockFirebaseDataSource.getUser()).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testUid');
    when(
      mockFirestoreDataSource.createNewAccount(
        'testUid',
        AccountDto.fromEntity(accountEntity).toJson(),
      ),
    ).thenThrow(FirebaseException(plugin: 'test', code: 'testError'));
    final response = await sut.createNewAccount(accountEntity);
    expect(
      response,
      const Left(
        SwitchAccountFailure(message: 'An unknown error occured.'),
      ),
    );
    verify(mockFirebaseDataSource.getUser()).called(1);
    verify(mockUser.uid).called(1);
    verify(
      mockFirestoreDataSource.createNewAccount(
        'testUid',
        AccountDto.fromEntity(accountEntity).toJson(),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockUser);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('Create new account returns failure from unknown exception', () async {
    provideDummy<Either<Failure, void>>(
      const Left(
        SwitchAccountFailure(message: 'An unknown error occured.'),
      ),
    );
    when(mockFirebaseDataSource.getUser()).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testUid');
    when(
      mockFirestoreDataSource.createNewAccount(
        'testUid',
        AccountDto.fromEntity(accountEntity).toJson(),
      ),
    ).thenThrow(Exception('testError'));
    final response = await sut.createNewAccount(accountEntity);
    expect(
      response,
      const Left(
        SwitchAccountFailure(message: 'An unknown error occured.'),
      ),
    );
    verify(mockFirebaseDataSource.getUser()).called(1);
    verify(mockUser.uid).called(1);
    verify(
      mockFirestoreDataSource.createNewAccount(
        'testUid',
        AccountDto.fromEntity(accountEntity).toJson(),
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockUser);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('FetchAccountsList returns success', () async {
    provideDummy<Either<Failure, List<AccountEntity>>>(
      Right([accountDto]),
    );
    when(mockFirebaseDataSource.getUser()).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testUid');
    when(mockFirestoreDataSource.fetchAccountsList('testUid')).thenAnswer(
      (realInvocation) async => [
        {
          'id': 'testId',
          'name': 'name',
          'createdBy': 'createdBy',
          'owner': 'owner',
          'totalBalance': 0,
          'expenses': 0,
          'income': 0,
          'transactions': [],
        }
      ],
    );
    final response = await sut.fetchAccountsList();
    expect(response, isA<Right>());
    final rightValue = response.foldRight([], (acc, b) => b);
    expect(rightValue, [accountDto]);
  });

  test('FetchAccountsList returns failure from SwitchAccountFailure', () async {
    provideDummy<Either<Failure, void>>(
      const Left(
        SwitchAccountFailure(message: 'testError'),
      ),
    );
    when(mockFirebaseDataSource.getUser()).thenThrow(
      const SwitchAccountFailure(
        message: 'User is not authenticated, unable to execute the operation.',
      ),
    );
    final response = await sut.fetchAccountsList();
    expect(
      response,
      const Left(
        SwitchAccountFailure(
          message:
              'User is not authenticated, unable to execute the operation.',
        ),
      ),
    );
    verify(mockFirebaseDataSource.getUser()).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
  });

  test('FetchAccountsList returns failure from FirebaseException', () async {
    provideDummy<Either<Failure, void>>(
      const Left(
        SwitchAccountFailure(message: 'testError'),
      ),
    );
    when(mockFirebaseDataSource.getUser()).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testUid');
    when(
      mockFirestoreDataSource.fetchAccountsList('testUid'),
    ).thenThrow(FirebaseException(plugin: 'test', code: 'testError'));
    final response = await sut.fetchAccountsList();
    expect(
      response,
      const Left(
        SwitchAccountFailure(message: 'An unknown error occured.'),
      ),
    );
    verify(mockFirebaseDataSource.getUser()).called(1);
    verify(
      mockFirestoreDataSource.fetchAccountsList('testUid'),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });

  test('FetchAccountsList returns failure from unknown exception', () async {
    provideDummy<Either<Failure, void>>(
      const Left(
        SwitchAccountFailure(message: 'An unknown error occured.'),
      ),
    );
    when(mockFirebaseDataSource.getUser()).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testUid');
    when(
      mockFirestoreDataSource.fetchAccountsList('testUid'),
    ).thenThrow(Exception('testError'));
    final response = await sut.fetchAccountsList();
    expect(
      response,
      const Left(
        SwitchAccountFailure(message: 'An unknown error occured.'),
      ),
    );
    verify(mockFirebaseDataSource.getUser()).called(1);
    verify(
      mockFirestoreDataSource.fetchAccountsList(
        'testUid',
      ),
    ).called(1);
    verifyNoMoreInteractions(mockFirebaseDataSource);
    verifyNoMoreInteractions(mockFirestoreDataSource);
  });
}
