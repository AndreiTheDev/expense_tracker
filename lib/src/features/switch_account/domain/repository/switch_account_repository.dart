import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';

abstract interface class SwitchAccountRepository {
  Future<Either<Failure, List<AccountEntity>>> fetchAccountsList();

  Future<Either<Failure, void>> createNewAccount(
    final AccountEntity account,
  );
}
