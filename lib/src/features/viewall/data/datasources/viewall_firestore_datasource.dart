import 'package:cloud_firestore/cloud_firestore.dart';

import '../dtos/chart.dart';
import '../dtos/expense.dart';
import '../dtos/income.dart';

abstract interface class ViewallFirestoreDataSource {
  Future<List<ExpenseDto>> fetchExpensesList(
    final String uid,
    final String accountId,
  );

  Future<List<IncomeDto>> fetchIncomesList(
    final String uid,
    final String accountId,
  );

  Future<ChartDto> fetchExpensesChart(
    String uid,
    String accountId,
  );

  Future<ChartDto> fetchIncomesChart(
    String uid,
    String accountId,
  );

  Future<void> deleteIncome(
    final String uid,
    final String accountId,
    final IncomeDto incomeDto,
  );

  Future<void> deleteExpense(
    final String uid,
    final String accountId,
    final ExpenseDto expenseDto,
  );
}

class ViewallFirestoreDataSourceImpl implements ViewallFirestoreDataSource {
  final FirebaseFirestore _firestoreInstance;

  ViewallFirestoreDataSourceImpl(this._firestoreInstance);

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

  @override
  Future<List<ExpenseDto>> fetchExpensesList(
    String uid,
    String accountId,
  ) async {
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('expenses')
        .orderBy('timestamp', descending: true)
        .orderBy('date', descending: true)
        .limit(10)
        .get();
    final List<ExpenseDto> data =
        snapshot.docs.map((doc) => ExpenseDto.fromJson(doc.data())).toList();
    return data;
  }

  @override
  Future<List<IncomeDto>> fetchIncomesList(
    String uid,
    String accountId,
  ) async {
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('incomes')
        .orderBy('timestamp', descending: true)
        .orderBy('date', descending: true)
        .limit(10)
        .get();
    final List<IncomeDto> data =
        snapshot.docs.map((doc) => IncomeDto.fromJson(doc.data())).toList();
    return data;
  }

  @override
  Future<ChartDto> fetchExpensesChart(
    String uid,
    String accountId,
  ) async {
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('expenses_chart')
        .doc('test')
        .get();
    final ChartDto data = ChartDto();
    return data;
  }

  @override
  Future<ChartDto> fetchIncomesChart(
    String uid,
    String accountId,
  ) async {
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('incomes_chart')
        .doc('test')
        .get();
    final ChartDto data = ChartDto();
    return data;
  }
}
