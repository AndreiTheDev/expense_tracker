import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_storage_data_source.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/data/repositories/profile_photos_repository_impl.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/profile_photos_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'profile_photos_repository_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationStorageDataSourceImpl>()])
void main() {
  late MockAuthenticationStorageDataSourceImpl mockStorageDataSource;
  late ProfilePhotosRepository sut;

  setUp(() {
    mockStorageDataSource = MockAuthenticationStorageDataSourceImpl();
    sut = ProfilePhotosRepositoryImpl(storageDataSource: mockStorageDataSource);
  });

  test('Fetch profile photos urls is successful', () async {
    const resultArray = [
      'testurl',
      'testurl2',
      'testurl3',
    ];
    when(mockStorageDataSource.fetchProfilePhotosUrls()).thenAnswer(
      (realInvocation) async => resultArray,
    );

    final response = await sut.fetchProfilePhotosUrls();

    expect(
      response,
      const Right(resultArray),
    );
    verify(mockStorageDataSource.fetchProfilePhotosUrls()).called(1);
    verifyNoMoreInteractions(mockStorageDataSource);
  });

  test('Fetch profile photos urls fails', () async {
    when(mockStorageDataSource.fetchProfilePhotosUrls())
        .thenThrow(Exception('An unknown error occured.'));

    final response = await sut.fetchProfilePhotosUrls();

    expect(
      response,
      const Left(AuthFailure(message: 'An unknown error occured.')),
    );
    verify(mockStorageDataSource.fetchProfilePhotosUrls()).called(1);
    verifyNoMoreInteractions(mockStorageDataSource);
  });

  test('Fetch profile photos urls with FirebaseException', () async {
    when(mockStorageDataSource.fetchProfilePhotosUrls())
        .thenThrow(FirebaseException(plugin: '', message: 'test error'));

    final response = await sut.fetchProfilePhotosUrls();

    expect(
      response,
      const Left(AuthFailure(message: 'test error')),
    );
    verify(mockStorageDataSource.fetchProfilePhotosUrls()).called(1);
    verifyNoMoreInteractions(mockStorageDataSource);
  });
}
