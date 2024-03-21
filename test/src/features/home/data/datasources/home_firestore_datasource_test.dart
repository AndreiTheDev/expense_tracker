import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/features/home/data/datasources/home_firestore_datasource.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

//as many of the needed functions do not work for the fake
//I will not test this class for the moment.

void main() {
  late HomeFirestoreDataSource sut;
  late FakeFirebaseFirestore fakeFirestore;
  const accountJson = {
    'id': 'id',
    'name': 'name',
    'income': 100,
    'expenses': 100,
    'totalBalance': 0,
    'transactions': [],
  };

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    sut = HomeFirestoreDataSourceImpl(fakeFirestore);
  });

  test('Fetch account details returns the account details', () async {
    await fakeFirestore
        .collection('users')
        .doc('test')
        .collection('accounts')
        .doc('test')
        .set(
          accountJson,
        );

    final response = await sut.fetchAccountDetails('test', 'test');

    expect(response, accountJson);
  });

  test('Fetch account details throws exception', () async {
    await expectLater(
      sut.fetchAccountDetails('test', 'test'),
      throwsA(isA<Exception>()),
    );
  });

  test('Fetch account transactions returns list with account transactions',
      () async {
    final transactionJson = {
      'id': 'test',
      'category': 'test',
      'description': 'test',
      'amount': 100,
      'date': Timestamp(0, 0),
      'relatedDoc': 'test',
    };
    await fakeFirestore
        .collection('users')
        .doc('test')
        .collection('accounts')
        .doc('test')
        .collection('transactions')
        .add(transactionJson);

    final response = await sut.fetchAccountTransactions('test', 'test');

    expect(response, [transactionJson]);
  });

  //transactions are not working for the fakes so I'm unable
  //to test this function since it will be very time consuming
  // test('Add Expense adds expense to the database', () async {
  //   await sut.addExpense(
  //     'test',
  //     'test',
  //     ExpenseDto(
  //       category: 'test',
  //       description: 'test',
  //       amount: 100,
  //       date: DateTime(1999),
  //       id: 'test',
  //       relatedDoc: 'test',
  //     ),
  //   );

  //   final response = await fakeFirestore
  //       .collection('users')
  //       .doc('test')
  //       .collection('accounts')
  //       .doc('test')
  //       .collection('expenses')
  //       .doc('test')
  //       .get();

  //   expect(response.exists, true);
  // });
}
