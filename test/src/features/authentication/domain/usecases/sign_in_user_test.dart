import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/sign_in_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_in_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late SignInUser sut;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    sut = SignInUser(mockAuthenticationRepository);
  });

  const userEntity = UserEntity(
    uid: 'test',
    email: 'test@email.com',
    fcmToken: 'test',
    completeName: 'test',
    photoUrl: 'test',
  );

  test('Signs in user successfully', () async {
    provideDummy<Either<Failure, UserEntity>>(const Right(userEntity));
    when(
      mockAuthenticationRepository.signInUser('test@gmail.com', 'testpassword'),
    ).thenAnswer(
      (realInvocation) async => const Right(
        userEntity,
      ),
    );

    final result = await sut('test@gmail.com', 'testpassword');

    expect(result, const Right(userEntity));
    verify(
      mockAuthenticationRepository.signInUser('test@gmail.com', 'testpassword'),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });

  test('Signs in user fails', () async {
    provideDummy<Either<Failure, UserEntity>>(
      const Left(AuthFailure(message: 'test')),
    );
    when(
      mockAuthenticationRepository.signInUser('test@gmail.com', 'testpassword'),
    ).thenAnswer(
      (realInvocation) async => const Left(AuthFailure(message: 'test')),
    );

    final result = await sut('test@gmail.com', 'testpassword');

    expect(result, const Left(AuthFailure(message: 'test')));
    verify(
      mockAuthenticationRepository.signInUser('test@gmail.com', 'testpassword'),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
