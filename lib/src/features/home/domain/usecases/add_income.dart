import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/account.dart';
import '../entities/income.dart';
import '../repositories/account_repository.dart';

class AddIncome {
  final AccountRepository _repository;
  final Logger _logger = getLogger(AddIncome);

  AddIncome(this._repository);

  Future<Either<Failure, AccountEntity>> call({
    required final String accountId,
    required final IncomeEntity incomeEntity,
  }) async {
    _logger.d('call');
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
