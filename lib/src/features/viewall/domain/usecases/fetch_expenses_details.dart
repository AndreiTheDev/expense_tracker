import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/expenses_details.dart';
import '../repositories/viewall_repository.dart';

class FetchExpensesDetails {
  final ViewallRepository _repository;

  FetchExpensesDetails(this._repository);

  Future<Either<Failure, ExpensesDetailsEntity>> call({
    required final String accountId,
  }) {
    return _repository.fetchExpensesDetails(
      accountId: accountId,
    );
  }
}
