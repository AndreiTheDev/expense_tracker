import 'package:formz/formz.dart';

enum CompleteNameValidationErrors {
  empty(errorMessage: 'Your name should not be empty.'),
  tooShort(errorMessage: 'Your name must be at least 4 characters long.');

  const CompleteNameValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class CompleteName extends FormzInput<String, CompleteNameValidationErrors> {
  const CompleteName.pure() : super.pure('');
  const CompleteName.dirty({final String value = ''}) : super.dirty(value);

  @override
  CompleteNameValidationErrors? validator(final String value) {
    if (value.isEmpty) {
      return CompleteNameValidationErrors.empty;
    }
    if (value.length < 4) {
      return CompleteNameValidationErrors.tooShort;
    }
    return null;
  }
}
