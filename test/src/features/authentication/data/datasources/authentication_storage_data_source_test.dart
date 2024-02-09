import 'dart:io';

import 'package:expense_tracker_app_bloc/src/features/authentication/data/datasources/authentication_storage_data_source.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'authentication_storage_data_source_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<File>(),
])
void main() {
  late MockFile mockFile;
  late MockFirebaseStorage mockFirebaseStorage;
  late AuthenticationStorageDataSourceImpl sut;

  setUp(() {
    mockFile = MockFile();

    mockFirebaseStorage = MockFirebaseStorage();
    sut = AuthenticationStorageDataSourceImpl(mockFirebaseStorage);
  });

  test('Add photo to storage is successfull', () async {
    when(mockFile.path).thenReturn('testPath');
    final response = await sut.addPhotoToStorage(mockFile);

    final location =
        await mockFirebaseStorage.ref('/profile-photos/').getDownloadURL();

    expect(response, location);
  });
}
