import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../entities/expense.dart';
import '../entities/expenses_details.dart';
import '../entities/income.dart';
import '../entities/incomes_details.dart';

abstract interface class ViewallRepository {
  Future<Either<Failure, ExpensesDetailsEntity>> fetchExpensesDetails({
    final String accountId,
  });

  Future<Either<Failure, IncomesDetailsEntity>> fetchIncomesDetails({
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
