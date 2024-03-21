import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/account.dart';
import '../entities/expense.dart';
import '../entities/income.dart';
import '../entities/transaction.dart';

abstract interface class AccountRepository {
  Future<Either<Failure, AccountEntity>> fetchAccount({
    final String accountId,
  });

  Future<Either<Failure, void>> addExpense({
    required final String accountId,
    required final ExpenseEntity expenseEntity,
  });

  Future<Either<Failure, void>> addIncome({
    required final String accountId,
    required final IncomeEntity incomeEntity,
  });

  Future<Either<Failure, void>> deleteExpense({
    required final String accountId,
    required final ExpenseEntity expenseEntity,
  });

  Future<Either<Failure, void>> deleteIncome({
    required final String accountId,
    required final IncomeEntity incomeEntity,
  });

  Future<Either<Failure, void>> deleteTransaction({
    required final String accountId,
    required final TransactionEntity transactionEntity,
  });
}
