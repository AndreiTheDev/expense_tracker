import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../models/password.dart';

part 'delete_account_form_state.dart';

class DeleteAccountFormCubit extends Cubit<DeleteAccountFormState> {
  DeleteAccountFormCubit() : super(const DeleteAccountFormState());

  void onPasswordChanged(final String value) {
    final password = Password.dirty(value: value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([password]),
      ),
    );
  }

  bool validateForm() {
    final isFormValid = Formz.validate([state.password]);
    if (!isFormValid) {
      emit(
        state.copyWith(
          password: Password.dirty(value: state.password.value),
          isValid: isFormValid,
        ),
      );
    }
    return isFormValid;
  }
}
