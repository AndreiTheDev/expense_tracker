import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/income.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/home_firebase_datasource.dart';
import '../datasources/home_firestore_datasource.dart';
import '../dto/expense.dart';
import '../dto/income.dart';
import '../dto/transaction.dart';

class AccountRepositoryImpl implements AccountRepository {
  final HomeFirebaseDataScource firebaseDataScource;
  final HomeFirestoreDataSource firestoreDataSource;

  AccountRepositoryImpl(this.firebaseDataScource, this.firestoreDataSource);

  @override
  Future<Either<Failure, void>> deleteTransaction({
    required final String accountId,
    required TransactionEntity transactionEntity,
  }) async {
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.deleteTransaction(
          uid,
          accountId,
          TransactionDto.fromEntity(transactionEntity),
        );
        return const Right(null);
      }
      return const Left(
        HomeFailure(message: 'Unable to delete expense from database.'),
      );
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> fetchAccount({
    String id = 'default',
  }) async {
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        final accountDetails =
            await firestoreDataSource.fetchAccountDetails(uid, id);
        final accountTransactions =
            await firestoreDataSource.fetchAccountTransactions(uid, id);
        final accountEntity = AccountEntity(
          id: accountDetails['id'],
          name: accountDetails['name'],
          income: accountDetails['income'],
          expenses: accountDetails['expenses'],
          totalBalance: accountDetails['totalBalance'],
          transactions: [
            for (final Map<String, dynamic> transaction in accountTransactions)
              TransactionDto.fromJson(transaction),
          ],
        );
        return Right(accountEntity);
      }
      return const Left(
        HomeFailure(message: 'Unable to get the account from database.'),
      );
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> addExpense({
    required final String accountId,
    required ExpenseEntity expenseEntity,
  }) async {
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.addExpense(
          uid,
          accountId,
          ExpenseDto.fromEntity(expenseEntity),
        );
        return const Right(null);
      }
      return const Left(
        HomeFailure(message: 'Unable to get the account from database.'),
      );
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> addIncome({
    required final String accountId,
    required IncomeEntity incomeEntity,
  }) async {
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.addIncome(
          uid,
          accountId,
          IncomeDto.fromEntity(incomeEntity),
        );
        return const Right(null);
      }
      return const Left(
        HomeFailure(message: 'Unable to get the account from database.'),
      );
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense({
    required final String accountId,
    required ExpenseEntity expenseEntity,
  }) async {
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.deleteExpense(
          uid,
          accountId,
          ExpenseDto.fromEntity(expenseEntity),
        );
        return const Right(null);
      }
      return const Left(
        HomeFailure(message: 'Unable to delete expense from database.'),
      );
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteIncome({
    required final String accountId,
    required IncomeEntity incomeEntity,
  }) async {
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.deleteIncome(
          uid,
          accountId,
          IncomeDto.fromEntity(incomeEntity),
        );
        return const Right(null);
      }
      return const Left(
        HomeFailure(message: 'Unable to delete expense from database.'),
      );
    } on FirebaseException catch (e) {
      return Left(HomeFailure(message: e.code));
    } on Exception {
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }
}
