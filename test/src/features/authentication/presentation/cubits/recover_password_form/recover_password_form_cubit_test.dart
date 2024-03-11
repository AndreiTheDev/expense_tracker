import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/recover_password_form/recover_password_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/email.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RecoverPasswordFormCubit tests', () {
    late RecoverPasswordFormCubit recoverPasswordFormCubit;
    setUp(() => recoverPasswordFormCubit = RecoverPasswordFormCubit());

    test('Initial state is pure RecoverPasswordFormState', () {
      expect(recoverPasswordFormCubit.state, isA<RecoverPasswordFormState>());
      expect(recoverPasswordFormCubit.state, const RecoverPasswordFormState());
      expect(recoverPasswordFormCubit.state.email, const Email.pure());
      expect(recoverPasswordFormCubit.state.isValid, false);
    });

    blocTest(
      'OnEmailChanged updates email value with the one passed as argument',
      build: () => recoverPasswordFormCubit,
      act: (bloc) => bloc.onEmailChanged('test'),
      expect: () => [
        const RecoverPasswordFormState(email: Email.dirty(value: 'test')),
      ],
    );

    blocTest(
      'ValidateForm returns true if form is valid',
      build: () => recoverPasswordFormCubit,
      act: (bloc) {
        bloc.onEmailChanged('test@gmail.com');
        return bloc.validateForm();
      },
      expect: () => [
        const RecoverPasswordFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          isValid: true,
        ),
      ],
    );

    blocTest(
      'ValidateForm returns false if form is invalid',
      build: () => recoverPasswordFormCubit,
      act: (bloc) {
        bloc.onEmailChanged('test@gmail');
        return bloc.validateForm();
      },
      expect: () => [
        const RecoverPasswordFormState(
          email: Email.dirty(value: 'test@gmail'),
        ),
      ],
    );
  });
}
