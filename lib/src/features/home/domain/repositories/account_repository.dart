import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/expense.dart';
import '../entities/income.dart';

abstract interface class AccountRepository {
  Future<Either<Failure, AccountEntity>> fetchAccount({
    final String id = 'defaultAccount',
  });

  Future<Either<Failure, void>> addExpense({
    required final ExpenseEntity expenseEntity,
  });

  Future<Either<Failure, void>> addIncome({
    required final IncomeEntity incomeEntity,
  });

  Future<Either<Failure, void>> deleteExpense({
    required final String expenseId,
  });

  Future<Either<Failure, void>> deleteIncome({
    required final String incomeId,
  });

  Future<Either<Failure, void>> deleteTransaction({
    required final String transactionId,
  });
}
