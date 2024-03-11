import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../models/email.dart';
import '../../models/password.dart';

part 'sign_in_form_state.dart';

class SignInFormCubit extends Cubit<SignInFormState> {
  SignInFormCubit() : super(const SignInFormState());

  void onEmailChanged(final String value) {
    final email = Email.dirty(value: value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([email, state.password]),
      ),
    );
  }

  void onPasswordChanged(final String value) {
    final password = Password.dirty(value: value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([state.email, password]),
      ),
    );
  }

  bool validateForm() {
    final isFormValid = Formz.validate([state.email, state.password]);
    if (!isFormValid) {
      emit(
        state.copyWith(
          email: Email.dirty(value: state.email.value),
          password: Password.dirty(value: state.password.value),
          isValid: isFormValid,
        ),
      );
    }
    return isFormValid;
  }
}
