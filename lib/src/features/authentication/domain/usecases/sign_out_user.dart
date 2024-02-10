import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class SignOutUser {
  final AuthenticationRepository _repository;

  SignOutUser(this._repository);

  Future<Either<Failure, void>> call() async {
    return _repository.signOutUser();
  }
}
