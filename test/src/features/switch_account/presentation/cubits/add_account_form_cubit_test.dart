// ignore_for_file: lines_longer_than_80_chars, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/presentation/cubit/add_account_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/presentation/models/name.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUpFormCubit tests', () {
    late AddAccountFormCubit addAccountFormCubit;
    setUp(() => addAccountFormCubit = AddAccountFormCubit());

    test('Initial state is pure SignUpFormState', () {
      expect(addAccountFormCubit.state, isA<AddAccountFormState>());
      expect(addAccountFormCubit.state, const AddAccountFormState());
      expect(addAccountFormCubit.state.name, const Name.pure());
      expect(addAccountFormCubit.state.isValid, false);
    });

    blocTest(
      'OnNameChanged updates name value with the one passed as argument',
      build: () => addAccountFormCubit,
      act: (bloc) => bloc.onNameChanged('test'),
      expect: () =>
          [const AddAccountFormState(name: Name.dirty(value: 'test'))],
    );

    blocTest(
      'ValidateForm returns true if all fields are valid.',
      build: () => addAccountFormCubit,
      act: (bloc) {
        bloc.onNameChanged('test');
        return bloc.validateForm();
      },
      expect: () => [
        const AddAccountFormState(
          name: Name.dirty(value: 'test'),
        ),
        const AddAccountFormState(
          name: Name.dirty(value: 'test'),
          isValid: true,
        ),
      ],
    );
  });
}
