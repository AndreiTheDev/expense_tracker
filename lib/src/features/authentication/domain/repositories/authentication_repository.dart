import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../entities/user_details.dart';

abstract interface class AuthenticationRepository {
  Future<Either<Failure, UserEntity>> signInUser(
    final String email,
    final String password,
  );

  Future<Either<Failure, UserEntity>> signUpUser(
    final UserDetailsEntity userDetails,
  );

  Future<Either<Failure, void>> signOutUser();

  Future<Either<Failure, void>> deleteUser();

  Future<Either<Failure, UserEntity?>> isSignedIn();

  Future<Either<Failure, void>> recoverPassword(final String email);
}
