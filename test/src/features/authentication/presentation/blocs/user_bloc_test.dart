import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_signup_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/delete_user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/is_signed_in_user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/recover_password.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/sign_in_user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/sign_out_user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/sign_up_user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'user_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<IsSignedInUser>(),
  MockSpec<SignInUser>(),
  MockSpec<SignUpUser>(),
  MockSpec<SignOutUser>(),
  MockSpec<RecoverPassword>(),
  MockSpec<DeleteUser>(),
])
void main() {
  group('UserBloc tests', () {
    late UserEntity user;
    late UserSignUpDetailsEntity userDetailsEntity;
    late MockIsSignedInUser mockIsSignedInUser;
    late MockSignInUser mockSignInUser;
    late MockSignUpUser mockSignUpUser;
    late MockSignOutUser mockSignOutUser;
    late MockRecoverPassword mockRecoverPassword;
    late MockDeleteUser mockDeleteUser;
    late UserBloc userBloc;
    setUp(() {
      user = const UserEntity(
        uid: 'test',
        email: 'test@gmail.com',
        fcmToken: 'testFcm',
        completeName: 'test test',
        photoUrl: 'test',
      );
      userDetailsEntity = const UserSignUpDetailsEntity(
        email: 'test@gmail.com',
        password: 'testpass',
        completeName: 'test test',
        photoUrl: 'test',
      );
      mockIsSignedInUser = MockIsSignedInUser();
      mockSignInUser = MockSignInUser();
      mockSignUpUser = MockSignUpUser();
      mockSignOutUser = MockSignOutUser();
      mockRecoverPassword = MockRecoverPassword();
      mockDeleteUser = MockDeleteUser();

      userBloc = UserBloc(
        isSignedInUser: mockIsSignedInUser,
        signInUser: mockSignInUser,
        signUpUser: mockSignUpUser,
        signOutUser: mockSignOutUser,
        recoverPassword: mockRecoverPassword,
        deleteUser: mockDeleteUser,
      );
    });

    test('Initial state is UserLoading', () {
      expect(userBloc.state, isA<UserLoading>());
    });

    blocTest(
      'UserStarted event updates states to UserAuthenticated',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, UserEntity?>>(Right(user));
        when(mockIsSignedInUser.call()).thenAnswer(
          (realInvocation) async => Right(user),
        );
      },
      act: (bloc) => bloc.add(UserStarted()),
      expect: () => [UserLoading(), UserAuthenticated(user)],
    );

    blocTest(
      'UserStarted event updates states to UserUnauthenticated',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, UserEntity?>>(const Right(null));
        when(mockIsSignedInUser.call()).thenAnswer(
          (realInvocation) async => const Right(null),
        );
      },
      act: (bloc) => bloc.add(UserStarted()),
      expect: () => [UserLoading(), UserUnauthenticated()],
    );

    blocTest(
      'UserStarted event updates states to UserError',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, UserEntity?>>(
          const Left(AuthFailure(message: 'test')),
        );
        when(mockIsSignedInUser.call()).thenAnswer(
          (realInvocation) async => const Left(AuthFailure(message: 'test')),
        );
      },
      act: (bloc) => bloc.add(UserStarted()),
      expect: () => [UserLoading(), UserUnauthenticated()],
    );

    blocTest(
      'UserSignInEvent updates states to UserAuthenticated',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, UserEntity>>(
          Right(user),
        );
        when(mockSignInUser.call('test@gmail.com', 'testpass')).thenAnswer(
          (realInvocation) async => Right(user),
        );
      },
      act: (bloc) => bloc.add(
        const UserSignInEvent(email: 'test@gmail.com', password: 'testpass'),
      ),
      expect: () => [UserLoading(), UserAuthenticated(user)],
    );

    blocTest(
      'UserSignInEvent updates states to UserError',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, UserEntity>>(
          const Left(AuthFailure(message: 'test')),
        );
        when(mockSignInUser.call('test@gmail.com', 'testpass')).thenAnswer(
          (realInvocation) async => const Left(AuthFailure(message: 'test')),
        );
      },
      act: (bloc) => bloc.add(
        const UserSignInEvent(email: 'test@gmail.com', password: 'testpass'),
      ),
      expect: () => [UserLoading(), UserUnauthenticated()],
    );

    blocTest(
      'UserSignUpEvent updates states to UserAuthenticated',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, UserEntity>>(
          Right(user),
        );
        when(mockSignUpUser.call(userDetailsEntity)).thenAnswer(
          (realInvocation) async => Right(user),
        );
      },
      act: (bloc) => bloc.add(
        UserSignUpEvent(userDetailsEntity: userDetailsEntity),
      ),
      expect: () => [UserLoading(), UserAuthenticated(user)],
    );

    blocTest(
      'UserSignUpEvent updates states to UserError',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, UserEntity>>(
          const Left(AuthFailure(message: 'test')),
        );
        when(mockSignUpUser.call(userDetailsEntity)).thenAnswer(
          (realInvocation) async => const Left(AuthFailure(message: 'test')),
        );
      },
      act: (bloc) => bloc.add(
        UserSignUpEvent(userDetailsEntity: userDetailsEntity),
      ),
      expect: () => [UserLoading(), UserUnauthenticated()],
    );

    blocTest(
      'UserSignOutEvent updates states to UserUnauthenticated',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, void>>(
          const Right(null),
        );
        when(mockSignOutUser.call()).thenAnswer(
          (realInvocation) async => const Right(null),
        );
      },
      act: (bloc) => bloc.add(
        UserSignOutEvent(),
      ),
      expect: () => [UserUnauthenticated()],
    );

    blocTest(
      'UserSignOutEvent updates states to UserError',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, void>>(
          const Left(AuthFailure(message: 'test')),
        );
        when(mockSignOutUser.call()).thenAnswer(
          (realInvocation) async => const Left(AuthFailure(message: 'test')),
        );
      },
      act: (bloc) => bloc.add(
        UserSignOutEvent(),
      ),
      expect: () => [],
    );

    blocTest(
      'UserRecoverPasswordEvent updates states to UserUnauthenticated',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, void>>(
          const Right(null),
        );
        when(mockRecoverPassword.call('test@gmail.com')).thenAnswer(
          (realInvocation) async => const Right(null),
        );
      },
      act: (bloc) => bloc.add(
        const UserRecoverPasswordEvent(email: 'test@gmail.com'),
      ),
      expect: () => [UserLoading(), UserUnauthenticated()],
    );

    blocTest(
      'UserRecoverPasswordEvent updates states to UserError',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, void>>(
          const Left(AuthFailure(message: 'test')),
        );
        when(mockRecoverPassword.call('test@gmail.com')).thenAnswer(
          (realInvocation) async => const Left(AuthFailure(message: 'test')),
        );
      },
      act: (bloc) => bloc.add(
        const UserRecoverPasswordEvent(email: 'test@gmail.com'),
      ),
      expect: () => [UserLoading(), UserUnauthenticated()],
    );

    blocTest(
      'UserDeleteUserEvent updates states to UserUnauthenticated',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, void>>(
          const Right(null),
        );
        when(mockDeleteUser.call('test')).thenAnswer(
          (realInvocation) async => const Right(null),
        );
      },
      act: (bloc) => bloc.add(
        const UserDeleteUserEvent(password: 'test'),
      ),
      expect: () => [UserUnauthenticated()],
    );

    blocTest(
      'UserDeleteUserEvent fails and does not update state',
      build: () => userBloc,
      setUp: () async {
        provideDummy<Either<Failure, void>>(
          const Left(AuthFailure(message: 'test')),
        );
        when(mockDeleteUser.call('test')).thenAnswer(
          (realInvocation) async => const Left(AuthFailure(message: 'test')),
        );
      },
      act: (bloc) => bloc.add(
        const UserDeleteUserEvent(password: 'test'),
      ),
      expect: () => [],
    );
  });
}
