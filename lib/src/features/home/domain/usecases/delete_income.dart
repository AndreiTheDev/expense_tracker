import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/income.dart';
import '../repositories/account_repository.dart';

class DeleteIncome {
  final AccountRepository _repository;

  DeleteIncome(this._repository);

  Future<Either<Failure, AccountEntity>> call(
    final String accountId,
    final IncomeEntity incomeEntity,
  ) async {
    final response = await _repository.deleteIncome(
      accountId: accountId,
      incomeEntity: incomeEntity,
    );
    return response.fold(
      Left.new,
      (r) => _repository.fetchAccount(
        accountId: accountId,
      ),
    );
  }
}
