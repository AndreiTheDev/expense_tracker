import 'package:firebase_storage/firebase_storage.dart';
import 'package:logger/logger.dart';

import '../../../../core/utils/logger.dart';

abstract interface class AuthenticationStorageDataSource {
  Future<List<String>> fetchProfilePhotosUrls();
}

class AuthenticationStorageDataSourceImpl
    extends AuthenticationStorageDataSource {
  final FirebaseStorage _storageInstance;
  final Logger _logger = getLogger(AuthenticationStorageDataSourceImpl);

  AuthenticationStorageDataSourceImpl(this._storageInstance);

  @override
  Future<List<String>> fetchProfilePhotosUrls() async {
    _logger.d('fetchProfilePhotosUrls - called');
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
