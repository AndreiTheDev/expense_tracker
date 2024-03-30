import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/expenses_details.dart';
import '../../domain/entities/income.dart';

import '../../domain/entities/incomes_details.dart';
import '../../domain/repositories/viewall_repository.dart';
import '../datasources/viewall_firebase_datasource.dart';
import '../datasources/viewall_firestore_datasource.dart';
import '../dtos/expense.dart';
import '../dtos/expenses_details.dart';
import '../dtos/income.dart';
import '../dtos/incomes_details.dart';

class ViewallRepositoryImpl implements ViewallRepository {
  final ViewallFirebaseDataSource firebaseDataSource;
  final ViewallFirestoreDataSource firestoreDataSource;

  ViewallRepositoryImpl(this.firebaseDataSource, this.firestoreDataSource);

  @override
  Future<Either<Failure, void>> deleteExpense({
    required String accountId,
    required ExpenseEntity expenseEntity,
  }) async {
    try {
      final uid = firebaseDataSource.getUid();
      if (uid != null) {
        await firestoreDataSource.deleteExpense(
          uid,
          accountId,
          ExpenseDto.fromEntity(expenseEntity),
        );
        return const Right(null);
      }
      return const Left(HomeFailure(message: 'Unable to delete this expense.'));
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteIncome({
    required String accountId,
    required IncomeEntity incomeEntity,
  }) async {
    try {
      final uid = firebaseDataSource.getUid();
      if (uid != null) {
        await firestoreDataSource.deleteIncome(
          uid,
          accountId,
          IncomeDto.fromEntity(incomeEntity),
        );
        return const Right(null);
      }
      return const Left(HomeFailure(message: 'Unable to delete this income.'));
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, ExpensesDetailsEntity>> fetchExpensesDetails({
    String accountId = 'default',
  }) async {
    try {
      final uid = firebaseDataSource.getUid();
      if (uid != null) {
        final expensesList =
            await firestoreDataSource.fetchExpensesList(uid, accountId);
        final expensesChart =
            await firestoreDataSource.fetchExpensesChart(uid, accountId);
        return Right(
          ExpensesDetailsDto.fromDtos(expensesList, null),
        );
      }
      return const Left(HomeFailure(message: 'Unable to fetch expenses.'));
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, IncomesDetailsEntity>> fetchIncomesDetails({
    String accountId = 'default',
  }) async {
    try {
      final uid = firebaseDataSource.getUid();
      if (uid != null) {
        final incomesList =
            await firestoreDataSource.fetchIncomesList(uid, accountId);
        final incomesChart =
            await firestoreDataSource.fetchIncomesChart(uid, accountId);
        return Right(
          IncomesDetailsDto.fromDtos(incomesList, null),
        );
      }
      return const Left(HomeFailure(message: 'Unable to fetch incomes.'));
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }
}
