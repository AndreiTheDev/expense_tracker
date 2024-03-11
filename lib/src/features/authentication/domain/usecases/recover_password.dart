// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class RecoverPassword {
  final AuthenticationRepository _repository;

  RecoverPassword(this._repository);

  Future<Either<Failure, void>> call(
    final String email,
  ) async {
    return _repository.recoverPassword(email);
  }
}
