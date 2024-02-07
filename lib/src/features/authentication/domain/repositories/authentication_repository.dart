import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';

abstract interface class AuthenticationRepository {
  Future<Either<Failure, UserEntity>> signInUser(
    final String email,
    final String password,
  );

  Future<Either<Failure, UserEntity>> signUpUser(
    final String email,
    final String password,
  );

  Future<Either<Failure, void>> signOutUser();

  Future<Either<Failure, void>> deleteUser();

  Future<Either<Failure, UserEntity>> isSignedIn();

  Future<Either<Failure, void>> recoverPassword(final String email);
}
