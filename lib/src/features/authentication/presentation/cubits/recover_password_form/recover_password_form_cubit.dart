import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../models/email.dart';

part 'recover_password_form_state.dart';

class RecoverPasswordFormCubit extends Cubit<RecoverPasswordFormState> {
  RecoverPasswordFormCubit() : super(const RecoverPasswordFormState());

  void onEmailChanged(final String value) {
    final email = Email.dirty(value: value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email]),
      ),
    );
    print(state);
  }

  bool validateForm() {
    final isFormValid = Formz.validate([state.email]);
    if (!isFormValid) {
      emit(
        state.copyWith(
          email: Email.dirty(value: state.email.value),
          isValid: isFormValid,
        ),
      );
    }
    return isFormValid;
  }
}
