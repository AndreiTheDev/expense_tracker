import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/expense.dart';
import '../repositories/account_repository.dart';

class AddExpense {
  final AccountRepository _repository;

  AddExpense(this._repository);

  Future<Either<Failure, AccountEntity>> call(
    final ExpenseEntity entity,
  ) async {
    final response = await _repository.addExpense(expenseEntity: entity);
    return response.fold(Left.new, (r) => _repository.fetchAccount());
  }
}
