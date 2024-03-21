import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/expense.dart';
import '../repositories/account_repository.dart';

class AddExpense {
  final AccountRepository _repository;

  AddExpense(this._repository);

  Future<Either<Failure, AccountEntity>> call({
    required final String accountId,
    required final ExpenseEntity expenseEntity,
  }) async {
    final response = await _repository.addExpense(
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
