part of 'sign_up_form_cubit.dart';

class SignUpFormState extends Equatable {
  const SignUpFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.isValidFirstStep = false,
    this.photoUrl = const ProfilePhotoUrl.pure(),
    this.completeName = const CompleteName.pure(),
    this.isValid = false,
  });

  final Email email;
  final Password password;
  final bool isValidFirstStep;
  final ProfilePhotoUrl photoUrl;
  final CompleteName completeName;
  final bool isValid;

  SignUpFormState copyWith({
    final Email? email,
    final Password? password,
    final bool? isValidFirstStep,
    final ProfilePhotoUrl? photoUrl,
    final CompleteName? completeName,
    final bool? isValid,
  }) {
    return SignUpFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      isValidFirstStep: isValidFirstStep ?? this.isValidFirstStep,
      photoUrl: photoUrl ?? this.photoUrl,
      completeName: completeName ?? this.completeName,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props =>
      [email, password, isValidFirstStep, photoUrl, completeName, isValid];
}
