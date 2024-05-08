// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/logger.dart';
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
  final Logger _logger = getLogger(AuthenticationRepositoryImpl);

  AuthenticationRepositoryImpl({
    required this.firebaseDataSource,
    required this.firestoreDataSource,
    required this.storageDataSource,
    required this.messagingDataSource,
  });

  @override
  Future<Either<Failure, void>> deleteUser(final String password) async {
    _logger.d('deleteUser - called');
    try {
      await firebaseDataSource.reauthenticateUser(password);
      await firebaseDataSource.deleteUser();
      _logger.i('deleteUser - success');
      return const Right(null);
    } on AuthException catch (e) {
      _logger.e('deleteUser - AuthException: ${e.code}');
      return Left(AuthFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      _logger.e('deleteUser - FirebaseAuthException: ${e.code}');
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on Exception {
      _logger.e('deleteUser - an unknown error occured');
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity?>> isSignedIn() async {
    _logger.d('isSignedIn - called');
    try {
      final user = firebaseDataSource.isSignedIn();
      if (user == null) {
        _logger.i('isSignedIn - success with null user');
        return const Right(null);
      }
      final userDto = await firestoreDataSource.fetchUserData(user.uid);
      if (userDto != null) {
        _logger.i('isSignedIn - success with user data');
        return Right(userDto);
      }
      _logger.e('isSignedIn - unable to verify user sign in status');
      return const Left(
        AuthFailure(message: 'Unable to verify if user is already signed in.'),
      );
    } on AuthException catch (e) {
      _logger.e('isSignedIn - AuthException: ${e.code}');
      return Left(AuthFailure(message: e.message));
    } on FirebaseException catch (e) {
      _logger.e('isSignedIn - FirebaseAuthException: ${e.code}');
      return Left(AuthFailure.fromFirestoreException(e.code));
    } on Exception {
      _logger.e('isSignedIn - an unknown error occured');
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> recoverPassword(String email) async {
    _logger.d('recoverPassword - called');
    try {
      await firebaseDataSource.recoverPassword(email);
      _logger.i('recoverPassword - success');
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      _logger.e('recoverPassword - FirebaseAuthException: ${e.code}');
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on Exception {
      _logger.e('recoverPassword - an unknown error occured');
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signInUser(
    String email,
    String password,
  ) async {
    _logger.d('signInUser - called');
    try {
      final userResponse = await firebaseDataSource.signInUser(email, password);

      final token = await messagingDataSource.getFcmToken();
      await firestoreDataSource.postUserFcmToken(userResponse.uid, token);

      final userDto = await firestoreDataSource.fetchUserData(userResponse.uid);

      if (userDto != null) {
        _logger.i('signInUser - success');
        return Right(userDto);
      }
      _logger.e('signInUser - unable to sign in user');
      return const Left(AuthFailure(message: 'Unable to sign in user.'));
    } on AuthException catch (e) {
      _logger.e('signInUser - AuthException: ${e.code}');
      return Left(AuthFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      _logger.e('signInUser - FirebaseAuthException: ${e.code}');
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on FirebaseException catch (e) {
      _logger.e('signInUser - FirebaseException: ${e.code}');
      return Left(
        AuthFailure.fromFirestoreException(e.code),
      );
    } on Exception {
      _logger.e('signInUser - an unknown error occured');
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signUpUser(
    final UserSignUpDetailsEntity userDetailsEntity,
  ) async {
    _logger.d('signUpUser - called');
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
        _logger.i('signUpUser - success');
        return Right(userDto);
      }
      _logger.e('signUpUser - unable to sign up user');
      return const Left(AuthFailure(message: 'Unable to sign up user.'));
    } on AuthException catch (e) {
      _logger.e('signUpUser - AuthException: ${e.code}');
      return Left(AuthFailure(message: e.message));
    } on FirebaseAuthException catch (e) {
      _logger.e('signUpUser - FirebaseAuthException: ${e.code}');
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on FirebaseException catch (e) {
      _logger.e('signUpUser - FirebaseException: ${e.code}');
      return Left(
        AuthFailure.fromFirestoreException(e.code),
      );
    } on Exception {
      _logger.e('signUpUser - an unknown error occured');
      return const Left(AuthFailure(message: 'An unknown error occured.'));
    }
  }

  @override
  Future<Either<Failure, void>> signOutUser() async {
    _logger.d('signOutUser - called');
    try {
      await firebaseDataSource.signOutUser();
      _logger.i('signOutUser - success');
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      _logger.e('signOutUser - FirebaseAuthException: ${e.code}');
      return Left(AuthFailure.fromFirebaseException(e.code));
    } on Exception {
      _logger.e('signOutUser - an unknown error occured');
      return const Left(AuthFailure(message: 'An unknown error occured'));
    }
  }
}
