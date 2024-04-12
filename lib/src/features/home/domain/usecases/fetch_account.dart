import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/account.dart';
import '../repositories/account_repository.dart';

class FetchAccount {
  final AccountRepository _repository;
  final Logger _logger = getLogger(FetchAccount);

  FetchAccount(this._repository);

  Future<Either<Failure, AccountEntity>> call({
    required final String accountId,
  }) async {
    _logger.d('call');
    return _repository.fetchAccount(accountId: accountId);
  }
}
