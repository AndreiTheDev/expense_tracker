import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/income.dart';
import '../repositories/account_repository.dart';

class AddIncome {
  final AccountRepository _repository;

  AddIncome(this._repository);

  Future<Either<Failure, AccountEntity>> call(
    final String accountId,
    final IncomeEntity entity,
  ) async {
    final response = await _repository.addIncome(
      accountId: accountId,
      incomeEntity: entity,
    );
    return response.fold(Left.new, (r) => _repository.fetchAccount());
  }
}
