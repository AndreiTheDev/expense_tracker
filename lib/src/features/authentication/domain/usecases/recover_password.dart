// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../repositories/authentication_repository.dart';

class RecoverPassword {
  final AuthenticationRepository _repository;
  final Logger _logger = getLogger(RecoverPassword);

  RecoverPassword(this._repository);

  Future<Either<Failure, void>> call(
    final String email,
  ) async {
    _logger.d('call');
    return _repository.recoverPassword(email);
  }
}
