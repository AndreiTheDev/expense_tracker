import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';
import '../repositories/account_repository.dart';

class DeleteTransaction {
  final AccountRepository _repository;

  DeleteTransaction(this._repository);

  Future<Either<Failure, AccountEntity>> call(
    final String accountId,
    final TransactionEntity transactionId,
  ) async {
    final response = await _repository.deleteTransaction(
      accountId: accountId,
      transactionEntity: transactionId,
    );
    return response.fold(Left.new, (r) => _repository.fetchAccount());
  }
}
