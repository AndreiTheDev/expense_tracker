// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/user.dart';
import '../repositories/authentication_repository.dart';

class IsSignedInUser {
  final AuthenticationRepository _repository;

  IsSignedInUser(this._repository);

  Future<Either<Failure, UserEntity>> call() async {
    return _repository.isSignedIn();
  }
}
