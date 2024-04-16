import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../repository/switch_account_repository.dart';

class FetchAccountsList {
  final SwitchAccountRepository _repository;
  final Logger _logger = getLogger(FetchAccountsList);

  FetchAccountsList(this._repository);

  Future<Either<Failure, void>> call() {
    _logger.d('call');
    return _repository.fetchAccountsList();
  }
}
