import 'package:expense_tracker_app_bloc/src/core/error/exceptions.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_firestore_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AuthenticationFirestoreDataSourceImpl sut;
  late UserDto userDto;
  late Map<String, dynamic> json;
  late FakeFirebaseFirestore fakeFirestore;

  setUp(() {
    fakeFirestore = FakeFirebaseFirestore();
    userDto = const UserDto(
      uid: 'testUid',
      email: 'test@email.com',
      fcmToken: 'testfcm',
      completeName: 'test test',
      photoUrl: 'testPhoto',
    );
    json = {
      'uid': 'testUid',
      'email': 'test@email.com',
      'fcmToken': 'testfcm',
      'completeName': 'test test',
      'photoUrl': 'testPhoto',
    };
    sut = AuthenticationFirestoreDataSourceImpl(fakeFirestore);
  });

  test('Fetch user data returns UserDto', () async {
    await fakeFirestore.collection('users').doc('testuid').set(json);

    final response = await sut.fetchUserData('testuid');

    expect(response, userDto);
  });

  test('Fetch user data returns null', () async {
    final response = await sut.fetchUserData('testuid');

    expect(response, null);
  });

  test('Fetch user data throws firestore exception', () async {
    await fakeFirestore.collection('users').doc('testuid').set({});

    // final response = await sut.fetchUserData('testuid');

    expect(
      () => sut.fetchUserData('testuid'),
      throwsA(isA<FirestoreException>()),
    );
  });

  test('Post User data is success', () async {
    await sut.postUserData(userDto);

    final userInDb =
        await fakeFirestore.collection('users').doc('testUid').get();
    expect(userInDb.data(), json);
  });

  test('Post User data is success', () async {
    await sut.postUserPhoto('testUid', 'photoUrl');

    final userInDb =
        await fakeFirestore.collection('users').doc('testUid').get();

    expect(userInDb.data()!.containsKey('photoUrl'), true);
    expect(userInDb.data()!.containsValue('photoUrl'), true);
  });
}
