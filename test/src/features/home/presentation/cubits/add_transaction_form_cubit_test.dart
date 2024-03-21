// ignore_for_file: lines_longer_than_80_chars, avoid_redundant_argument_values

import 'package:bloc_test/bloc_test.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/cubits/add_transaction/add_transaction_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/models/amount.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/models/category.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/models/date.dart';
import 'package:expense_tracker_app_bloc/src/features/home/presentation/models/description.dart'
    as description;
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SignUpFormCubit tests', () {
    late AddTransactionFormCubit addTransactionFormCubit;
    setUp(() => addTransactionFormCubit = AddTransactionFormCubit());

    test('Initial state is pure SignUpFormState', () {
      expect(addTransactionFormCubit.state, isA<AddTransactionFormState>());
      expect(addTransactionFormCubit.state, const AddTransactionFormState());
      expect(addTransactionFormCubit.state.amount, const Amount.pure());
      expect(addTransactionFormCubit.state.category, const Category.pure());
      expect(
        addTransactionFormCubit.state.description,
        const description.Description.pure(),
      );
      expect(addTransactionFormCubit.state.date, const Date.pure());
      expect(addTransactionFormCubit.state.isValid, false);
    });

    blocTest(
      'OnEmailChanged updates email value with the one passed as argument',
      build: () => addTransactionFormCubit,
      act: (bloc) => bloc.onAmountChanged('test'),
      expect: () =>
          [const AddTransactionFormState(amount: Amount.dirty(value: 'test'))],
    );
    blocTest(
      'OnPhotoUrlChanged updates ProfilePhotoUrl value with the one passed as argument',
      build: () => addTransactionFormCubit,
      act: (bloc) => bloc.onCategoryChanged('test'),
      expect: () => [
        const AddTransactionFormState(category: Category.dirty(value: 'test')),
      ],
    );

    blocTest(
      'OnPasswordChanged updates password value with the one passed as argument',
      build: () => addTransactionFormCubit,
      act: (bloc) => bloc.onDescriptionChanged('test'),
      expect: () => [
        const AddTransactionFormState(
          description: description.Description.dirty(value: 'test'),
        ),
      ],
    );

    blocTest(
      'OnCompleteNameChanged updates ProfilePhotoUrl value with the one passed as argument',
      build: () => addTransactionFormCubit,
      act: (bloc) => bloc.onDateChanged('test'),
      expect: () => [
        const AddTransactionFormState(
          date: Date.dirty(value: 'test'),
        ),
      ],
    );

    blocTest(
      'ValidateForm returns true if all fields are valid.',
      build: () => addTransactionFormCubit,
      act: (bloc) {
        bloc
          ..onAmountChanged('test')
          ..onCategoryChanged('test')
          ..onDescriptionChanged('test')
          ..onDateChanged('test');
        return bloc.validateForm();
      },
      expect: () => [
        const AddTransactionFormState(
          amount: Amount.dirty(value: 'test'),
        ),
        const AddTransactionFormState(
          amount: Amount.dirty(value: 'test'),
          category: Category.dirty(value: 'test'),
        ),
        const AddTransactionFormState(
          amount: Amount.dirty(value: 'test'),
          category: Category.dirty(value: 'test'),
          description: description.Description.dirty(value: 'test'),
        ),
        const AddTransactionFormState(
          amount: Amount.dirty(value: 'test'),
          category: Category.dirty(value: 'test'),
          description: description.Description.dirty(value: 'test'),
          date: Date.dirty(value: 'test'),
        ),
        const AddTransactionFormState(
          amount: Amount.dirty(value: 'test'),
          category: Category.dirty(value: 'test'),
          description: description.Description.dirty(value: 'test'),
          date: Date.dirty(value: 'test'),
          isValid: true,
        ),
      ],
    );
  });
}
