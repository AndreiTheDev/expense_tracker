import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/fetch_profile_photos_urls.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/profile_photos_urls/profile_photos_urls_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_photos_urls_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<FetchProfilePhotosUrls>()])
void main() {
  group('ProfilePhotosUrlsCubit tests', () {
    late ProfilePhotosUrlsCubit profilePhotosUrlsCubit;
    late MockFetchProfilePhotosUrls mockFetchProfilePhotosUrls;

    setUp(() {
      mockFetchProfilePhotosUrls = MockFetchProfilePhotosUrls();
      profilePhotosUrlsCubit = ProfilePhotosUrlsCubit(
        profilePhotosUrls: mockFetchProfilePhotosUrls,
      );
    });

    test('Intial state is ProfilePhotosUrlsInitial', () {
      expect(profilePhotosUrlsCubit.state, ProfilePhotosUrlsInitial());
    });

    blocTest(
      'Fetch list of profile photos urls return ProfilePhotosUrlsLoaded',
      build: () => profilePhotosUrlsCubit,
      setUp: () async {
        provideDummy<Either<Failure, List<String>>>(
          const Right(['test', 'test2']),
        );
        when(mockFetchProfilePhotosUrls.call()).thenAnswer(
          (realInvocation) async => const Right(['test', 'test2']),
        );
      },
      act: (bloc) async => bloc.fetchProfilePhotosUrls(),
      expect: () => [
        ProfilePhotosUrlsLoading(),
        const ProfilePhotosUrlsLoaded(urls: ['test', 'test2']),
      ],
    );

    blocTest(
      'Fetch list of profile photos urls return ProfilePhotosUrlsError',
      build: () => profilePhotosUrlsCubit,
      setUp: () async {
        provideDummy<Either<Failure, List<String>>>(
          const Left(AuthFailure(message: 'An unknown error occured.')),
        );
        when(mockFetchProfilePhotosUrls.call()).thenAnswer(
          (realInvocation) async =>
              const Left(AuthFailure(message: 'An unknown error occured.')),
        );
      },
      act: (bloc) async => bloc.fetchProfilePhotosUrls(),
      expect: () => [
        ProfilePhotosUrlsLoading(),
        const ProfilePhotosUrlsError(message: 'An unknown error occured.'),
      ],
    );
  });
}
