import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/income.dart';
import '../repositories/account_repository.dart';

class AddIncome {
  final AccountRepository _repository;

  AddIncome(this._repository);

  Future<Either<Failure, AccountEntity>> call({
    required final String accountId,
    required final IncomeEntity incomeEntity,
  }) async {
    final response = await _repository.addIncome(
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
