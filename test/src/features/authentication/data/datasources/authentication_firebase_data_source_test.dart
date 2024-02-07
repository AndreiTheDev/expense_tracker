import 'package:expense_tracker_app_bloc/src/core/error/exceptions.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_firebase_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_firebase_data_source_test.mocks.dart';

@GenerateNiceMocks(
  [MockSpec<FirebaseAuth>(), MockSpec<User>(), MockSpec<UserCredential>()],
)
void main() {
  group('Authentication Firebase Data Source tests', () {
    late AuthenticationFirebaseDataSourceImpl sut;
    late MockFirebaseAuth mockFirebaseAuth;
    late MockUser mockUser;
    late MockUserCredential mockCredential;

    setUp(() {
      mockUser = MockUser();
      mockCredential = MockUserCredential();
      mockFirebaseAuth = MockFirebaseAuth();
      sut = AuthenticationFirebaseDataSourceImpl(mockFirebaseAuth);
    });

    test('Deleting current user is successful', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      when(mockUser.delete())
          .thenAnswer((realInvocation) => Future(() => null));

      await sut.deleteUser();

      verify(mockUser.delete()).called(1);
      verifyNoMoreInteractions(mockUser);
    });

    test('Deleting current user fails', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(null);

      expect(() => sut.deleteUser(), throwsA(isA<AuthException>()));

      verifyNoMoreInteractions(mockUser);
    });

    test('Recover password is sent successful', () async {
      when(mockFirebaseAuth.sendPasswordResetEmail(email: 'test@email.com'))
          .thenAnswer((realInvocation) => Future(() => null));

      await sut.recoverPassword('test@email.com');

      verify(mockFirebaseAuth.sendPasswordResetEmail(email: 'test@email.com'))
          .called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('Is signed in user returns user', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);

      final response = sut.isSignedIn();

      expect(response, mockUser);

      verify(mockFirebaseAuth.currentUser).called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('Is signed in user returns null', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(null);

      final response = sut.isSignedIn();

      expect(response, null);

      verify(mockFirebaseAuth.currentUser).called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('User signs in successfully', () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@email.com',
          password: 'testpassword',
        ),
      ).thenAnswer((realInvocation) async => mockCredential);
      when(mockCredential.user).thenReturn(mockUser);

      final response = await sut.signInUser('test@email.com', 'testpassword');

      expect(response, mockUser);

      verify(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@email.com',
          password: 'testpassword',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('User sign in fails', () async {
      when(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@email.com',
          password: 'testpassword',
        ),
      ).thenAnswer((realInvocation) async => mockCredential);
      when(mockCredential.user).thenReturn(null);

      expect(
        () => sut.signInUser('test@email.com', 'testpassword'),
        throwsA(isA<AuthException>()),
      );

      verify(
        mockFirebaseAuth.signInWithEmailAndPassword(
          email: 'test@email.com',
          password: 'testpassword',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('User signs up successfully', () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@email.com',
          password: 'testpassword',
        ),
      ).thenAnswer((realInvocation) async => mockCredential);
      when(mockCredential.user).thenReturn(mockUser);

      final response = await sut.signUpUser('test@email.com', 'testpassword');

      expect(response, mockUser);

      verify(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@email.com',
          password: 'testpassword',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('User sign up fails', () async {
      when(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@email.com',
          password: 'testpassword',
        ),
      ).thenAnswer((realInvocation) async => mockCredential);
      when(mockCredential.user).thenReturn(null);

      expect(
        () => sut.signUpUser('test@email.com', 'testpassword'),
        throwsA(isA<AuthException>()),
      );

      verify(
        mockFirebaseAuth.createUserWithEmailAndPassword(
          email: 'test@email.com',
          password: 'testpassword',
        ),
      ).called(1);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });

    test('User signs out', () async {
      when(mockFirebaseAuth.currentUser).thenReturn(mockUser);
      expect(mockFirebaseAuth.currentUser, mockUser);

      when(mockFirebaseAuth.signOut())
          .thenAnswer((realInvocation) => Future(() => null));
      when(mockFirebaseAuth.currentUser).thenReturn(null);
      await sut.signOutUser();

      expect(mockFirebaseAuth.currentUser, null);
      verify(mockFirebaseAuth.signOut()).called(1);
      verify(mockFirebaseAuth.currentUser).called(2);
      verifyNoMoreInteractions(mockFirebaseAuth);
    });
  });
}
