// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_details.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_firebase_data_source.dart';
import '../datasources/authentication_firestore_data_source.dart';
import '../datasources/authentication_functions_data_source.dart';
import '../datasources/authentication_storage_data_source.dart';
import '../dto/user.dart';
import '../dto/user_details.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationFirebaseDataSource firebaseDataSource;
  final AuthenticationFirestoreDataSource firestoreDataSource;
  final AuthenticationFunctionsDataSource functionsDataSource;
  final AuthenticationStorageDataSource storageDataSource;

  AuthenticationRepositoryImpl({
    required this.firebaseDataSource,
    required this.firestoreDataSource,
    required this.functionsDataSource,
    required this.storageDataSource,
  });

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      await firebaseDataSource.deleteUser();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> isSignedIn() async {
    try {
      final user = firebaseDataSource.isSignedIn();
      if (user == null) {
        return const Right(null);
      }
      final userDto = await firestoreDataSource.fetchUserData(user.uid);
      if (userDto != null) {
        return Right(userDto);
      }
      return const Left(
        AuthFailure(message: 'Unable to verify if user is already signed in.'),
      );
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> recoverPassword(String email) async {
    try {
      await firebaseDataSource.recoverPassword(email);
      return const Right(null);
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInUser(
    String email,
    String password,
  ) async {
    try {
      final userResponse = await firebaseDataSource.signInUser(email, password);
      final userDto = await firestoreDataSource.fetchUserData(userResponse.uid);
      if (userDto != null) {
        return Right(userDto);
      }
      return const Left(AuthFailure(message: 'Unable to sign in user.'));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on FirestoreException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error happened.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpUser(
    final UserDetailsEntity userDetails,
  ) async {
    try {
      final userDetailsDto = UserDetailsDto.fromEntity(userDetails);
      final firebaseUser = await firebaseDataSource.signUpUser(
        userDetailsDto.email,
        userDetailsDto.password,
      );
      final bool isSuccess =
          await _sendUserData(firebaseUser.uid, userDetailsDto);
      UserDto? userDto;
      if (isSuccess) {
        userDto = await firestoreDataSource.fetchUserData(firebaseUser.uid);
      }
      if (userDto != null) {
        return Right(userDto);
      }
      return const Left(AuthFailure(message: 'Unable to sign up user.'));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error happened.'));
    }
  }

  @override
  Future<Either<Failure, void>> signOutUser() async {
    try {
      await firebaseDataSource.signOutUser();
      return const Right(null);
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured'));
    }
  }

  //adding user photo to storage location
  //calling backend function to create user db document and hydrate it with data
  Future<bool> _sendUserData(
    final String uid,
    final UserDetailsDto userDetailsDto,
  ) async {
    final photoUrl =
        await storageDataSource.addPhotoToStorage(userDetailsDto.photo);
    await firestoreDataSource.postUserPhoto(uid, photoUrl);
    final isSuccess = await functionsDataSource.addUserDetailsToDb(
      uid,
      userDetailsDto,
    );
    return isSuccess;
  }
}
