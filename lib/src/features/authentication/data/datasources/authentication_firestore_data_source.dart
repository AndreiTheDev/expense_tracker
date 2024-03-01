import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';
import '../dto/user.dart';
import '../dto/user_signup_details.dart';

abstract interface class AuthenticationFirestoreDataSource {
  Future<void> postUserSignUpDataAndFcm(
    final String uid,
    final UserSignUpDetailsDto userData,
    final String? fcmToken,
  );
  Future<void> postUserFcmToken(final String uid, final String? fcmToken);
  Future<UserDto?> fetchUserData(final String uid);
}

class AuthenticationFirestoreDataSourceImpl
    implements AuthenticationFirestoreDataSource {
  final FirebaseFirestore _firestoreInstance;

  AuthenticationFirestoreDataSourceImpl(this._firestoreInstance);

  @override
  Future<UserDto?> fetchUserData(final String uid) async {
    final response =
        await _firestoreInstance.collection('users').doc(uid).get();
    if (!response.exists) {
      return null;
    }
    final json = response.data();
    if (json != null) {
      return UserDto.fromJson(json);
    } else {
      throw AuthException(
        code: 'user-fetch',
        message: 'Unable to get user data.',
      );
    }
  }

  @override
  Future<void> postUserSignUpDataAndFcm(
    final String uid,
    final UserSignUpDetailsDto userData,
    final String? fcmToken,
  ) async {
    await _firestoreInstance.collection('users').doc(uid).set(
      {
        ...userData.toJson(),
        'fcmToken': fcmToken,
        'uid': uid,
      },
      SetOptions(merge: true),
    );
  }

  @override
  Future<void> postUserFcmToken(
    final String uid,
    final String? fcmToken,
  ) async {
    await _firestoreInstance.collection('users').doc(uid).set(
      {'fcmToken': fcmToken ?? ''},
      SetOptions(merge: true),
    );
  }
}
