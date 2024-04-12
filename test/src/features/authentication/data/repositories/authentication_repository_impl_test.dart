import 'package:expense_tracker_app_bloc/src/core/error/exceptions.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_firebase_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_firestore_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_messaging_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_storage_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user_signup_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_signup_details.dart';
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
    MockSpec<AuthenticationStorageDataSourceImpl>(),
    MockSpec<AuthenticationMessagingDataSourceImpl>(),
    MockSpec<UserSignUpDetailsDto>(),
    MockSpec<UserSignUpDetailsEntity>(),
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
    late MockAuthenticationStorageDataSourceImpl mockStorageDataSource;
    late MockAuthenticationMessagingDataSourceImpl mockMessagingDataSource;
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
      mockStorageDataSource = MockAuthenticationStorageDataSourceImpl();
      mockMessagingDataSource = MockAuthenticationMessagingDataSourceImpl();
      sut = AuthenticationRepositoryImpl(
        firebaseDataSource: mockFirebaseDataSource,
        firestoreDataSource: mockFirestoreDataSource,
        storageDataSource: mockStorageDataSource,
        messagingDataSource: mockMessagingDataSource,
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

    test('Delete user returns authfailure from FirebaseAuthException',
        () async {
      when(mockFirebaseDataSource.deleteUser()).thenThrow(
        FirebaseAuthException(code: 'test'),
      );

      final response = await sut.deleteUser();

      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error occured.'),
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
            AuthFailure(message: 'An unknown error occured.'),
          ),
        ),
      );
      verify(mockFirebaseDataSource.deleteUser()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Is signed in returns userDto', () async {
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

    test('Is signed in returns success with user not signed in', () async {
      when(mockFirebaseDataSource.isSignedIn()).thenReturn(null);

      final response = await sut.isSignedIn();

      expect(
        response,
        const Right(null),
      );
      verify(mockFirebaseDataSource.isSignedIn()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Is signed in returns authfailure because UserDto is null', () async {
      when(mockFirebaseDataSource.isSignedIn())
          .thenAnswer((realInvocation) => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid'))
          .thenAnswer((realInvocation) async => null);

      final response = await sut.isSignedIn();

      expect(
        response,
        const Left(
          AuthFailure(
            message: 'Unable to verify if user is already signed in.',
          ),
        ),
      );
      verify(mockFirebaseDataSource.isSignedIn()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Is signed in returns authfailure from AuthException', () async {
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

    test('Is signed in returns authfailure from FirebaseException', () async {
      when(mockFirebaseDataSource.isSignedIn())
          .thenThrow(FirebaseException(plugin: '', code: 'test'));

      final response = await sut.isSignedIn();

      expect(
        response,
        const Left(AuthFailure(message: 'An unknown error occured.')),
      );
      verify(mockFirebaseDataSource.isSignedIn()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Is signed in returns unknownerror', () async {
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

    test('Recover password returns authfailure', () async {
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

    test('Recover password returns authfailure from FirebaseAuthException',
        () async {
      when(mockFirebaseDataSource.recoverPassword('test@gmail.com'))
          .thenThrow(FirebaseAuthException(code: 'test'));

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

    test('Sign in user returns AuthFailure because UserDto is null', () async {
      when(mockFirebaseDataSource.signInUser('test@email.com', 'testpassword'))
          .thenAnswer((realInvocation) async => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid'))
          .thenAnswer((realInvocation) async => null);

      final response = await sut.signInUser('test@email.com', 'testpassword');
      expect(
        response,
        equals(const Left(AuthFailure(message: 'Unable to sign in user.'))),
      );
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

    test('Sign in user fails with FirebaseException', () async {
      when(mockFirebaseDataSource.signInUser('test@email.com', 'testpassword'))
          .thenAnswer((realInvocation) async => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid')).thenThrow(
        FirebaseException(plugin: '', message: 'test error'),
      );

      final response = await sut.signInUser('test@email.com', 'testpassword');
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error occured.'),
          ),
        ),
      );
    });

    test('Sign in user fails with FirebaseAuthException', () async {
      when(mockFirebaseDataSource.signInUser('test@email.com', 'testpassword'))
          .thenAnswer((realInvocation) async => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid')).thenThrow(
        FirebaseAuthException(code: 'test', message: 'test error'),
      );

      final response = await sut.signInUser('test@email.com', 'testpassword');
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error occured.'),
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
            AuthFailure(message: 'An unknown error occured.'),
          ),
        ),
      );
    });

    test('Sign up user successfully', () async {
      provideDummy<Either<Failure, UserDto>>(Right(userDto));
      const userDetailsEntity = UserSignUpDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        photoUrl: 'test',
      );

      when(mockFirebaseDataSource.signUpUser('test@email.com', 'testpassword'))
          .thenAnswer((realInvocation) async => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid'))
          .thenAnswer((realInvocation) async => userDto);

      final response = await sut.signUpUser(userDetailsEntity);
      expect(response, equals(Right(userDto)));
    });

    test('Sign up user returns AuthFailure because UserDto is null', () async {
      const userDetailsEntity = UserSignUpDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        photoUrl: 'test',
      );

      when(mockFirebaseDataSource.signUpUser('test@email.com', 'testpassword'))
          .thenAnswer((realInvocation) async => mockUser);
      when(mockUser.uid).thenReturn('testUid');
      when(mockFirestoreDataSource.fetchUserData('testUid'))
          .thenAnswer((realInvocation) async => null);

      final response = await sut.signUpUser(userDetailsEntity);
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'Unable to sign up user.'),
          ),
        ),
      );
    });

    test('Sign up user fails from AuthException', () async {
      provideDummy<Either<Failure, UserDto>>(Right(userDto));
      const userDetailsEntity = UserSignUpDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        photoUrl: 'test',
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

    test('Sign up user returns authfailure from FirebaseAuthException',
        () async {
      provideDummy<Either<Failure, UserDto>>(Right(userDto));
      const userDetailsEntity = UserSignUpDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        photoUrl: 'test',
      );

      when(mockFirebaseDataSource.signUpUser('test@email.com', 'testpassword'))
          .thenThrow(FirebaseAuthException(code: 'test'));

      final response = await sut.signUpUser(userDetailsEntity);
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error occured.'),
          ),
        ),
      );
    });

    test('Sign up user returns authfailure from FirebaseException', () async {
      provideDummy<Either<Failure, UserDto>>(Right(userDto));
      const userDetailsEntity = UserSignUpDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        photoUrl: 'test',
      );

      when(mockFirebaseDataSource.signUpUser('test@email.com', 'testpassword'))
          .thenThrow(FirebaseException(plugin: '', code: 'test'));

      final response = await sut.signUpUser(userDetailsEntity);
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error occured.'),
          ),
        ),
      );
    });

    test('Sign up user returns authfailure from Exception', () async {
      provideDummy<Either<Failure, UserDto>>(Right(userDto));
      const userDetailsEntity = UserSignUpDetailsEntity(
        email: 'test@email.com',
        password: 'testpassword',
        completeName: 'test test',
        photoUrl: 'test',
      );

      when(mockFirebaseDataSource.signUpUser('test@email.com', 'testpassword'))
          .thenThrow(Exception());

      final response = await sut.signUpUser(userDetailsEntity);
      expect(
        response,
        equals(
          const Left(
            AuthFailure(message: 'An unknown error occured.'),
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

    test('Sign out user fails with authfailure from exception', () async {
      when(mockFirebaseDataSource.signOutUser()).thenThrow(Exception());

      final response = await sut.signOutUser();
      expect(
        response,
        const Left(AuthFailure(message: 'An unknown error occured')),
      );
      verify(mockFirebaseDataSource.signOutUser()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });

    test('Sign out user fails with authfailure from FirebaseAuthException',
        () async {
      when(mockFirebaseDataSource.signOutUser())
          .thenThrow(FirebaseAuthException(code: 'test'));

      final response = await sut.signOutUser();
      expect(
        response,
        const Left(AuthFailure(message: 'An unknown error occured.')),
      );
      verify(mockFirebaseDataSource.signOutUser()).called(1);
      verifyNoMoreInteractions(mockFirebaseDataSource);
    });
  });
}
