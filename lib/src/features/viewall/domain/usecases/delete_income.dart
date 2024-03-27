import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/income.dart';
import '../repositories/viewall_repository.dart';

class DeleteIncome {
  final ViewallRepository _repository;

  DeleteIncome(this._repository);

  Future<Either<Failure, void>> call({
    required final String accountId,
    required final IncomeEntity incomeEntity,
  }) {
    return _repository.deleteIncome(
      accountId: accountId,
      incomeEntity: incomeEntity,
    );
  }
}
