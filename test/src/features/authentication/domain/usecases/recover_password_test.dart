import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/recover_password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'recover_password_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late RecoverPassword sut;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    sut = RecoverPassword(mockAuthenticationRepository);
  });

  test('Sends recovery email to the provided email successfully', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    when(
      mockAuthenticationRepository.recoverPassword('test@email.com'),
    ).thenAnswer(
      (realInvocation) async => const Right(null),
    );

    final result = await sut('test@gmail.com');

    expect(result, const Right(null));
    verify(
      mockAuthenticationRepository.recoverPassword('test@gmail.com'),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });

  test('Sends recovery email to the provided email fails', () async {
    provideDummy<Either<Failure, void>>(
      const Left(AuthFailure(message: 'test')),
    );
    when(
      mockAuthenticationRepository.recoverPassword(
        'test@gmail.com',
      ),
    ).thenAnswer(
      (realInvocation) async => const Left(AuthFailure(message: 'test')),
    );

    final result = await sut('test@gmail.com');

    expect(result, const Left(AuthFailure(message: 'test')));
    verify(
      mockAuthenticationRepository.recoverPassword('test@gmail.com'),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
