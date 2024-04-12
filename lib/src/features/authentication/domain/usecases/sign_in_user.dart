// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class SignInUser {
  final AuthenticationRepository _repository;
  final Logger _logger = getLogger(SignInUser);

  SignInUser(this._repository);

  Future<Either<Failure, UserEntity>> call(
    final String email,
    final String password,
  ) async {
    _logger.d('call');
    return _repository.signInUser(email, password);
  }
}
