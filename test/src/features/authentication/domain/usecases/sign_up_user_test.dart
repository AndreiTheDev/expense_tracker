import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_signup_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/sign_up_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_user_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthenticationRepository>(),
  MockSpec<UserSignUpDetailsEntity>(),
])
void main() {
  late MockUserSignUpDetailsEntity mockUserDetails;
  late SignUpUser sut;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockUserDetails = MockUserSignUpDetailsEntity();
    mockAuthenticationRepository = MockAuthenticationRepository();
    sut = SignUpUser(mockAuthenticationRepository);
  });

  const userEntity = UserEntity(
    uid: 'test',
    email: 'test@email.com',
    fcmToken: 'test',
    completeName: 'test',
    photoUrl: 'test',
  );

  test('Sign up user successfully', () async {
    provideDummy<Either<Failure, UserEntity>>(const Right(userEntity));
    when(
      mockAuthenticationRepository.signUpUser(mockUserDetails),
    ).thenAnswer(
      (realInvocation) async => const Right(userEntity),
    );

    final result = await sut(mockUserDetails);

    expect(result, const Right(userEntity));
    verify(
      mockAuthenticationRepository.signUpUser(mockUserDetails),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });

  test('Signs Up user fails', () async {
    provideDummy<Either<Failure, UserEntity>>(
      const Left(AuthFailure(message: 'test')),
    );
    when(
      mockAuthenticationRepository.signUpUser(mockUserDetails),
    ).thenAnswer(
      (realInvocation) async => const Left(AuthFailure(message: 'test')),
    );

    final result = await sut(mockUserDetails);

    expect(result, const Left(AuthFailure(message: 'test')));
    verify(
      mockAuthenticationRepository.signUpUser(mockUserDetails),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
