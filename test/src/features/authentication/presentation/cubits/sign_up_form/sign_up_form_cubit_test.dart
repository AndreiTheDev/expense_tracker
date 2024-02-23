// ignore_for_file: lines_longer_than_80_chars, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/sign_up_form/sign_up_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/complete_name.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/email.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/password.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/profile_photo_url.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUpFormCubit tests', () {
    late SignUpFormCubit signUpFormCubit;
    setUp(() => signUpFormCubit = SignUpFormCubit());

    test('Initial state is pure SignUpFormState', () {
      expect(signUpFormCubit.state, isA<SignUpFormState>());
      expect(signUpFormCubit.state, const SignUpFormState());
      expect(signUpFormCubit.state.email, const Email.pure());
      expect(signUpFormCubit.state.password, const Password.pure());
      expect(signUpFormCubit.state.isValidFirstStep, false);
      expect(signUpFormCubit.state.photoUrl, const ProfilePhotoUrl.pure());
      expect(signUpFormCubit.state.completeName, const CompleteName.pure());
      expect(signUpFormCubit.state.isValid, false);
    });

    test('Initial state is pure SignUpFormState', () {
      expect(signUpFormCubit.state, isA<SignUpFormState>());
      expect(signUpFormCubit.state, const SignUpFormState());
      expect(signUpFormCubit.state.email, const Email.pure());
      expect(signUpFormCubit.state.password, const Password.pure());
      expect(signUpFormCubit.state.isValidFirstStep, false);
      expect(signUpFormCubit.state.photoUrl, const ProfilePhotoUrl.pure());
      expect(signUpFormCubit.state.completeName, const CompleteName.pure());
      expect(signUpFormCubit.state.isValid, false);
    });

    blocTest(
      'OnEmailChanged updates email value with the one passed as argument',
      build: () => signUpFormCubit,
      act: (bloc) => bloc.onEmailChanged('test'),
      expect: () => [const SignUpFormState(email: Email.dirty(value: 'test'))],
    );

    blocTest(
      'OnPasswordChanged updates password value with the one passed as argument',
      build: () => signUpFormCubit,
      act: (bloc) => bloc.onPasswordChanged('test'),
      expect: () =>
          [const SignUpFormState(password: Password.dirty(value: 'test'))],
    );

    blocTest(
      'ValidateFirstStep returns true if email and password are valid',
      build: () => signUpFormCubit,
      act: (bloc) {
        bloc
          ..onEmailChanged('test@gmail.com')
          ..onPasswordChanged('Testt123!');
        return bloc.validateFirstStep();
      },
      expect: () => [
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
          isValidFirstStep: true,
        ),
      ],
    );

    blocTest(
      'ValidateFirstStep returns false if email and password are invalid',
      build: () => signUpFormCubit,
      act: (bloc) {
        bloc
          ..onEmailChanged('test@gmail')
          ..onPasswordChanged('Test123');
        return bloc.validateFirstStep();
      },
      expect: () => [
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail'),
          password: Password.dirty(value: 'Test123'),
        ),
      ],
    );

    blocTest(
      'GoToFirstStep goes back to the first step of the form',
      build: () => signUpFormCubit,
      act: (bloc) {
        bloc
          ..onEmailChanged('test@gmail.com')
          ..onPasswordChanged('Testt123!')
          ..validateFirstStep();
        return bloc.goToFirstStep();
      },
      expect: () => [
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
          isValidFirstStep: true,
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
          isValidFirstStep: false,
        ),
      ],
    );

    blocTest(
      'OnPhotoUrlChanged updates ProfilePhotoUrl value with the one passed as argument',
      build: () => signUpFormCubit,
      act: (bloc) => bloc.onPhotoUrlChanged('test'),
      expect: () => [
        const SignUpFormState(photoUrl: ProfilePhotoUrl.dirty(value: 'test')),
      ],
    );

    blocTest(
      'OnCompleteNameChanged updates ProfilePhotoUrl value with the one passed as argument',
      build: () => signUpFormCubit,
      act: (bloc) => bloc.onCompleteNameChanged('test test'),
      expect: () => [
        const SignUpFormState(
          completeName: CompleteName.dirty(value: 'test test'),
        ),
      ],
    );

    blocTest(
      'ValidateForm returns true if all fields are valid.',
      build: () => signUpFormCubit,
      act: (bloc) {
        bloc
          ..onEmailChanged('test@gmail.com')
          ..onPasswordChanged('Testt123!')
          ..onPhotoUrlChanged('testphoto')
          ..onCompleteNameChanged('test test');
        return bloc.validateForm();
      },
      expect: () => [
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
          photoUrl: ProfilePhotoUrl.dirty(value: 'testphoto'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
          photoUrl: ProfilePhotoUrl.dirty(value: 'testphoto'),
          completeName: CompleteName.dirty(value: 'test test'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail.com'),
          password: Password.dirty(value: 'Testt123!'),
          photoUrl: ProfilePhotoUrl.dirty(value: 'testphoto'),
          completeName: CompleteName.dirty(value: 'test test'),
          isValid: true,
        ),
      ],
    );

    blocTest(
      'ValidateForm returns false if fields are invalid.',
      build: () => signUpFormCubit,
      act: (bloc) {
        bloc
          ..onEmailChanged('test@gmail')
          ..onPasswordChanged('Test123')
          ..onCompleteNameChanged('tes');
        return bloc.validateForm();
      },
      expect: () => [
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail'),
          password: Password.dirty(value: 'Test123'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail'),
          password: Password.dirty(value: 'Test123'),
          completeName: CompleteName.dirty(value: 'tes'),
        ),
        const SignUpFormState(
          email: Email.dirty(value: 'test@gmail'),
          password: Password.dirty(value: 'Test123'),
          photoUrl: ProfilePhotoUrl.dirty(),
          completeName: CompleteName.dirty(value: 'tes'),
          isValid: false,
        ),
      ],
    );
  });
}
