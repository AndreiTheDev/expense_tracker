import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/income.dart';

import '../../domain/repositories/viewall_repository.dart';
import '../datasources/viewall_firebase_datasource.dart';
import '../datasources/viewall_firestore_datasource.dart';
import '../dtos/expense.dart';
import '../dtos/income.dart';

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
  Future<Either<Failure, List<ExpenseEntity>>> fetchExpenses({
    String accountId = 'default',
  }) async {
    try {
      final uid = firebaseDataSource.getUid();
      if (uid != null) {
        final response =
            await firestoreDataSource.fetchExpenses(uid, accountId);
        return Right(
          [
            for (final expense in response) ExpenseDto.fromJson(expense),
          ],
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
  Future<Either<Failure, List<IncomeEntity>>> fetchIncomes({
    String accountId = 'default',
  }) async {
    try {
      final uid = firebaseDataSource.getUid();
      if (uid != null) {
        final response = await firestoreDataSource.fetchIncomes(uid, accountId);
        return Right(
          [
            for (final income in response) IncomeDto.fromJson(income),
          ],
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
