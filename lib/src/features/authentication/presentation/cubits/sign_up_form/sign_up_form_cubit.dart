import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../models/complete_name.dart';
import '../../models/email.dart';
import '../../models/password.dart';
import '../../models/profile_photo_url.dart';

part 'sign_up_form_state.dart';

class SignUpFormCubit extends Cubit<SignUpFormState> {
  SignUpFormCubit() : super(const SignUpFormState());

  void onEmailChanged(final String value) {
    final email = Email.dirty(value: value);
    emit(
      state.copyWith(
        email: email,
      ),
    );
  }

  void onPasswordChanged(final String value) {
    final password = Password.dirty(value: value);
    emit(
      state.copyWith(
        password: password,
      ),
    );
  }

  void validateFirstStep() {
    final isValidFirstStep = Formz.validate([state.email, state.password]);
    emit(
      state.copyWith(
        email: Email.dirty(value: state.email.value),
        password: Password.dirty(value: state.password.value),
        isValidFirstStep: isValidFirstStep,
      ),
    );
  }

  //makes ui go back to first step by invalidating it
  void goToFirstStep() {
    emit(state.copyWith(isValidFirstStep: false));
  }

  void onPhotoUrlChanged(final String value) {
    final photoUrl = ProfilePhotoUrl.dirty(value: value);
    emit(state.copyWith(photoUrl: photoUrl));
  }

  void onCompleteNameChanged(final String value) {
    final completeName = CompleteName.dirty(value: value);
    emit(state.copyWith(completeName: completeName));
  }

  bool validateForm() {
    final bool isFormValid = Formz.validate(
      [
        state.email,
        state.password,
        state.completeName,
        state.photoUrl,
      ],
    );

    emit(
      state.copyWith(
        email: Email.dirty(value: state.email.value),
        password: Password.dirty(value: state.password.value),
        completeName: CompleteName.dirty(value: state.completeName.value),
        photoUrl: ProfilePhotoUrl.dirty(value: state.photoUrl.value),
        isValid: isFormValid,
      ),
    );

    return isFormValid;
  }
}
