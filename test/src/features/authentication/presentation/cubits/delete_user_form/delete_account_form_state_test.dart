import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/delete_account_form/delete_account_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('DeleteAccountFormState copyWith returns right data', () {
    const sut = DeleteAccountFormState();
    final response = sut.copyWith(
      password: const Password.dirty(value: 'test'),
      isValid: false,
    );
    expect(
      response,
      const DeleteAccountFormState(
        password: Password.dirty(value: 'test'),
      ),
    );
  });

  test('DeleteAccountFormState copyWith with null values returns old object',
      () {
    const sut = DeleteAccountFormState();
    final response = sut.copyWith();
    expect(
      response,
      sut,
    );
  });
}
