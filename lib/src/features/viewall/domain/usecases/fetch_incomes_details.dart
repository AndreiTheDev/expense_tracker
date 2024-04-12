import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../entities/incomes_details.dart';
import '../repositories/viewall_repository.dart';

class FetchIncomesDetails {
  final ViewallRepository _repository;
  final Logger _logger = getLogger(FetchIncomesDetails);

  FetchIncomesDetails(this._repository);

  Future<Either<Failure, IncomesDetailsEntity>> call({
    required final String accountId,
  }) {
    _logger.d('call');
    return _repository.fetchIncomesDetails(
      accountId: accountId,
    );
  }
}
