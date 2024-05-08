import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/delete_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late DeleteUser sut;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    sut = DeleteUser(mockAuthenticationRepository);
  });

  test('Deletes the current user successfully', () async {
    provideDummy<Either<Failure, void>>(const Right(null));
    when(mockAuthenticationRepository.deleteUser('test')).thenAnswer(
      (realInvocation) async => const Right(null),
    );

    final result = await sut('test');

    expect(result, const Right(null));
    verify(mockAuthenticationRepository.deleteUser('test')).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });

  test('Deletes the current user fails', () async {
    provideDummy<Either<Failure, void>>(
      const Left(AuthFailure(message: 'test')),
    );
    when(
      mockAuthenticationRepository.deleteUser('test'),
    ).thenAnswer(
      (realInvocation) async => const Left(AuthFailure(message: 'test')),
    );

    final result = await sut('test');

    expect(result, const Left(AuthFailure(message: 'test')));
    verify(
      mockAuthenticationRepository.deleteUser('test'),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
