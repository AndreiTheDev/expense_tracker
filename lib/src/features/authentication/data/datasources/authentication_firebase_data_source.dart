import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/utils/logger.dart';

abstract interface class AuthenticationFirebaseDataSource {
  Future<User> signInUser(final String email, final String password);
  Future<User> signUpUser(final String email, final String password);
  User? isSignedIn();
  Future<void> deleteUser();
  Future<void> recoverPassword(final String email);
  Future<void> signOutUser();
}

class AuthenticationFirebaseDataSourceImpl
    implements AuthenticationFirebaseDataSource {
  final FirebaseAuth _authInstance;
  final Logger _logger = getLogger(AuthenticationFirebaseDataSourceImpl);

  AuthenticationFirebaseDataSourceImpl(this._authInstance);

  @override
  Future<void> deleteUser() async {
    _logger.d('deleteUser - called');
    if (_authInstance.currentUser != null) {
      await _authInstance.currentUser!.delete();
    } else {
      throw AuthException(
        code: 'delete-failed',
        message: 'Unable to delete the current user.',
      );
    }
  }

  @override
  Future<void> recoverPassword(final String email) async {
    _logger.d('recoverPassword - called');
    await _authInstance.sendPasswordResetEmail(email: email);
  }

  @override
  User? isSignedIn() {
    _logger.d('isSignedIn - called');
    return _authInstance.currentUser;
  }

  @override
  Future<User> signInUser(String email, String password) async {
    _logger.d('signInUser - called');
    final response = await _authInstance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (response.user != null) {
      return response.user!;
    } else {
      throw AuthException(
        code: 'signin-failed',
        message: 'Unable to authenticate the user.',
      );
    }
  }

  @override
  Future<User> signUpUser(String email, String password) async {
    final response = await _authInstance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (response.user != null) {
      return response.user!;
    } else {
      throw AuthException(
        code: 'signup-failed',
        message: 'Unable to create an account.',
      );
    }
  }

  @override
  Future<void> signOutUser() async {
    await _authInstance.signOut();
  }
}
