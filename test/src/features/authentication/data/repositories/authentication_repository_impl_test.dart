import 'dart:io';

import 'package:expense_tracker_app_bloc/src/core/error/exceptions.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_firebase_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_firestore_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_functions_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_storage_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
  [
    MockSpec<AuthenticationFirebaseDataSourceImpl>(),
    MockSpec<AuthenticationFirestoreDataSourceImpl>(),
    MockSpec<AuthenticationFunctionsDataSourceImpl>(),
    MockSpec<AuthenticationStorageDataSourceImpl>(),
    MockSpec<File>(),
    MockSpec<UserDetailsDto>(),
    MockSpec<UserDetailsEntity>(),
    MockSpec<User>(),
  ],
)
void main() {
  group('Auth Repository test group', () {
    late UserDto userDto;
    late UserEntity userEntity;
    late MockUser mockUser;
    late MockAuthenticationFirebaseDataSourceImpl mockFirebaseDataSource;
    late MockAuthenticationFirestoreDataSourceImpl mockFirestoreDataSource;
    late MockAuthenticationFunctionsDataSourceImpl mockFunctionsDataSource;
    late MockAuthenticationStorageDataSourceImpl mockStorageDataSource;
    late AuthenticationRepositoryImpl sut;

    setUp(() {
      userDto = const UserDto(
        uid: 'testUid',
        email: 'test@email.com',
        fcmToken: 'testFcm',
        completeName: 'test test',
        photoUrl: 'testPhoto',
      );
      userEntity = userDto;
      mockUser = MockUser();
      mockFirebaseDataSource = MockAuthenticationFirebaseDataSourceImpl();
      mockFirestoreDataSource = MockAuthenticationFirestoreDataSourceImpl();
      mockFunctionsDataSource = MockAuthenticationFunctionsDataSourceImpl();
      mockStorageDataSource = MockAuthenticationStorageDataSourceImpl();
      sut = AuthenticationRepositoryImpl(
        firebaseDataSource: mockFirebaseDataSource,
        firestoreDataSource: mockFirestoreDataSource,
        functionsDataSource: mockFunctionsDataSource,
        storageDataSource: mockStorageDataSource,
      );
    });

    test('Delete user is successfull', () async {
      when(mockFirebaseDataSource.deleteUser())
          .thenAnswer((realInvocation) => Future(() => null));

      expect(await sut.deleteUser(), isA<Right>());
      verify(mockFirebaseDataSource.deleteUser()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Delete user returns authfailure', () async {
      when(mockFirebaseDataSource.deleteUser()).thenThrow(
        AuthException(
          code: 'delete-failed',
          message: 'Unable to delete the current user.',
        ),
      );

      final response = await sut.deleteUser();

      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'Unable to delete the current user.'),
          ),
        ),
      );
      verify(mockFirebaseDataSource.deleteUser()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Delete user returns unknownfailure', () async {
      when(mockFirebaseDataSource.deleteUser()).thenThrow(
        Exception(),
      );

      final response = await sut.deleteUser();

      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error occured'),
          ),
        ),
      );
      verify(mockFirebaseDataSource.deleteUser()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Is signed it returns userDto', () async {
      when(mockFirebaseDataSource.isSignedIn())
          .thenAnswer((realInvocation) => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid'))
          .thenAnswer((realInvocation) async => userDto);

      final response = await sut.isSignedIn();

      expect(response, Right(userEntity));
      verify(mockFirebaseDataSource.isSignedIn()).called(1);
      verify(mockFirestoreDataSource.fetchUserData('testUid')).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
      verifyNoMoreInteractions(mockFirestoreDataSource);
    });

    test('Is signed it returns authfailure', () async {
      when(mockFirebaseDataSource.isSignedIn()).thenThrow(
        AuthException(
          code: 'signin-failed',
          message: 'Unable to authenticate the user.',
        ),
      );

      final response = await sut.isSignedIn();

      expect(
        response,
        const Left(AuthFailure(message: 'Unable to authenticate the user.')),
      );
      verify(mockFirebaseDataSource.isSignedIn()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Is signed it returns unknownerror', () async {
      when(mockFirebaseDataSource.isSignedIn()).thenThrow(Exception());

      final response = await sut.isSignedIn();

      expect(
        response,
        const Left(AuthFailure(message: 'An unknown error occured.')),
      );
      verify(mockFirebaseDataSource.isSignedIn()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Recover password is successfull', () async {
      when(mockFirebaseDataSource.recoverPassword('test@gmail.com'))
          .thenAnswer((realInvocation) => Future(() => null));

      final response = await sut.recoverPassword('test@gmail.com');

      expect(response, const Right(null));
      verify(mockFirebaseDataSource.recoverPassword('test@gmail.com'))
          .called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Recover password throws error', () async {
      when(mockFirebaseDataSource.recoverPassword('test@gmail.com'))
          .thenThrow(Exception());

      final response = await sut.recoverPassword('test@gmail.com');

      expect(
        response,
        const Left(AuthFailure(message: 'An unknown error occured.')),
      );
      verify(mockFirebaseDataSource.recoverPassword('test@gmail.com'))
          .called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Sign in user successfully', () async {
      when(mockFirebaseDataSource.signInUser('test@email.com', 'testpassword'))
          .thenAnswer((realInvocation) async => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid'))
          .thenAnswer((realInvocation) async => userDto);

      final response = await sut.signInUser('test@email.com', 'testpassword');
      expect(response, equals(Right(userEntity)));
    });

    test('Sign in user fails with AuthException', () async {
      when(mockFirebaseDataSource.signInUser('test@email.com', 'testpassword'))
          .thenThrow(
        AuthException(
          code: 'signin-failed',
          message: 'Unable to authenticate the user.',
        ),
      );

      final response = await sut.signInUser('test@email.com', 'testpassword');
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'Unable to authenticate the user.'),
          ),
        ),
      );
    });

    test('Sign in user fails with FirestoreException', () async {
      when(mockFirebaseDataSource.signInUser('test@email.com', 'testpassword'))
          .thenAnswer((realInvocation) async => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid')).thenThrow(
        FirestoreException(
          code: 'user-fetch',
          message: 'Unable to get user data.',
        ),
      );

      final response = await sut.signInUser('test@email.com', 'testpassword');
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'Unable to get user data.'),
          ),
        ),
      );
    });

    test('Sign in user fails with unknownerror', () async {
      when(mockFirebaseDataSource.signInUser('test@email.com', 'testpassword'))
          .thenThrow(Exception());

      final response = await sut.signInUser('test@email.com', 'testpassword');
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error happened.'),
          ),
        ),
      );
    });

    test('Sign up user successfully', () async {
      provideDummy<Either<Failure, UserDto>>(Right(userDto));
      final mockFile = MockFile();
      final userDetailsEntity = UserDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        fcmToken: 'testFcm',
        photo: mockFile,
      );

      when(mockFirebaseDataSource.signUpUser('test@email.com', 'testpassword'))
          .thenAnswer((realInvocation) async => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(
        mockFunctionsDataSource.addUserDetailsToDb(
          'testUid',
          UserDetailsDto.fromEntity(userDetailsEntity),
        ),
      ).thenAnswer((realInvocation) async => true);
      when(mockStorageDataSource.addPhotoToStorage(mockFile))
          .thenAnswer((realInvocation) async => 'photoUrl');
      when(mockFirestoreDataSource.postUserPhoto('testUid', 'photoUrl'))
          .thenAnswer((realInvocation) => Future(() => null));
      when(mockFirestoreDataSource.fetchUserData('testUid'))
          .thenAnswer((realInvocation) async => userDto);

      final response = await sut.signUpUser(userDetailsEntity);
      expect(response, equals(Right(userDto)));
    });

    test('Sign up user fails', () async {
      provideDummy<Either<Failure, UserDto>>(Right(userDto));
      final mockFile = MockFile();
      final userDetailsEntity = UserDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        fcmToken: 'testFcm',
        photo: mockFile,
      );

      when(mockFirebaseDataSource.signUpUser('test@email.com', 'testpassword'))
          .thenThrow(
        AuthException(
          code: 'signup-failed',
          message: 'Unable to create an account.',
        ),
      );

      final response = await sut.signUpUser(userDetailsEntity);
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'Unable to create an account.'),
          ),
        ),
      );
    });

    test('Sign up user fails', () async {
      provideDummy<Either<Failure, UserDto>>(Right(userDto));
      final mockFile = MockFile();
      final userDetailsEntity = UserDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        fcmToken: 'testFcm',
        photo: mockFile,
      );

      when(mockFirebaseDataSource.signUpUser('test@email.com', 'testpassword'))
          .thenThrow(Exception());

      final response = await sut.signUpUser(userDetailsEntity);
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error happened.'),
          ),
        ),
      );
    });

    test('Sign out user is successfull', () async {
      when(mockFirebaseDataSource.signOutUser())
          .thenAnswer((realInvocation) => Future(() => null));

      final response = await sut.signOutUser();
      expect(response, const Right(null));
      verify(mockFirebaseDataSource.signOutUser()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Sign out user returns error', () async {
      when(mockFirebaseDataSource.signOutUser()).thenThrow(Exception());

      final response = await sut.signOutUser();
      expect(
        response,
        const Left(AuthFailure(message: 'An unknown error occured')),
      );
      verify(mockFirebaseDataSource.signOutUser()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });
  });
}
