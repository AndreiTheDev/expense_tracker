// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'failure_messages.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

class AuthFailure extends Failure {
  const AuthFailure({required super.message});

  factory AuthFailure.fromFirebaseException(final String code) {
    switch (code) {
      case (noUserDataCode):
        return const AuthFailure(message: noUserDataMessage);
      case (invalidEmailCode):
        return const AuthFailure(message: invalidEmailMessage);
      case (userNotExistsCode):
        return const AuthFailure(message: userNotExistsMessage);
      case (emailExistsCode):
        return const AuthFailure(message: emailExistsMessage);
      case (internalErrorCode):
        return const AuthFailure(message: internalErrorMessage);
      case (invalidCredentialCode):
        return const AuthFailure(message: invalidCredentialMessage);
      case (invalidPasswordCode):
        return const AuthFailure(message: invalidPasswordMessage);
      case (userDisabledCode):
        return const AuthFailure(message: userDisabledMessage);
      case (userNotFoundCode):
        return const AuthFailure(message: userNotFoundMessage);
      case (wrongPasswordCode):
        return const AuthFailure(message: wrongPasswordMessage);
      case (userCancelCode):
        return const AuthFailure(message: userCancelMessage);
      case (usernameInUseCode):
        return const AuthFailure(message: usernameInUseMessage);
      default:
        return const AuthFailure(message: unknownErrorMessage);
    }
  }

  factory AuthFailure.fromFirestoreException(final String code) {
    switch (code) {
      case (abortedCode):
        return const AuthFailure(message: abortedMessage);
      case (alreadyExistsCode):
        return const AuthFailure(message: alreadyExistsMessage);
      case (cancelledCode):
        return const AuthFailure(message: cancelledMessage);
      case (dataLossCode):
        return const AuthFailure(message: dataLossMessage);
      case (deadlineExceededCode):
        return const AuthFailure(message: deadlineExceededMessage);
      case (failedPreconditionCode):
        return const AuthFailure(message: failedPreconditionMessage);
      case (invalidArgumentCode):
        return const AuthFailure(message: invalidArgumentMessage);
      case (notFoundCode):
        return const AuthFailure(message: notFoundMessage);
      case (outOfRangeCode):
        return const AuthFailure(message: outOfRangeMessage);
      case (permissionDeniedCode):
        return const AuthFailure(message: permissionDeniedMessage);
      case (resourceExhaustedCode):
        return const AuthFailure(message: resourceExhaustedMessage);
      case (unauthenticatedCode):
        return const AuthFailure(message: unauthenticatedMessage);
      case (unavailableCode):
        return const AuthFailure(message: unavailableMessage);
      case (unimplementedCode):
        return const AuthFailure(message: unimplementedMessage);
      case (internalErrorCode):
        return const AuthFailure(message: internalErrorMessage);
      default:
        return const AuthFailure(message: unknownErrorMessage);
    }
  }

  factory AuthFailure.fromStorageException(final String code) {
    switch (code) {
      case (objectNotFoundCode):
        return const AuthFailure(message: objectNotFoundMessage);
      case (unauthorizedCode):
        return const AuthFailure(message: unauthorizedMessage);
      case (invalidCheckSumCode):
        return const AuthFailure(message: invalidCheckSumMessage);
      case (cannotSliceBlobCode):
        return const AuthFailure(message: cannotSliceBlobMessage);
      case (fileTooLargeCode):
        return const AuthFailure(message: fileTooLargeMessage);
      case (unauthenticatedCode):
        return const AuthFailure(message: unauthenticatedMessage);
      default:
        return const AuthFailure(message: unknownErrorMessage);
    }
  }
}
