// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_signup_details.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasources/authentication_firebase_data_source.dart';
import '../datasources/authentication_firestore_data_source.dart';
import '../datasources/authentication_messaging_data_source.dart';
import '../datasources/authentication_storage_data_source.dart';
import '../dto/user_signup_details.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationFirebaseDataSource firebaseDataSource;
  final AuthenticationFirestoreDataSource firestoreDataSource;
  final AuthenticationStorageDataSource storageDataSource;
  final AuthenticationMessagingDataSource messagingDataSource;

  AuthenticationRepositoryImpl({
    required this.firebaseDataSource,
    required this.firestoreDataSource,
    required this.storageDataSource,
    required this.messagingDataSource,
  });

  @override
  Future<Either<Failure, void>> deleteUser() async {
    try {
      await firebaseDataSource.deleteUser();
      return const Right(null);
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured.'));
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
    } on FirebaseException catch (e) {
      return Left(AuthFailure.fromFirestoreException(e.code));
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> recoverPassword(String email) async {
    try {
      await firebaseDataSource.recoverPassword(email);
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseException(e.code));
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

      final token = await messagingDataSource.getFcmToken();
      await firestoreDataSource.postUserFcmToken(userResponse.uid, token);

      final userDto = await firestoreDataSource.fetchUserData(userResponse.uid);

      if (userDto != null) {
        return Right(userDto);
      }
      return const Left(AuthFailure(message: 'Unable to sign in user.'));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on FirebaseException catch (e) {
      return Left(
        AuthFailure.fromFirestoreException(e.code),
      );
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpUser(
    final UserSignUpDetailsEntity userDetailsEntity,
  ) async {
    try {
      final UserSignUpDetailsDto userDetailsDto =
          UserSignUpDetailsDto.fromEntity(userDetailsEntity);
      final userResponse = await firebaseDataSource.signUpUser(
        userDetailsDto.email,
        userDetailsDto.password,
      );
      final fcmToken = await messagingDataSource.getFcmToken();

      await firestoreDataSource.postUserSignUpDataAndFcm(
        userResponse.uid,
        userDetailsDto,
        fcmToken,
      );

      final userDto = await firestoreDataSource.fetchUserData(userResponse.uid);
      if (userDto != null) {
        return Right(userDto);
      }
      return const Left(AuthFailure(message: 'Unable to sign up user.'));
    } on AuthException catch (e) {
      return Left(AuthFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on FirebaseException catch (e) {
      return Left(
        AuthFailure.fromFirestoreException(e.code),
      );
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> signOutUser() async {
    try {
      await firebaseDataSource.signOutUser();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on Exception {
      return const Left(AuthFailure(message: 'An unknown error occured'));
    }
  }
}
