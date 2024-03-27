import 'package:firebase_auth/firebase_auth.dart';

abstract interface class ViewallFirebaseDataSource {
  String? getUid();
}

class ViewallFirebaseDataSourceImpl implements ViewallFirebaseDataSource {
  final FirebaseAuth _firebaseInstance;

  ViewallFirebaseDataSourceImpl(this._firebaseInstance);

  @override
  String? getUid() {
    return _firebaseInstance.currentUser?.uid;
  }
}
