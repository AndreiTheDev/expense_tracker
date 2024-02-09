import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract interface class AuthenticationStorageDataSource {
  Future<String> addPhotoToStorage(
    final File photo,
  );
}

class AuthenticationStorageDataSourceImpl
    extends AuthenticationStorageDataSource {
  // final FirebaseSt _storageInstance;
  final FirebaseStorage _storageInstance;

  AuthenticationStorageDataSourceImpl(this._storageInstance);

  @override
  Future<String> addPhotoToStorage(
    final File photo,
  ) async {
    final Reference reference = _storageInstance.ref().child('profile-photos/');
    final uploadTask = reference.putFile(photo);
    final taskSnapshot = await uploadTask;
    final photoUrl = await taskSnapshot.ref.getDownloadURL();
    return photoUrl;
  }
}
