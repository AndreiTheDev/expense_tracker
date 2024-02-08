import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserDto user;

  setUp(() {
    user = const UserDto(
      uid: 'testUid',
      email: 'test@email.com',
      fcmToken: 'testFcm',
      completeName: 'testCompleteName',
      photoUrl: 'testPhoto',
    );
  });

  final json = {
    'uid': 'testUid',
    'email': 'test@email.com',
    'fcmToken': 'testFcm',
    'completeName': 'testCompleteName',
    'photoUrl': 'testPhoto',
  };

  test('User is created from Json', () {
    final sut = UserDto.fromJson(json);
    expect(sut, user);
  });

  test('Correct Json object is returned from toJson call', () {
    expect(user.toJson(), json);
  });
}
