import 'package:expense_tracker_app_bloc/src/features/authentication/data/dto/user_signup_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_signup_details.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late UserSignUpDetailsDto userDetailsDto;
  late UserSignUpDetailsEntity userDetailsEntity;

  setUp(() {
    userDetailsDto = const UserSignUpDetailsDto(
      email: 'test@email.com',
      password: 'testpassword',
      completeName: 'testCompleteName',
      photoUrl: 'test',
    );
    userDetailsEntity = const UserSignUpDetailsEntity(
      email: 'test@email.com',
      password: 'testpassword',
      completeName: 'testCompleteName',
      photoUrl: 'test',
    );
  });

  final json = {
    'email': 'test@email.com',
    'photoUrl': 'test',
    'completeName': 'testCompleteName',
  };

  test('Correct Json object is returned from toJson call', () {
    expect(userDetailsDto.toJson(), json);
  });

  test('UserDetailsDto is created form entity', () {
    expect(UserSignUpDetailsDto.fromEntity(userDetailsEntity), userDetailsDto);
  });

  test('Test props', () {
    userDetailsDto.toString();
  });
}
