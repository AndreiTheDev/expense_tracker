import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/error/exceptions.dart';
import '../dto/user.dart';
import '../dto/user_details.dart';

abstract interface class AuthenticationFirestoreDataSource {
  Future<void> postUserData(final UserDto userData);
  Future<void> postUserDetails(
      final String uid, final UserDetailsDto userDetails);
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
      throw FirestoreException(
        code: 'user-fetch',
        message: 'Unable to get user data.',
      );
    }
  }

  @override
  Future<void> postUserData(final UserDto userData) async {
    await _firestoreInstance
        .collection('users')
        .doc(userData.uid)
        .set(userData.toJson(), SetOptions(merge: true));
  }

  @override
  Future<void> postUserDetails(
    final String uid,
    final UserDetailsDto userDetails,
  ) async {
    await _firestoreInstance
        .collection('users')
        .doc(uid)
        .set(userDetails.toJson(), SetOptions(merge: true));
  }
}
