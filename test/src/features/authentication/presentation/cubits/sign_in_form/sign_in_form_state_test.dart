import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/sign_in_form/sign_in_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/email.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SignInFormState copyWith returns right data', () {
    const sut = SignInFormState();
    final response = sut.copyWith(
      email: const Email.dirty(value: 'test'),
      password: const Password.dirty(value: 'test'),
      isValid: false,
    );
    expect(
      response,
      const SignInFormState(
        email: Email.dirty(value: 'test'),
        password: Password.dirty(value: 'test'),
      ),
    );
  });

  test('SignInFormState copyWith with null values returns old object', () {
    const sut = SignInFormState();
    final response = sut.copyWith();
    expect(
      response,
      sut,
    );
  });
}
