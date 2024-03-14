import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/account_repository.dart';

class DeleteTransaction {
  final AccountRepository _repository;

  DeleteTransaction(this._repository);

  Future<Either<Failure, void>> call(final String id) async {
    return _repository.deleteTransaction(id: id);
  }
}
