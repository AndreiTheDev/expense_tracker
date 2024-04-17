import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/logger.dart';

abstract interface class SwitchAccountFirestoreDataSource {
  Future<List<Map<String, dynamic>>> fetchAccountsList(final String uid);

  Future<void> createNewAccount(
    final String uid,
    final Map<String, dynamic> json,
  );
}

class SwitchAccountFirestoreDataSourceImpl
    extends SwitchAccountFirestoreDataSource {
  final FirebaseFirestore _firestoreInstance;
  final Logger _logger = getLogger(SwitchAccountFirestoreDataSourceImpl);

  SwitchAccountFirestoreDataSourceImpl(this._firestoreInstance);

  @override
  Future<void> createNewAccount(
    final String uid,
    final Map<String, dynamic> json,
  ) async {
    _logger.d('createNewAccount - called');
    final docRef = _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .doc(json['id']);

    await docRef.set(json);
  }

  @override
  Future<List<Map<String, dynamic>>> fetchAccountsList(final String uid) async {
    _logger.d('fetchAccountsList - called');
    final snapshot = await _firestoreInstance
        .collection('users')
        .doc(uid)
        .collection('accounts')
        .get();

    final accountsJsonsList = snapshot.docs.map((e) => e.data()).toList();

    return accountsJsonsList;
  }
}
