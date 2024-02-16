import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

abstract interface class AuthenticationStorageDataSource {
  Future<String> addPhotoToStorage(
    final File photo,
  );
  Future<List<String>> fetchProfilePhotosUrls();
}

class AuthenticationStorageDataSourceImpl
    extends AuthenticationStorageDataSource {
  // final FirebaseSt _storageInstance;
  final FirebaseStorage _storageInstance;

  AuthenticationStorageDataSourceImpl(this._storageInstance);

  //not to be used for the moment,
  //we will let users only pick from our profile pics
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

  @override
  Future<List<String>> fetchProfilePhotosUrls() async {
    final List<String> photosUrls = [];
    final refrenceList =
        await FirebaseStorage.instance.ref().child('profile-photos').listAll();
    for (final Reference file in refrenceList.items) {
      final url = await file.getDownloadURL();
      photosUrls.add(url);
    }
    return photosUrls;
  }
}
