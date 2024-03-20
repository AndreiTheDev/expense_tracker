import 'package:formz/formz.dart';

enum CategoryValidationErrors {
  empty(errorMessage: 'Please specify a category.'),
  tooShort(errorMessage: 'Category name is too short.');

  const CategoryValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class Category extends FormzInput<String, CategoryValidationErrors> {
  const Category.pure() : super.pure('');
  const Category.dirty({final String value = ''}) : super.dirty(value);

  @override
  CategoryValidationErrors? validator(final String value) {
    if (value.isEmpty) {
      return CategoryValidationErrors.empty;
    }
    if (value.length < 2) {
      return CategoryValidationErrors.tooShort;
    }
    return null;
  }
}
