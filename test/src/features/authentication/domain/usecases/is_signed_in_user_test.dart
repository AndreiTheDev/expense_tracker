import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/is_signed_in_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'is_signed_in_user_test.mocks.dart';

@GenerateNiceMocks([MockSpec<AuthenticationRepository>()])
void main() {
  late IsSignedInUser usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = IsSignedInUser(mockAuthenticationRepository);
  });

  const userEntity = UserEntity(
    uid: 'test',
    fcmToken: 'test',
    completeName: 'test',
    photoUrl: 'test',
  );

  test('Should return the signed in user', () async {
    provideDummy<Either<Failure, UserEntity>>(const Right(userEntity));
    when(mockAuthenticationRepository.isSignedIn()).thenAnswer(
      (realInvocation) async => const Right(userEntity),
    );

    final result = await usecase();

    expect(result, const Right(userEntity));
    verify(mockAuthenticationRepository.isSignedIn()).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
