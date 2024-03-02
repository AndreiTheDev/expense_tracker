// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/profile_photos_repository.dart';
import '../datasources/authentication_storage_data_source.dart';

class ProfilePhotosRepositoryImpl implements ProfilePhotosRepository {
  final AuthenticationStorageDataSource storageDataSource;

  ProfilePhotosRepositoryImpl({
    required this.storageDataSource,
  });

  @override
  Future<Either<Failure, List<String>>> fetchProfilePhotosUrls() async {
    try {
      final response = await storageDataSource.fetchProfilePhotosUrls();
      return Right(response);
    } on FirebaseException catch (e) {
      return Left(
        AuthFailure.fromStorageException(e.code),
      );
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }
}
