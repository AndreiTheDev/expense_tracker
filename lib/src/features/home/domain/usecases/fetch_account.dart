import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class FetchAccount {
  final AccountRepository _repository;

  FetchAccount(this._repository);

  Future<Either<Failure, AccountEntity>> call(final String id) async {
    return _repository.fetchAccount(id: id);
  }
}
