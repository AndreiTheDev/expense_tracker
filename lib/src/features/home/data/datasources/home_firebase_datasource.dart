import 'package:firebase_auth/firebase_auth.dart';

// ignore: one_member_abstracts
abstract interface class HomeFirebaseDataScource {
  String? getUid();
}

class HomeFirebaseDataSourceImpl implements HomeFirebaseDataScource {
  final FirebaseAuth _firebaseInstance;

  HomeFirebaseDataSourceImpl(this._firebaseInstance);

  @override
  String? getUid() {
    return _firebaseInstance.currentUser?.uid;
  }
}
