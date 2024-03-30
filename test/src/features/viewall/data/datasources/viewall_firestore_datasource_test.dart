import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/features/viewall/data/datasources/viewall_firestore_datasource.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'viewall_firestore_datasource_test.mocks.dart';

// TODO(Test): do this tests later
@GenerateNiceMocks([
  MockSpec<FirebaseFirestore>(),
  MockSpec<QuerySnapshot>(),
  MockSpec<QueryDocumentSnapshot>(),
  MockSpec<CollectionReference>(),
  MockSpec<DocumentReference>(),
  MockSpec<Query>(),
])
void main() {
  late ViewallFirestoreDataSource sut;
  late MockFirebaseFirestore mockFirestore;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>>
      mockQueryDocumentSnapshot;
  late List<MockQueryDocumentSnapshot<Map<String, dynamic>>> mockDocumentList;
  setUp(() {
    mockQuerySnapshot = MockQuerySnapshot();
    mockQueryDocumentSnapshot = MockQueryDocumentSnapshot();
    mockDocumentList = [mockQueryDocumentSnapshot, mockQueryDocumentSnapshot];
    mockFirestore = MockFirebaseFirestore();
    sut = ViewallFirestoreDataSourceImpl(mockFirestore);
  });

  test(
    'FetchExpensesList return List containing ExpensesDtos from firestore',
    () async {
      final usersCollectionMock =
          MockCollectionReference<Map<String, dynamic>>();
      final uidDocMock = MockDocumentReference<Map<String, dynamic>>();
      final accountsCollectionMock =
          MockCollectionReference<Map<String, dynamic>>();
      final accountIdDocMock = MockDocumentReference<Map<String, dynamic>>();
      final expensesCollectionMock =
          MockCollectionReference<Map<String, dynamic>>();
      final timestampQuery = MockQuery<Map<String, dynamic>>();
      final dateQuery = MockQuery<Map<String, dynamic>>();
      final limitQuery = MockQuery<Map<String, dynamic>>();
      when(mockFirestore.collection('users')).thenReturn(
        usersCollectionMock,
      );
      when(usersCollectionMock.doc('uid')).thenReturn(uidDocMock);
      when(uidDocMock.collection('accounts'))
          .thenReturn(accountsCollectionMock);
      when(
        accountsCollectionMock.doc('accountId'),
      ).thenReturn(accountIdDocMock);
      when(
        accountIdDocMock.collection('expenses'),
      ).thenReturn(expensesCollectionMock);
      when(
        expensesCollectionMock.orderBy('timestamp', descending: true),
      ).thenReturn(timestampQuery);
      when(
        timestampQuery.orderBy('date', descending: true),
      ).thenReturn(dateQuery);
      when(
        dateQuery.limit(10),
      ).thenReturn(limitQuery);
      when(
        limitQuery.get(),
      ).thenAnswer((realInvocation) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn(
        mockDocumentList,
      );
      // when(mockDocumentList.map((doc) => ))

      final response = await sut.fetchExpensesList('uid', 'accountId');
      print(response);
    },
  );
}
