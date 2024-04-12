// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
import '../repositories/profile_photos_repository.dart';

class FetchProfilePhotosUrls {
  final ProfilePhotosRepository _repository;
  final Logger _logger = getLogger(FetchProfilePhotosUrls);

  FetchProfilePhotosUrls(this._repository);

  Future<Either<Failure, List<String>>> call() async {
    _logger.d('call');
    return _repository.fetchProfilePhotosUrls();
  }
}
