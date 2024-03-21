import 'package:formz/formz.dart';

enum DescriptionValidationErrors {
  empty(errorMessage: 'The description should not be empty.'),
  tooShort(errorMessage: 'The description is too short.');

  const DescriptionValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class Description extends FormzInput<String, DescriptionValidationErrors> {
  const Description.pure() : super.pure('');
  const Description.dirty({final String value = ''}) : super.dirty(value);

  @override
  DescriptionValidationErrors? validator(final String value) {
    if (value.isEmpty) {
      return DescriptionValidationErrors.empty;
    }
    if (value.length < 4) {
      return DescriptionValidationErrors.tooShort;
    }
    return null;
  }
}
