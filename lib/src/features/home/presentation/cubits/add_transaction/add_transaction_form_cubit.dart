import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

import '../../../domain/entities/expense.dart';
import '../../../domain/entities/income.dart';
import '../../models/amount.dart';
import '../../models/category.dart';
import '../../models/date.dart';
import '../../models/description.dart';

part 'add_transaction_form_state.dart';

class AddTransactionFormCubit extends Cubit<AddTransactionFormState> {
  AddTransactionFormCubit() : super(const AddTransactionFormState());

  void onAmountChanged(final String value) {
    final amount = Amount.dirty(value: value);
    emit(
      state.copyWith(
        amount: amount,
      ),
    );
  }

  void onCategoryChanged(final String value) {
    final category = Category.dirty(value: value);
    emit(
      state.copyWith(
        category: category,
      ),
    );
  }

  void onDateChanged(final String value) {
    final date = Date.dirty(value: value);
    emit(state.copyWith(date: date));
  }

  void onDescriptionChanged(final String value) {
    final description = Description.dirty(value: value);
    emit(state.copyWith(description: description));
  }

  bool validateForm() {
    final bool isFormValid = Formz.validate(
      [
        state.amount,
        state.category,
        state.description,
        state.date,
      ],
    );

    emit(
      state.copyWith(
        amount: Amount.dirty(value: state.amount.value),
        category: Category.dirty(value: state.category.value),
        description: Description.dirty(value: state.description.value),
        date: Date.dirty(value: state.date.value),
        isValid: isFormValid,
      ),
    );

    return isFormValid;
  }
}
