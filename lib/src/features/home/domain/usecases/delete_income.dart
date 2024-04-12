import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/account.dart';
import '../entities/income.dart';
import '../repositories/account_repository.dart';

class DeleteIncome {
  final AccountRepository _repository;
  final Logger _logger = getLogger(DeleteIncome);

  DeleteIncome(this._repository);

  Future<Either<Failure, AccountEntity>> call(
    final String accountId,
    final IncomeEntity incomeEntity,
  ) async {
    _logger.d('called');
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
