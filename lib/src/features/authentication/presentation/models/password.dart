import 'package:formz/formz.dart';

enum PasswordValidationErrors {
  tooShort(errorMessage: 'Password must be at least 8 characters long.'),
  noUppercaseLetter(
    errorMessage: 'Password must contain at least one uppercase letter.',
  ),
  noDigit(
    errorMessage: 'Password must contain at least one numeric character.',
  ),
  noSpecialCharacter(
    errorMessage: 'Password must contain at least one special character.',
  ),
  invalid(errorMessage: 'Password is invalid.');

  const PasswordValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class Password extends FormzInput<String, PasswordValidationErrors> {
  const Password.pure() : super.pure('');
  const Password.dirty({final String value = ''}) : super.dirty(value);

  @override
  PasswordValidationErrors? validator(String value) {
    if (value.length < 8) {
      return PasswordValidationErrors.tooShort;
    }
    if (!RegExp('[A-Z]').hasMatch(value)) {
      return PasswordValidationErrors.noUppercaseLetter;
    }
    if (!RegExp('[0-9]').hasMatch(value)) {
      return PasswordValidationErrors.noDigit;
    }
    if (!RegExp(r'[!@#\$%^&*()<>?/|}{~:]').hasMatch(value)) {
      return PasswordValidationErrors.noSpecialCharacter;
    }
    return null;
  }
}
