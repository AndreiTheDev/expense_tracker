import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/income.dart';
import '../repositories/viewall_repository.dart';

class FetchIncomes {
  final ViewallRepository _repository;

  FetchIncomes(this._repository);

  Future<Either<Failure, List<IncomeEntity>>> call({
    required final String accountId,
  }) {
    return _repository.fetchIncomes(
      accountId: accountId,
    );
  }
}
