part of 'sign_in_form_cubit.dart';

class SignInFormState extends Equatable {
  const SignInFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValid = false,
  });

  final Email email;
  final Password password;
  final bool isValid;

  SignInFormState copyWith({
    final Email? email,
    final Password? password,
    final bool? isValid,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [email, password, isValid];
}
