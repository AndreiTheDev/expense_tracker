import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class DeleteIncome {
  final AccountRepository _repository;

  DeleteIncome(this._repository);

  Future<Either<Failure, AccountEntity>> call(final String id) async {
    final response = await _repository.deleteIncome(incomeId: id);
    return response.fold(Left.new, (r) => _repository.fetchAccount());
  }
}
