import 'package:cloud_firestore/cloud_firestore.dart';

import '../dto/expense.dart';
import '../dto/income.dart';
import '../dto/transaction.dart';

abstract interface class HomeFirestoreDataSource {
  Future<Map<String, dynamic>> fetchAccountDetails(
    final String uid,
    final String accountId,
  );

  Future<List<Map<String, dynamic>>> fetchAccountTransactions(
    final String uid,
    final String accountId,
  );

  Future<void> deleteTransaction(
    final String uid,
    final String accountId,
    final TransactionDto transactionDto,
  );
  Future<void> deleteIncome(
    final String uid,
    final String accountId,
    final IncomeDto incomeEntity,
  );
  Future<void> deleteExpense(
    final String uid,
    final String accountId,
    final ExpenseDto expenseEntity,
  );
  Future<void> addExpense(
    final String uid,
    final String accountId,
    final ExpenseDto expenseDto,
  );
  Future<void> addIncome(
    final String uid,
    final String accountId,
    final IncomeDto incomeDto,
  );
}

class HomeFirestoreDataSourceImpl implements HomeFirestoreDataSource {
  final FirebaseFirestore _firestoreInstance;

  HomeFirestoreDataSourceImpl(this._firestoreInstance);

  @override
  Future<void> deleteTransaction(
    final String uid,
    final String accountId,
    final TransactionDto transactionDto,
  ) async {
    final accountRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId);
    final transactionsRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('transactions')
        .doc(transactionDto.id);
    final relatedDocRef = _firestoreInstance.doc(transactionDto.relatedDoc);

    print(relatedDocRef);

    await _firestoreInstance.runTransaction((transaction) async {
      transaction
        ..update(accountRef, {
          transactionDto.amount.isNegative ? 'expenses' : 'income':
              FieldValue.increment(-transactionDto.amount),
          'totalBalance': FieldValue.increment(-transactionDto.amount),
        })
        ..delete(transactionsRef)
        ..delete(relatedDocRef);
    });
  }

  @override
  Future<Map<String, dynamic>> fetchAccountDetails(
    final String uid,
    String accountId,
  ) async {
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .get();
    final data = snapshot.data();
    if (data != null) {
      return data;
    }
    throw Exception('There is no account in the database.');
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAccountTransactions(
    String uid,
    String accountId,
  ) async {
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('transactions')
        .orderBy('date', descending: true)
        .limit(10)
        .get();
    final List<Map<String, dynamic>> data =
        snapshot.docs.map((doc) => doc.data()).toList();
    return data;
  }

  @override
  Future<void> addExpense(
    final String uid,
    final String accountId,
    final ExpenseDto expenseDto,
  ) async {
    final accountRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId);
    final expenseRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('expenses')
        .doc(expenseDto.id);
    final transactionsRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('transactions')
        .doc(expenseDto.id);

    await _firestoreInstance.runTransaction((transaction) async {
      transaction
        ..set(expenseRef, {
          ...expenseDto.toJson(),
          'relatedDoc': transactionsRef.path,
        })
        ..set(transactionsRef, {
          ...expenseDto.toJson(),
          'relatedDoc': expenseRef.path,
        })
        ..update(accountRef, {
          'expenses': FieldValue.increment(expenseDto.amount),
          'totalBalance': FieldValue.increment(expenseDto.amount),
        });
    });
  }

  @override
  Future<void> addIncome(
    String uid,
    String accountId,
    IncomeDto incomeDto,
  ) async {
    final accountRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId);
    final incomeRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('incomes')
        .doc(incomeDto.id);
    final transactionsRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('transactions')
        .doc(incomeDto.id);

    await _firestoreInstance.runTransaction((transaction) async {
      transaction
        ..set(incomeRef, {
          ...incomeDto.toJson(),
          'relatedDoc': transactionsRef.path,
        })
        ..set(transactionsRef, {
          ...incomeDto.toJson(),
          'relatedDoc': incomeRef.path,
        })
        ..update(accountRef, {
          'income': FieldValue.increment(incomeDto.amount),
          'totalBalance': FieldValue.increment(incomeDto.amount),
        });
    });
  }

  @override
  Future<void> deleteExpense(
    String uid,
    String accountId,
    ExpenseDto expenseDto,
  ) async {
    final accountRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId);
    final expenseRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('expenses')
        .doc(expenseDto.id);
    final transactionsRef = _firestoreInstance.doc(expenseDto.relatedDoc);

    print(transactionsRef);

    await _firestoreInstance.runTransaction((transaction) async {
      transaction
        ..update(accountRef, {
          'expenses': FieldValue.increment(-expenseDto.amount),
          'totalBalance': FieldValue.increment(-expenseDto.amount),
        })
        ..delete(expenseRef)
        ..delete(transactionsRef);
    });
  }

  @override
  Future<void> deleteIncome(
    String uid,
    String accountId,
    IncomeDto incomeDto,
  ) async {
    final accountRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId);
    final incomeRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('incomes')
        .doc(incomeDto.id);
    final transactionsRef = _firestoreInstance.doc(incomeDto.relatedDoc);

    print(transactionsRef);

    await _firestoreInstance.runTransaction((transaction) async {
      transaction
        ..update(accountRef, {
          'income': FieldValue.increment(-incomeDto.amount),
          'totalBalance': FieldValue.increment(-incomeDto.amount),
        })
        ..delete(incomeRef)
        ..delete(transactionsRef);
    });
  }
}
