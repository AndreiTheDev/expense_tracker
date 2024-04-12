import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/logger.dart';

// ignore: one_member_abstracts
abstract interface class HomeFirebaseDataScource {
  String? getUid();
}

class HomeFirebaseDataSourceImpl implements HomeFirebaseDataScource {
  final FirebaseAuth _firebaseInstance;
  final Logger _logger = getLogger(HomeFirebaseDataSourceImpl);

  HomeFirebaseDataSourceImpl(this._firebaseInstance);

  @override
  String? getUid() {
    _logger.d('getUid - called');
    return _firebaseInstance.currentUser?.uid;
  }
}
