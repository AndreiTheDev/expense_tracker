import 'package:formz/formz.dart';

enum DateValidationErrors {
  empty(errorMessage: 'The date should not be empty.');

  const DateValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class Date extends FormzInput<String, DateValidationErrors> {
  const Date.pure() : super.pure('');
  const Date.dirty({final String value = ''}) : super.dirty(value);

  @override
  DateValidationErrors? validator(final String value) {
    if (value.isEmpty) {
      return DateValidationErrors.empty;
    }
    return null;
  }
}
