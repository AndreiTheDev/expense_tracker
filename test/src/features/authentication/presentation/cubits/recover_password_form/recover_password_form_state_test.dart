import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/recover_password_form/recover_password_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/email.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('RecoverPasswordFormState copyWith returns right data', () {
    const sut = RecoverPasswordFormState();
    final response = sut.copyWith(
      email: const Email.dirty(value: 'test'),
      isValid: false,
    );
    expect(
      response,
      const RecoverPasswordFormState(email: Email.dirty(value: 'test')),
    );
  });

  test('RecoverPasswordFormState copyWith with null values returns old object',
      () {
    const sut = RecoverPasswordFormState();
    final response = sut.copyWith();
    expect(
      response,
      sut,
    );
  });
}
