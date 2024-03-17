import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class DeleteTransaction {
  final AccountRepository _repository;

  DeleteTransaction(this._repository);

  Future<Either<Failure, AccountEntity>> call(
    final String accountId,
    final String id,
  ) async {
    final response = await _repository.deleteTransaction(
      accountId: accountId,
      transactionId: id,
    );
    return response.fold(Left.new, (r) => _repository.fetchAccount());
  }
}
