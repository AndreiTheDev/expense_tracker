import 'package:formz/formz.dart';

enum ProfilePhotoUrlValidationErrors {
  empty(errorMessage: 'You must chose a profile picture.');

  const ProfilePhotoUrlValidationErrors({required this.errorMessage});

  final String errorMessage;
}

class ProfilePhotoUrl
    extends FormzInput<String, ProfilePhotoUrlValidationErrors> {
  const ProfilePhotoUrl.pure() : super.pure('');
  const ProfilePhotoUrl.dirty({final String value = ''}) : super.dirty(value);

  @override
  ProfilePhotoUrlValidationErrors? validator(final String value) {
    if (value.isEmpty) {
      return ProfilePhotoUrlValidationErrors.empty;
    }
    return null;
  }
}
