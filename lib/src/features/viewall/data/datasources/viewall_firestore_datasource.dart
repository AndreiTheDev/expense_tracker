import 'package:cloud_firestore/cloud_firestore.dart';

import '../dtos/chart.dart';
import '../dtos/expense.dart';
import '../dtos/income.dart';
import '../dtos/monthly_chart_data.dart';

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
    final currentDate = DateTime.now();
    final startingDate = currentDate
        .subtract(Duration(days: 150 + currentDate.day - 1, hours: -1));
    final endOfCurrentMonth =
        currentDate.add(Duration(days: 30 - currentDate.day));
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('expenses_chart')
        .orderBy('filterDate', descending: false)
        .where('filterDate', isGreaterThanOrEqualTo: startingDate)
        .where('filterDate', isLessThanOrEqualTo: endOfCurrentMonth)
        .limit(6)
        .get();
    final monthlyChartDataList =
        _generateMonthlyChartDataDtosList(snapshot.docs);
    final ChartDto chartDto =
        _generateChartDto(startingDate, monthlyChartDataList);
    return chartDto;
  }

  @override
  Future<ChartDto> fetchIncomesChart(
    String uid,
    String accountId,
  ) async {
    final currentDate = DateTime.now();
    final startingDate = currentDate
        .subtract(Duration(days: 150 + currentDate.day - 1, hours: -1));
    final endOfCurrentMonth =
        currentDate.add(Duration(days: 30 - currentDate.day));
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(accountId)
        .collection('incomes_chart')
        .orderBy('filterDate', descending: false)
        .where('filterDate', isGreaterThanOrEqualTo: startingDate)
        .where('filterDate', isLessThanOrEqualTo: endOfCurrentMonth)
        .limit(6)
        .get();
    final monthlyChartDataList =
        _generateMonthlyChartDataDtosList(snapshot.docs);
    final ChartDto chartDto =
        _generateChartDto(startingDate, monthlyChartDataList);
    return chartDto;
  }

  ChartDto _generateChartDto(
    final DateTime startingDate,
    final List<MonthlyChartDataDto> monthlyChartDataList,
  ) {
    double maxMonthBalance = 0;
    final monthlyList = List<MonthlyChartDataDto>.generate(6, (index) {
      final dateToBeAdded = startingDate.add(Duration(days: 31 * index));
      MonthlyChartDataDto? monthlyChartDataToBeAdded;
      for (final monthlyChartDataDto in monthlyChartDataList) {
        if (dateToBeAdded.month == monthlyChartDataDto.date.month) {
          if (monthlyChartDataDto.balance > maxMonthBalance) {
            maxMonthBalance = monthlyChartDataDto.balance;
          }
          monthlyChartDataToBeAdded = monthlyChartDataDto;
        }
      }
      return monthlyChartDataToBeAdded ??
          MonthlyChartDataDto(balance: 0, date: dateToBeAdded);
    });
    return ChartDto(
      monthlyList: monthlyList,
      maxMonthThreshold: _calculateMaxMonthThreshold(maxMonthBalance),
    );
  }

  List<MonthlyChartDataDto> _generateMonthlyChartDataDtosList(
    final List<QueryDocumentSnapshot<Map<String, dynamic>>> docList,
  ) {
    final monthlyChartDatalist = <MonthlyChartDataDto>[];
    for (final doc in docList) {
      monthlyChartDatalist.add(MonthlyChartDataDto.fromJson(doc.data()));
    }
    return monthlyChartDatalist;
  }

  double _calculateMaxMonthThreshold(final double maxMonthBalance) {
    int digits = 0;
    double copyMaxMonthBalance = maxMonthBalance;
    while (copyMaxMonthBalance > 10) {
      copyMaxMonthBalance = copyMaxMonthBalance / 10;
      digits++;
    }
    //deleting all the digits after the floating point and adding 1
    //so the treshold is the next biggest number after the maxmonthbalance
    //eg: 3245 => 4000
    copyMaxMonthBalance = copyMaxMonthBalance.floorToDouble() + 1;
    while (digits > 0) {
      copyMaxMonthBalance = copyMaxMonthBalance * 10;
      digits--;
    }
    return copyMaxMonthBalance;
  }
}
