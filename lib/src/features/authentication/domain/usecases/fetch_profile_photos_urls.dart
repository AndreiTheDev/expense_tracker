// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';
import '../repositories/profile_photos_repository.dart';

class FetchProfilePhotosUrls {
  final ProfilePhotosRepository _repository;

  FetchProfilePhotosUrls(this._repository);

  Future<Either<Failure, List<String>>> call() async {
    return _repository.fetchProfilePhotosUrls();
  }
}
