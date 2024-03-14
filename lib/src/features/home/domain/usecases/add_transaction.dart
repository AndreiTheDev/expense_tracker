import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/transaction.dart';
import '../repositories/account_repository.dart';

class AddTransaction {
  final AccountRepository _repository;

  AddTransaction(this._repository);

  Future<Either<Failure, void>> call(final TransactionEntity entity) async {
    return _repository.addTransaction(entity: entity);
  }
}
