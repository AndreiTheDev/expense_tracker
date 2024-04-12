// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/repositories/profile_photos_repository.dart';
import '../datasources/authentication_storage_data_source.dart';

class ProfilePhotosRepositoryImpl implements ProfilePhotosRepository {
  final AuthenticationStorageDataSource storageDataSource;
  final Logger _logger = getLogger(ProfilePhotosRepositoryImpl);

  ProfilePhotosRepositoryImpl({
    required this.storageDataSource,
  });

  @override
  Future<Either<Failure, List<String>>> fetchProfilePhotosUrls() async {
    _logger.d('fetchProfilePhotosUrls - called');
    try {
      final response = await storageDataSource.fetchProfilePhotosUrls();
      _logger.i('fetchProfilePhotosUrls - success');
      return Right(response);
    } on FirebaseException catch (e) {
      _logger.e('fetchProfilePhotosUrls - FirebaseException: ${e.code}');
      return Left(
        AuthFailure.fromStorageException(e.code),
      );
    } on Exception {
      _logger.e('fetchProfilePhotosUrls - an unknown error occured');
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }
}
