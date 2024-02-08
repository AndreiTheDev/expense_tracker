import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserDetailsDto userDetailsDto;

  setUp(() {
    userDetailsDto = const UserDetailsDto(
      email: 'test@email.com',
      fcmToken: 'testFcm',
      completeName: 'testCompleteName',
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

  test('Test props', () {
    userDetailsDto.toString();
  });
}
