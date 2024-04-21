import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../domain/entities/account.dart';
import '../models/name.dart';

part 'add_account_form_state.dart';

class AddAccountFormCubit extends Cubit<AddAccountFormState> {
  AddAccountFormCubit() : super(const AddAccountFormState());

  void onNameChanged(final String value) {
    final name = Name.dirty(value: value);
    emit(
      state.copyWith(
        name: name,
      ),
    );
  }

  bool validateForm() {
    final bool isFormValid = Formz.validate(
      [state.name],
    );

    emit(
      state.copyWith(
        name: Name.dirty(value: state.name.value),
        isValid: isFormValid,
      ),
    );

    return isFormValid;
  }
}
