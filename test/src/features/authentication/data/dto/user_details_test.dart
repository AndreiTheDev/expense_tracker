import 'dart:io';

import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';

import 'user_details_test.mocks.dart';

@GenerateNiceMocks([MockSpec<File>()])
void main() {
  late UserDetailsDto userDetailsDto;
  late UserDetailsEntity userDetailsEntity;
  late MockFile mockFile;

  setUp(() {
    mockFile = MockFile();
    userDetailsDto = UserDetailsDto(
      email: 'test@email.com',
      password: 'testpassword',
      fcmToken: 'testFcm',
      completeName: 'testCompleteName',
      photo: mockFile,
    );
    userDetailsEntity = UserDetailsEntity(
      email: 'test@email.com',
      password: 'testpassword',
      fcmToken: 'testFcm',
      completeName: 'testCompleteName',
      photo: mockFile,
    );
  });

  final json = {
    'email': 'test@email.com',
    'fcmToken': 'testFcm',
    'completeName': 'testCompleteName',
  };

  test('Correct Json object is returned from toJson call', () {
    expect(userDetailsDto.toJson(), json);
  });

  test('UserDetailsDto is created form entity', () {
    expect(UserDetailsDto.fromEntity(userDetailsEntity), userDetailsDto);
  });

  test('Test props', () {
    userDetailsDto.toString();
  });
}
