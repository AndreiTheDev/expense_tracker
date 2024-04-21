import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';

abstract interface class SwitchAccountFirebaseDataSource {
  User getUser();
}

class SwitchAccountFirebaseDataSourceImpl
    implements SwitchAccountFirebaseDataSource {
  final FirebaseAuth _firebaseInstance;
  final Logger _logger = getLogger(SwitchAccountFirebaseDataSourceImpl);

  SwitchAccountFirebaseDataSourceImpl(this._firebaseInstance);

  @override
  User getUser() {
    _logger.d('getUser - called');
    final user = _firebaseInstance.currentUser;
    if (user != null) {
      return user;
    }
    throw const SwitchAccountFailure(
        message: 'User is not authenticated, unable to execute the operation.');
  }
}
