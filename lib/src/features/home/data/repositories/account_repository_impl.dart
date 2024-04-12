import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/account.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/income.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/repositories/account_repository.dart';
import '../datasources/home_firebase_datasource.dart';
import '../datasources/home_firestore_datasource.dart';
import '../dto/account.dart';
import '../dto/expense.dart';
import '../dto/income.dart';
import '../dto/transaction.dart';

class AccountRepositoryImpl implements AccountRepository {
  final HomeFirebaseDataScource firebaseDataScource;
  final HomeFirestoreDataSource firestoreDataSource;
  final Logger _logger = getLogger(AccountRepositoryImpl);

  AccountRepositoryImpl(this.firebaseDataScource, this.firestoreDataSource);

  @override
  Future<Either<Failure, void>> deleteTransaction({
    required final String accountId,
    required TransactionEntity transactionEntity,
  }) async {
    _logger.d('''
deleteTransaction - called - params: 
        {accountId: $accountId, 
        transactionEntity: $transactionEntity,}''');
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.deleteTransaction(
          uid,
          accountId,
          TransactionDto.fromEntity(transactionEntity),
        );
        _logger.i('deleteTransaction - success');
        return const Right(null);
      }
      _logger.e('deleteTransaction - user is not authenticated');
      return const Left(
        HomeFailure(message: 'Unable to delete expense from database.'),
      );
    } on FirebaseException catch (e) {
      _logger.e('deleteTransaction - FirebaseException: ${e.code}');
      return Left(HomeFailure(message: e.code));
    } on Exception {
      _logger.e('deleteTransaction - an unknown error occured');
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, AccountEntity>> fetchAccount({
    String accountId = 'default',
  }) async {
    _logger.d('''
fetchAccount - called - params: 
        {accountId: $accountId,}''');
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        final accountDetails =
            await firestoreDataSource.fetchAccountDetails(uid, accountId);
        final accountTransactions =
            await firestoreDataSource.fetchAccountTransactions(uid, accountId);
        final num accountIncome = accountDetails['income'];
        final num accountExpenses = accountDetails['expenses'];
        final num accountTotalBalance = accountDetails['totalBalance'];
        final accountEntity = AccountDto(
          id: accountDetails['id'],
          name: accountDetails['name'],
          income: accountIncome.toDouble(),
          expenses: accountExpenses.toDouble(),
          totalBalance: accountTotalBalance.toDouble(),
          transactions: [
            for (final Map<String, dynamic> transaction in accountTransactions)
              TransactionDto.fromJson(transaction),
          ],
        );
        _logger.i('fetchAccount - success');
        return Right(accountEntity);
      }
      _logger.e('fetchAccount - user is not authenticated');
      return const Left(
        HomeFailure(message: 'Unable to get the account from database.'),
      );
    } on FirebaseException catch (e) {
      _logger.e('fetchAccount - FirebaseException: ${e.code}');
      return Left(HomeFailure(message: e.code));
    } on Exception {
      _logger.e('fetchAccount - an unknown error occured');
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> addExpense({
    required final String accountId,
    required ExpenseEntity expenseEntity,
  }) async {
    _logger.d('''
addExpense - called - params: 
        {accountId: $accountId,
        expenseEntity: $expenseEntity,}''');
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.addExpense(
          uid,
          accountId,
          ExpenseDto.fromEntity(expenseEntity),
        );
        _logger.i('addExpense - success');
        return const Right(null);
      }
      _logger.e('addExpense - user is not authenticated');
      return const Left(
        HomeFailure(message: 'Unable to get the account from database.'),
      );
    } on FirebaseException catch (e) {
      _logger.e('addExpense - FirebaseException: ${e.code}');
      return Left(HomeFailure(message: e.code));
    } on Exception {
      _logger.e('addExpense - an unknown error occured');
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> addIncome({
    required final String accountId,
    required IncomeEntity incomeEntity,
  }) async {
    _logger.d('''
addIncome - called - params: 
        {accountId: $accountId,
        incomeEntity: $incomeEntity,}''');
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.addIncome(
          uid,
          accountId,
          IncomeDto.fromEntity(incomeEntity),
        );
        _logger.i('addIncome - success');
        return const Right(null);
      }
      _logger.e('addIncome - user is not authenticated');
      return const Left(
        HomeFailure(message: 'Unable to get the account from database.'),
      );
    } on FirebaseException catch (e) {
      _logger.e('addIncome - FirebaseException: ${e.code}');
      return Left(HomeFailure(message: e.code));
    } on Exception {
      _logger.e('addIncome - an unknown error occured');
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExpense({
    required final String accountId,
    required ExpenseEntity expenseEntity,
  }) async {
    _logger.d('''
deleteExpense - called - params: 
        {accountId: $accountId,
        expenseEntity: $expenseEntity,}''');
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.deleteExpense(
          uid,
          accountId,
          ExpenseDto.fromEntity(expenseEntity),
        );
        _logger.i('deleteExpense - success');
        return const Right(null);
      }
      _logger.e('deleteExpense - user is not authenticated');
      return const Left(
        HomeFailure(message: 'Unable to delete expense from database.'),
      );
    } on FirebaseException catch (e) {
      _logger.e('deleteExpense - FirebaseException: ${e.code}');
      return Left(HomeFailure(message: e.code));
    } on Exception {
      _logger.e('deleteExpense - an unknown error occured');
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteIncome({
    required final String accountId,
    required IncomeEntity incomeEntity,
  }) async {
    _logger.d('''
deleteIncome - called - params: 
        {accountId: $accountId,
        incomeEntity: $incomeEntity,}''');
    final uid = firebaseDataScource.getUid();
    try {
      if (uid != null) {
        await firestoreDataSource.deleteIncome(
          uid,
          accountId,
          IncomeDto.fromEntity(incomeEntity),
        );
        _logger.i('deleteIncome - success');
        return const Right(null);
      }
      _logger.e('deleteIncome - user is not authenticated');
      return const Left(
        HomeFailure(message: 'Unable to delete expense from database.'),
      );
    } on FirebaseException catch (e) {
      _logger.e('deleteIncome - FirebaseException: ${e.code}');
      return Left(HomeFailure(message: e.code));
    } on Exception {
      _logger.e('deleteIncome - an unknown error occured');
      return const Left(HomeFailure(message: 'An unknown error occured.'));
    }
  }
}
