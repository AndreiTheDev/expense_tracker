import 'package:formz/formz.dart';

enum AmountValidationErrors {
  empty(errorMessage: 'The amount should not be empty.');

  const AmountValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class Amount extends FormzInput<String, AmountValidationErrors> {
  const Amount.pure() : super.pure('');
  const Amount.dirty({final String value = ''}) : super.dirty(value);

  @override
  AmountValidationErrors? validator(final String value) {
    if (value.isEmpty) {
      return AmountValidationErrors.empty;
    }
    return null;
  }
}
