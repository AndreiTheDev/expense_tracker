import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/logger.dart';

abstract interface class ViewallFirebaseDataSource {
  String? getUid();
}

class ViewallFirebaseDataSourceImpl implements ViewallFirebaseDataSource {
  final FirebaseAuth _firebaseInstance;
  final Logger _logger = getLogger(ViewallFirebaseDataSourceImpl);

  ViewallFirebaseDataSourceImpl(this._firebaseInstance);

  @override
  String? getUid() {
    _logger.d('getUid - called');
    return _firebaseInstance.currentUser?.uid;
  }
}
