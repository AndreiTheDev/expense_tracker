import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/profile_photos_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/fetch_profile_photos_urls.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'fetch_profile_photos_urls_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ProfilePhotosRepository>()])
void main() {
  late FetchProfilePhotosUrls sut;
  late MockProfilePhotosRepository mockProfilePhotosRepository;

  setUp(() {
    mockProfilePhotosRepository = MockProfilePhotosRepository();
    sut = FetchProfilePhotosUrls(mockProfilePhotosRepository);
  });

  test('Fetches the profile pictures urls from storage is successful',
      () async {
    provideDummy<Either<Failure, List<String>>>(
      const Right(['testurl', 'testurl2', 'testurl3']),
    );
    when(mockProfilePhotosRepository.fetchProfilePhotosUrls()).thenAnswer(
      (realInvocation) async =>
          const Right(['testurl', 'testurl2', 'testurl3']),
    );

    final result = await sut();

    expect(result, const Right(['testurl', 'testurl2', 'testurl3']));
    verify(mockProfilePhotosRepository.fetchProfilePhotosUrls()).called(1);
    verifyNoMoreInteractions(mockProfilePhotosRepository);
  });

  test('Fetches the profile pictures urls from storage fails', () async {
    provideDummy<Either<Failure, List<String>>>(
      const Left(AuthFailure(message: 'test')),
    );
    when(
      mockProfilePhotosRepository.fetchProfilePhotosUrls(),
    ).thenAnswer(
      (realInvocation) async => const Left(AuthFailure(message: 'test')),
    );

    final result = await sut();

    expect(result, const Left(AuthFailure(message: 'test')));
    verify(mockProfilePhotosRepository.fetchProfilePhotosUrls()).called(1);
    verifyNoMoreInteractions(mockProfilePhotosRepository);
  });
}
