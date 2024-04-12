import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/expense.dart';
import '../entities/expenses_details.dart';
import '../repositories/viewall_repository.dart';

class DeleteExpense {
  final ViewallRepository _repository;
  final Logger _logger = getLogger(DeleteExpense);

  DeleteExpense(this._repository);

  Future<Either<Failure, ExpensesDetailsEntity>> call({
    required final String accountId,
    required final ExpenseEntity expenseEntity,
  }) async {
    _logger.d('call');
    final response = await _repository.deleteExpense(
      accountId: accountId,
      expenseEntity: expenseEntity,
    );
    return response.fold(
      Left.new,
      (r) => _repository.fetchExpensesDetails(accountId: accountId),
    );
  }
}
