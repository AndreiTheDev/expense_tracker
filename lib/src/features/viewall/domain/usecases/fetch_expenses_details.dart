import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/expenses_details.dart';
import '../repositories/viewall_repository.dart';

class FetchExpensesDetails {
  final ViewallRepository _repository;
  final Logger _logger = getLogger(FetchExpensesDetails);

  FetchExpensesDetails(this._repository);

  Future<Either<Failure, ExpensesDetailsEntity>> call({
    required final String accountId,
  }) {
    _logger.d('call');
    return _repository.fetchExpensesDetails(
      accountId: accountId,
    );
  }
}
