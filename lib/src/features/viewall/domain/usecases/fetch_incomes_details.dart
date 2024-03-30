import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/incomes_details.dart';
import '../repositories/viewall_repository.dart';

class FetchIncomesDetails {
  final ViewallRepository _repository;

  FetchIncomesDetails(this._repository);

  Future<Either<Failure, IncomesDetailsEntity>> call({
    required final String accountId,
  }) {
    return _repository.fetchIncomesDetails(
      accountId: accountId,
    );
  }
}
