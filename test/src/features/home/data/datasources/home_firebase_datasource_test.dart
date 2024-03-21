import 'package:expense_tracker_app_bloc/src/features/home/data/datasources/home_firebase_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_firebase_datasource_test.mocks.dart';

@GenerateNiceMocks(<MockSpec>[
  MockSpec<FirebaseAuth>(),
  MockSpec<User>(),
])
void main() {
  late HomeFirebaseDataScource sut;
  late MockFirebaseAuth mockFirebase;
  late MockUser mockUser;

  setUp(() {
    mockFirebase = MockFirebaseAuth();
    mockUser = MockUser();
    sut = HomeFirebaseDataSourceImpl(mockFirebase);
  });

  test('GetUid returs user uid', () {
    when(mockFirebase.currentUser).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testUid');
    final response = sut.getUid();
    expect(response, 'testUid');
    verify(mockFirebase.currentUser).called(1);
    verify(mockUser.uid).called(1);
    verifyNoMoreInteractions(mockFirebase);
    verifyNoMoreInteractions(mockUser);
  });

  test('GetUid returs null', () {
    when(mockFirebase.currentUser).thenReturn(null);
    final response = sut.getUid();
    expect(response, null);
    verify(mockFirebase.currentUser).called(1);
    verifyNoMoreInteractions(mockFirebase);
  });
}
