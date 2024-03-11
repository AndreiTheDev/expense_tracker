import 'package:firebase_storage/firebase_storage.dart';

abstract interface class AuthenticationStorageDataSource {
  Future<List<String>> fetchProfilePhotosUrls();
}

class AuthenticationStorageDataSourceImpl
    extends AuthenticationStorageDataSource {
  final FirebaseStorage _storageInstance;

  AuthenticationStorageDataSourceImpl(this._storageInstance);

  @override
  Future<List<String>> fetchProfilePhotosUrls() async {
    final List<String> photosUrls = [];
    final refrenceList =
        await _storageInstance.ref().child('profile-photos').listAll();
    for (final Reference file in refrenceList.items) {
      final url = await file.getDownloadURL();
      photosUrls.add(url);
    }
    return photosUrls;
  }
}
