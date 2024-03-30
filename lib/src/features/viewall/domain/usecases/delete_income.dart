import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/income.dart';
import '../entities/incomes_details.dart';
import '../repositories/viewall_repository.dart';

class DeleteIncome {
  final ViewallRepository _repository;

  DeleteIncome(this._repository);

  Future<Either<Failure, IncomesDetailsEntity>> call({
    required final String accountId,
    required final IncomeEntity incomeEntity,
  }) async {
    final response = await _repository.deleteIncome(
      accountId: accountId,
      incomeEntity: incomeEntity,
    );
    return response.fold(
      Left.new,
      (r) => _repository.fetchIncomesDetails(accountId: accountId),
    );
  }
}
