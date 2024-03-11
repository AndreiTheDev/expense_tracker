import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_storage_data_source.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_storage_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<FirebaseStorage>(),
  MockSpec<Reference>(),
  MockSpec<ListResult>(),
])
void main() {
  late AuthenticationStorageDataSourceImpl sut;
  late MockFirebaseStorage mockFirebaseStorage;
  late MockReference mockReference;
  late MockListResult mockListResult;

  setUp(() {
    mockFirebaseStorage = MockFirebaseStorage();
    mockReference = MockReference();
    mockListResult = MockListResult();
    sut = AuthenticationStorageDataSourceImpl(mockFirebaseStorage);
  });

  test(
    'fetchProfilePhotosUrls returns a list of photos urls in storage',
    () async {
      final referenceList = [mockReference, mockReference, mockReference];
      when(mockFirebaseStorage.ref()).thenReturn(mockReference);
      when(mockReference.child('profile-photos')).thenReturn(mockReference);
      when(mockReference.listAll())
          .thenAnswer((realInvocation) async => mockListResult);
      when(mockListResult.items).thenReturn(referenceList);
      when(mockReference.getDownloadURL())
          .thenAnswer((realInvocation) async => 'testUrl');

      final response = await sut.fetchProfilePhotosUrls();

      expect(response, ['testUrl', 'testUrl', 'testUrl']);
      verify(mockFirebaseStorage.ref()).called(1);
      verify(mockReference.child('profile-photos')).called(1);
      verify(mockReference.listAll()).called(1);
      verify(mockReference.getDownloadURL()).called(3);
      verify(mockListResult.items).called(1);
      verifyNoMoreInteractions(mockFirebaseStorage);
      verifyNoMoreInteractions(mockReference);
      verifyNoMoreInteractions(mockListResult);
    },
  );
}
