import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/delete_account_form/delete_account_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignInFormCubit tests', () {
    late DeleteAccountFormCubit deleteAccountFormCubit;
    setUp(() => deleteAccountFormCubit = DeleteAccountFormCubit());

    test('Initial state is pure DeleteAccountFormState', () {
      expect(deleteAccountFormCubit.state, isA<DeleteAccountFormState>());
      expect(deleteAccountFormCubit.state, const DeleteAccountFormState());
      expect(deleteAccountFormCubit.state.password, const Password.pure());
      expect(deleteAccountFormCubit.state.isValid, false);
    });

    blocTest(
      'OnPasswordChanged updates password value with the one passed as argument',
      build: () => deleteAccountFormCubit,
      act: (bloc) => bloc.onPasswordChanged('test'),
      expect: () => [
        const DeleteAccountFormState(password: Password.dirty(value: 'test')),
      ],
    );

    blocTest(
      'ValidateForm returns true if form is valid',
      build: () => deleteAccountFormCubit,
      act: (bloc) {
        bloc.onPasswordChanged('Testt123!');
        return bloc.validateForm();
      },
      expect: () => [
        const DeleteAccountFormState(
          password: Password.dirty(value: 'Testt123!'),
          isValid: true,
        ),
      ],
    );

    blocTest(
      'ValidateForm returns false if form is invalid',
      build: () => deleteAccountFormCubit,
      act: (bloc) {
        bloc.onPasswordChanged('Testt3!');
        return bloc.validateForm();
      },
      expect: () => [
        const DeleteAccountFormState(
          password: Password.dirty(value: 'Testt3!'),
        ),
      ],
    );
  });
}
