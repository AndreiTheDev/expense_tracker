import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_signup_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/cubits/sign_up_form/sign_up_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/complete_name.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/email.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/password.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/models/profile_photo_url.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('SignUpFormState copyWith returns right data', () {
    const sut = SignUpFormState();
    final response = sut.copyWith(
      email: const Email.dirty(value: 'test'),
      password: const Password.dirty(value: 'test'),
      photoUrl: const ProfilePhotoUrl.dirty(value: 'test'),
      completeName: const CompleteName.dirty(value: 'test'),
      isValid: false,
    );
    expect(
      response,
      const SignUpFormState(
        email: Email.dirty(value: 'test'),
        password: Password.dirty(value: 'test'),
        photoUrl: ProfilePhotoUrl.dirty(value: 'test'),
        completeName: CompleteName.dirty(value: 'test'),
      ),
    );
  });

  test('SignUpFormState copyWith with null values returns old object', () {
    const sut = SignUpFormState();
    final response = sut.copyWith();
    expect(
      response,
      sut,
    );
  });

  test(
      'SignUpFormState toUserSignUpDetailsEntity return UserSignUpDetailsEntity',
      () {
    const sut = SignUpFormState(
      email: Email.dirty(value: 'test'),
      password: Password.dirty(value: 'test'),
      photoUrl: ProfilePhotoUrl.dirty(value: 'test'),
      completeName: CompleteName.dirty(value: 'test'),
    );

    final response = sut.toUserSignUpDetailsEntity();

    expect(
      response,
      const UserSignUpDetailsEntity(
        email: 'test',
        password: 'test',
        completeName: 'test',
        photoUrl: 'test',
      ),
    );
  });
}
