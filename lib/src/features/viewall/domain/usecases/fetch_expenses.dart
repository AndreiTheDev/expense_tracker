import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/expense.dart';
import '../repositories/viewall_repository.dart';

class FetchExpenses {
  final ViewallRepository _repository;

  FetchExpenses(this._repository);

  Future<Either<Failure, List<ExpenseEntity>>> call({
    required final String accountId,
  }) {
    return _repository.fetchExpenses(
      accountId: accountId,
    );
  }
}
