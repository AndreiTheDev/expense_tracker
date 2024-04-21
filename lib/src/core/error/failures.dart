// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'failure_messages.dart';

abstract base class Failure extends Equatable {
  final String message;

  const Failure({
    required this.message,
  });

  @override
  List<Object?> get props => [message];
}

final class AuthFailure extends Failure {
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

final class HomeFailure extends Failure {
  const HomeFailure({required super.message});

  factory HomeFailure.fromFirestoreException(final String code) {
    switch (code) {
      case (abortedCode):
        return const HomeFailure(message: abortedMessage);
      case (alreadyExistsCode):
        return const HomeFailure(message: alreadyExistsMessage);
      case (cancelledCode):
        return const HomeFailure(message: cancelledMessage);
      case (dataLossCode):
        return const HomeFailure(message: dataLossMessage);
      case (deadlineExceededCode):
        return const HomeFailure(message: deadlineExceededMessage);
      case (failedPreconditionCode):
        return const HomeFailure(message: failedPreconditionMessage);
      case (invalidArgumentCode):
        return const HomeFailure(message: invalidArgumentMessage);
      case (notFoundCode):
        return const HomeFailure(message: notFoundMessage);
      case (outOfRangeCode):
        return const HomeFailure(message: outOfRangeMessage);
      case (permissionDeniedCode):
        return const HomeFailure(message: permissionDeniedMessage);
      case (resourceExhaustedCode):
        return const HomeFailure(message: resourceExhaustedMessage);
      case (unauthenticatedCode):
        return const HomeFailure(message: unauthenticatedMessage);
      case (unavailableCode):
        return const HomeFailure(message: unavailableMessage);
      case (unimplementedCode):
        return const HomeFailure(message: unimplementedMessage);
      case (internalErrorCode):
        return const HomeFailure(message: internalErrorMessage);
      default:
        return const HomeFailure(message: unknownErrorMessage);
    }
  }
}

final class ViewallFailure extends Failure {
  const ViewallFailure({required super.message});

  factory ViewallFailure.fromFirestoreException(final String code) {
    switch (code) {
      case (abortedCode):
        return const ViewallFailure(message: abortedMessage);
      case (alreadyExistsCode):
        return const ViewallFailure(message: alreadyExistsMessage);
      case (cancelledCode):
        return const ViewallFailure(message: cancelledMessage);
      case (dataLossCode):
        return const ViewallFailure(message: dataLossMessage);
      case (deadlineExceededCode):
        return const ViewallFailure(message: deadlineExceededMessage);
      case (failedPreconditionCode):
        return const ViewallFailure(message: failedPreconditionMessage);
      case (invalidArgumentCode):
        return const ViewallFailure(message: invalidArgumentMessage);
      case (notFoundCode):
        return const ViewallFailure(message: notFoundMessage);
      case (outOfRangeCode):
        return const ViewallFailure(message: outOfRangeMessage);
      case (permissionDeniedCode):
        return const ViewallFailure(message: permissionDeniedMessage);
      case (resourceExhaustedCode):
        return const ViewallFailure(message: resourceExhaustedMessage);
      case (unauthenticatedCode):
        return const ViewallFailure(message: unauthenticatedMessage);
      case (unavailableCode):
        return const ViewallFailure(message: unavailableMessage);
      case (unimplementedCode):
        return const ViewallFailure(message: unimplementedMessage);
      case (internalErrorCode):
        return const ViewallFailure(message: internalErrorMessage);
      default:
        return const ViewallFailure(message: unknownErrorMessage);
    }
  }
}

final class SwitchAccountFailure extends Failure {
  const SwitchAccountFailure({required super.message});

  factory SwitchAccountFailure.fromFirestoreException(final String code) {
    switch (code) {
      case (abortedCode):
        return const SwitchAccountFailure(message: abortedMessage);
      case (alreadyExistsCode):
        return const SwitchAccountFailure(message: alreadyExistsMessage);
      case (cancelledCode):
        return const SwitchAccountFailure(message: cancelledMessage);
      case (dataLossCode):
        return const SwitchAccountFailure(message: dataLossMessage);
      case (deadlineExceededCode):
        return const SwitchAccountFailure(message: deadlineExceededMessage);
      case (failedPreconditionCode):
        return const SwitchAccountFailure(message: failedPreconditionMessage);
      case (invalidArgumentCode):
        return const SwitchAccountFailure(message: invalidArgumentMessage);
      case (notFoundCode):
        return const SwitchAccountFailure(message: notFoundMessage);
      case (outOfRangeCode):
        return const SwitchAccountFailure(message: outOfRangeMessage);
      case (permissionDeniedCode):
        return const SwitchAccountFailure(message: permissionDeniedMessage);
      case (resourceExhaustedCode):
        return const SwitchAccountFailure(message: resourceExhaustedMessage);
      case (unauthenticatedCode):
        return const SwitchAccountFailure(message: unauthenticatedMessage);
      case (unavailableCode):
        return const SwitchAccountFailure(message: unavailableMessage);
      case (unimplementedCode):
        return const SwitchAccountFailure(message: unimplementedMessage);
      case (internalErrorCode):
        return const SwitchAccountFailure(message: internalErrorMessage);
      default:
        return const SwitchAccountFailure(message: unknownErrorMessage);
    }
  }
}
