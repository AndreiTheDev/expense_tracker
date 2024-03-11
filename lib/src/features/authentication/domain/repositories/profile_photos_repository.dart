// ignore_for_file: one_member_abstracts

import 'package:fpdart/fpdart.dart';

import '../../../../core/error/failures.dart';

abstract interface class ProfilePhotosRepository {
  Future<Either<Failure, List<String>>> fetchProfilePhotosUrls();
}
