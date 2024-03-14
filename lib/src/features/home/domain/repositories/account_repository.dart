import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/transaction.dart';

abstract interface class AccountRepository {
  Future<Either<Failure, AccountEntity>> fetchAccount({
    final String id = 'defaultAccount',
  });

  Future<Either<Failure, void>> addTransaction({
    required final TransactionEntity entity,
  });

  Future<Either<Failure, void>> deleteTransaction({
    required final String id,
  });
}
