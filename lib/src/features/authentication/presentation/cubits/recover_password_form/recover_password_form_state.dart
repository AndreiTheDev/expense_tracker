part of 'recover_password_form_cubit.dart';

class RecoverPasswordFormState extends Equatable {
  const RecoverPasswordFormState({
    this.email = const Email.pure(),
    this.isValid = false,
  });

  final Email email;
  final bool isValid;

  RecoverPasswordFormState copyWith({
    final Email? email,
    final bool? isValid,
  }) {
    return RecoverPasswordFormState(
      email: email ?? this.email,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [email, isValid];
}
