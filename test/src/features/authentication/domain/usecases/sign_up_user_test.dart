import 'package:expense_tracker_app_bloc/src/core/error/failures.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/entities/user_details.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:expense_tracker_app_bloc/src/features/authentication/domain/usecases/sign_up_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sign_up_user_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthenticationRepository>(),
  MockSpec<UserDetailsEntity>(),
])
void main() {
  late MockUserDetailsEntity mockUserDetails;
  late SignUpUser usecase;
  late MockAuthenticationRepository mockAuthenticationRepository;

  setUp(() {
    mockUserDetails = MockUserDetailsEntity();
    mockAuthenticationRepository = MockAuthenticationRepository();
    usecase = SignUpUser(mockAuthenticationRepository);
  });

  const userEntity = UserEntity(
    uid: 'test',
    email: 'test@email.com',
    fcmToken: 'test',
    completeName: 'test',
    photoUrl: 'test',
  );

  test('Should sign up user', () async {
    provideDummy<Either<Failure, UserEntity>>(const Right(userEntity));
    when(
      mockAuthenticationRepository.signUpUser(mockUserDetails),
    ).thenAnswer(
      (realInvocation) async => const Right(userEntity),
    );

    final result = await usecase(mockUserDetails);

    expect(result, const Right(userEntity));
    verify(
      mockAuthenticationRepository.signUpUser(mockUserDetails),
    ).called(1);
    verifyNoMoreInteractions(mockAuthenticationRepository);
  });
}
