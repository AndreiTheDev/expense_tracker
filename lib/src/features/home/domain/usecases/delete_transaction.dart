import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';
import '../repositories/account_repository.dart';

class DeleteTransaction {
  final AccountRepository _repository;
  final Logger _logger = getLogger(DeleteTransaction);

  DeleteTransaction(this._repository);

  Future<Either<Failure, AccountEntity>> call({
    required final String accountId,
    required final TransactionEntity transactionEntity,
  }) async {
    _logger.d('called');
    final response = await _repository.deleteTransaction(
      accountId: accountId,
      transactionEntity: transactionEntity,
    );
    return response.fold(
      Left.new,
      (r) => _repository.fetchAccount(
        accountId: accountId,
      ),
    );
  }
}
