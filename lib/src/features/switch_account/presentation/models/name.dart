import 'package:formz/formz.dart';

enum NameValidationErrors {
  empty(errorMessage: 'Name should not be empty.'),
  tooShort(errorMessage: 'Name should be at least 3 characters long.');

  const NameValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class Name extends FormzInput<String, NameValidationErrors> {
  const Name.pure() : super.pure('');
  const Name.dirty({final String value = ''}) : super.dirty(value);

  @override
  NameValidationErrors? validator(String value) {
    if (value.isEmpty) {
      return NameValidationErrors.empty;
    }
    if (value.length < 3) {
      return NameValidationErrors.tooShort;
    }
    return null;
  }
}
