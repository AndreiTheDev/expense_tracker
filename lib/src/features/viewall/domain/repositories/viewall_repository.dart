import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/expense.dart';
import '../entities/income.dart';

abstract interface class ViewallRepository {
  Future<Either<Failure, List<ExpenseEntity>>> fetchExpenses({
    final String accountId,
  });

  Future<Either<Failure, List<IncomeEntity>>> fetchIncomes({
    final String accountId,
  });

  Future<Either<Failure, void>> deleteExpense({
    required final String accountId,
    required final ExpenseEntity expenseEntity,
  });

  Future<Either<Failure, void>> deleteIncome({
    required final String accountId,
    required final IncomeEntity incomeEntity,
  });
}
