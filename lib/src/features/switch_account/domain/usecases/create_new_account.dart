import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/account.dart';
import '../repository/switch_account_repository.dart';

class CreateNewAccount {
  final SwitchAccountRepository _repository;
  final Logger _logger = getLogger(CreateNewAccount);

  CreateNewAccount(this._repository);

  Future<Either<Failure, void>> call({
    required final AccountEntity account,
  }) {
    _logger.d('call');
    return _repository.createNewAccount(account);
  }
}
