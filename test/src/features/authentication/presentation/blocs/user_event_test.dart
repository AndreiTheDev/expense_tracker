import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_signup_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('UserStarted props are equal', () {
    final sut = UserStarted();

    expect(sut.props, []);
  });

  test('UserSignInEvent props are equal', () {
    const sut = UserSignInEvent(email: 'test', password: 'test');

    expect(sut.props, ['test', 'test']);
  });

  test('UserSignUpEvent props are equal', () {
    const userDetailsEntity = UserSignUpDetailsEntity(
      email: 'test',
      password: 'test',
      completeName: 'test',
      photoUrl: 'test',
    );
    const sut = UserSignUpEvent(
      userDetailsEntity: userDetailsEntity,
    );

    expect(sut.props, [userDetailsEntity]);
  });

  test('UserSignOutEvent props are equal', () {
    final sut = UserSignOutEvent();

    expect(sut.props, []);
  });

  test('UserRecoverPasswordEvent props are equal', () {
    const sut = UserRecoverPasswordEvent(email: 'test');

    expect(sut.props, ['test']);
  });

  test('UserDeleteUserEvent props are equal', () {
    final sut = UserDeleteUserEvent();

    expect(sut.props, []);
  });

  test('UserErrorEvent props are equal', () {
    const sut = UserErrorEvent(message: 'test');

    expect(sut.props, ['test']);
  });
}
