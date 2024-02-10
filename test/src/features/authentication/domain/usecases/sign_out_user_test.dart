import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/sign_out_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_out_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late SignOutUser sut;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    sut = SignOutUser(mockAuthenticationRepository);
  });

  test('Sign user out successfully', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    when(mockAuthenticationRepository.signOutUser())
        .thenAnswer((realInvocation) async => const Right(null));

    final response = await sut();

    expect(response, const Right(null));
    verify(mockAuthenticationRepository.signOutUser()).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });

  test('Sign user out fails', () async {
    provideDummy<Either<Failure, void>>(
      const Left(AuthFailure(message: 'An unknown error occured.')),
    );
    when(mockAuthenticationRepository.signOutUser()).thenAnswer(
      (realInvocation) async =>
          const Left(AuthFailure(message: 'An unknown error occured.')),
    );

    final response = await sut();

    expect(
      response,
      const Left(AuthFailure(message: 'An unknown error occured.')),
    );
    verify(mockAuthenticationRepository.signOutUser()).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
