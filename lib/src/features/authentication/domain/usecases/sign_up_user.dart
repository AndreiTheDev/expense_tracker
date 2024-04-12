// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/user.dart';
import '../entities/user_signup_details.dart';
import '../repositories/authentication_repository.dart';

class SignUpUser {
  final AuthenticationRepository _repository;
  final Logger _logger = getLogger(SignUpUser);

  SignUpUser(this._repository);

  Future<Either<Failure, UserEntity>> call(
    final UserSignUpDetailsEntity userDetails,
  ) async {
    _logger.d('call');
    return _repository.signUpUser(userDetails);
  }
}
