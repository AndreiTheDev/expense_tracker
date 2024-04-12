import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../repositories/authentication_repository.dart';

class SignOutUser {
  final AuthenticationRepository _repository;
  final Logger _logger = getLogger(SignOutUser);
  SignOutUser(this._repository);

  Future<Either<Failure, void>> call() async {
    _logger.d('call');
    return _repository.signOutUser();
  }
}
