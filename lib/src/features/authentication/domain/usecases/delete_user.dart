// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/authentication_repository.dart';

class DeleteUser {
  final AuthenticationRepository _repository;

  DeleteUser(this._repository);

  Future<Either<Failure, void>> call() async {
    return _repository.deleteUser();
  }
}
