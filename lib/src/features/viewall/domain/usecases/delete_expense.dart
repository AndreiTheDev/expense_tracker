import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/expense.dart';
import '../repositories/viewall_repository.dart';

class DeleteExpense {
  final ViewallRepository _repository;

  DeleteExpense(this._repository);

  Future<Either<Failure, void>> call({
    required final String accountId,
    required final ExpenseEntity expenseEntity,
  }) {
    return _repository.deleteExpense(
      accountId: accountId,
      expenseEntity: expenseEntity,
    );
  }
}
