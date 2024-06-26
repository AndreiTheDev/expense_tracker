// Mocks generated by Mockito 5.4.4 from annotations
// in expense_tracker_app_bloc/test/src/features/authentication/domain/usecases/recover_password_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:expense_tracker_app_bloc/src/core/error/failures.dart' as _i5;
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user.dart'
    as _i6;
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_signup_details.dart'
    as _i8;
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/authentication_repository.dart'
    as _i2;
import 'package:fpdart/fpdart.dart' as _i4;
import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [AuthenticationRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockAuthenticationRepository extends _i1.Mock
    implements _i2.AuthenticationRepository {
  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>> signInUser(
    String? email,
    String? password,
  ) =>
      (super.noSuchMethod(
        Invocation.method(
          #signInUser,
          [
            email,
            password,
          ],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, _i6.UserEntity>>(
          this,
          Invocation.method(
            #signInUser,
            [
              email,
              password,
            ],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, _i6.UserEntity>>(
          this,
          Invocation.method(
            #signInUser,
            [
              email,
              password,
            ],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>> signUpUser(
          _i8.UserSignUpDetailsEntity? userDetails) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUpUser,
          [userDetails],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, _i6.UserEntity>>(
          this,
          Invocation.method(
            #signUpUser,
            [userDetails],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, _i6.UserEntity>>(
          this,
          Invocation.method(
            #signUpUser,
            [userDetails],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, void>> signOutUser() =>
      (super.noSuchMethod(
        Invocation.method(
          #signOutUser,
          [],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, void>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #signOutUser,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, void>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #signOutUser,
            [],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, void>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, void>> deleteUser(String? password) =>
      (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [password],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, void>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #deleteUser,
            [password],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, void>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #deleteUser,
            [password],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, void>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity?>> isSignedIn() =>
      (super.noSuchMethod(
        Invocation.method(
          #isSignedIn,
          [],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity?>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, _i6.UserEntity?>>(
          this,
          Invocation.method(
            #isSignedIn,
            [],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity?>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, _i6.UserEntity?>>(
          this,
          Invocation.method(
            #isSignedIn,
            [],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, _i6.UserEntity?>>);

  @override
  _i3.Future<_i4.Either<_i5.Failure, void>> recoverPassword(String? email) =>
      (super.noSuchMethod(
        Invocation.method(
          #recoverPassword,
          [email],
        ),
        returnValue: _i3.Future<_i4.Either<_i5.Failure, void>>.value(
            _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #recoverPassword,
            [email],
          ),
        )),
        returnValueForMissingStub:
            _i3.Future<_i4.Either<_i5.Failure, void>>.value(
                _i7.dummyValue<_i4.Either<_i5.Failure, void>>(
          this,
          Invocation.method(
            #recoverPassword,
            [email],
          ),
        )),
      ) as _i3.Future<_i4.Either<_i5.Failure, void>>);
}
