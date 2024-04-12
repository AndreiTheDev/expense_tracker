import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/account.dart';
import '../entities/expense.dart';
import '../repositories/account_repository.dart';

class DeleteExpense {
  final AccountRepository _repository;
  final Logger _logger = getLogger(DeleteExpense);

  DeleteExpense(this._repository);

  Future<Either<Failure, AccountEntity>> call(
    final String accountId,
    final ExpenseEntity expenseEntity,
  ) async {
    _logger.d('called');
    final response = await _repository.deleteExpense(
      accountId: accountId,
      expenseEntity: expenseEntity,
    );
    return response.fold(
      Left.new,
      (r) => _repository.fetchAccount(
        accountId: accountId,
      ),
    );
  }
}
