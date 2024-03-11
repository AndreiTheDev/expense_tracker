import 'package:formz/formz.dart';

enum EmailValidationErrors {
  empty(errorMessage: 'Email should not be empty.'),
  invalid(errorMessage: 'Email is invalid.');

  const EmailValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class Email extends FormzInput<String, EmailValidationErrors> {
  const Email.pure() : super.pure('');
  const Email.dirty({final String value = ''}) : super.dirty(value);

  static final _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  @override
  EmailValidationErrors? validator(String value) {
    if (value.isEmpty) {
      return EmailValidationErrors.empty;
    }
    return _emailRegex.hasMatch(value) ? null : EmailValidationErrors.invalid;
  }
}
