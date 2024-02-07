// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class SignUpUser {
  final AuthenticationRepository _repository;

  SignUpUser(this._repository);

  Future<Either<Failure, UserEntity>> call(
    final String email,
    final String password,
  ) async {
    return _repository.signUpUser(email, password);
  }
}
