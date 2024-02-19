import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/sign_in_form/sign_in_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/email.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/password.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignInFormCubit tests', () {
    late SignInFormCubit signInFormCubit;
    setUp(() => signInFormCubit = SignInFormCubit());

    test('Initial state is pure SignInFormState', () {
      expect(signInFormCubit.state, isA<SignInFormState>());
      expect(signInFormCubit.state, const SignInFormState());
      expect(signInFormCubit.state.email, const Email.pure());
      expect(signInFormCubit.state.password, const Password.pure());
      expect(signInFormCubit.state.isValid, false);
    });

    blocTest(
      'OnEmailChanged updates email value with the one passed as argument',
      build: () => signInFormCubit,
      act: (bloc) => bloc.onEmailChanged('test'),
      expect: () => [const SignInFormState(email: Email.dirty(value: 'test'))],
    );

    blocTest(
      'OnPasswordChanged updates password value with the one passed as argument',
      build: () => signInFormCubit,
      act: (bloc) => bloc.onPasswordChanged('test'),
      expect: () =>
          [const SignInFormState(password: Password.dirty(value: 'test'))],
    );

    blocTest(
      'ValidateForm returns true if form is valid',
      build: () => signInFormCubit,
      act: (bloc) {
        bloc
          ..onEmailChanged('test@gmail.com')
          ..onPasswordChanged('Testt123!');
        return bloc.validateForm();
      },
      expect: () => [
        const SignInFormState(
          email: Email.dirty(value: 'test@gmail.com'),
        ),
        const SignInFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
          isValid: true,
        ),
      ],
    );

    blocTest(
      'ValidateForm returns false if form is invalid',
      build: () => signInFormCubit,
      act: (bloc) {
        bloc
          ..onEmailChanged('test@gmail')
          ..onPasswordChanged('Testt3!');
        return bloc.validateForm();
      },
      expect: () => [
        const SignInFormState(
          email: Email.dirty(value: 'test@gmail'),
        ),
        const SignInFormState(
          email: Email.dirty(value: 'test@gmail'),
          password: Password.dirty(value: 'Testt3!'),
        ),
      ],
    );
  });
}
