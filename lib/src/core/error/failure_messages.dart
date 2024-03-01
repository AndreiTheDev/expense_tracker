//-----codes

//App
const String unknownErrorCode = 'unknown-error';

//Firebase
const String noUserDataCode = 'no-user-data';
const String invalidEmailCode = 'invalid-email';
const String userNotExistsCode = 'user-not-exists';
const String emailExistsCode = 'email-already-exists';
const String invalidCredentialCode = 'invalid-credential';
const String invalidPasswordCode = 'invalid-password';
const String userDisabledCode = 'user-disabled';
const String userNotFoundCode = 'user-not-found';
const String wrongPasswordCode = 'wrong-password';
const String userCancelCode = 'user-cancel';
const String usernameInUseCode = 'username-in-use';

//Firestore
const String abortedCode = 'aborted';
const String alreadyExistsCode = 'already-exists';
const String cancelledCode = 'cancelled';
const String dataLossCode = 'data-loss';
const String deadlineExceededCode = 'deadline-exceeded';
const String failedPreconditionCode = 'failed-precondition';
const String invalidArgumentCode = 'invalid-argument';
const String notFoundCode = 'not-found';
const String outOfRangeCode = 'out-of-range';
const String permissionDeniedCode = 'permission-denied';
const String resourceExhaustedCode = 'resource-exhausted';
const String unavailableCode = 'unavailable';
const String unimplementedCode = 'unimplemented';

//Storage
const String objectNotFoundCode = 'object-not-found';
const String unauthorizedCode = 'unauthorized';
const String invalidCheckSumCode = 'invalid-checksum';
const String cannotSliceBlobCode = 'cannot-slice-blob';
const String fileTooLargeCode = 'server-file-wrong-size';

//Shared
const String internalErrorCode = 'internal-error';
const String unauthenticatedCode = 'unauthenticated';

//-----messages

//App
const String unknownErrorMessage = 'An unknown error occured.';

//Firebase
const String noUserDataMessage = 'Unable to get user data.';
const String invalidEmailMessage = 'The provided email is invalid.';
const String userNotExistsMessage = 'The user does not exist in database.';
const String emailExistsMessage = 'Email is already in use.';
const String invalidCredentialMessage = 'The provided credential is invalid.';
const String invalidPasswordMessage = 'The provided password is invalid.';
const String userDisabledMessage = 'Your account has been disabled.';
const String userNotFoundMessage = 'There is no user associated to this email.';
const String wrongPasswordMessage = 'The provided password is invalid.';
const String userCancelMessage = 'The user canceled the operation.';
const String usernameInUseMessage = 'Username is already in use.';

//Firestore
const String abortedMessage = 'The operation was aborted.';
const String alreadyExistsMessage =
    'The data already exists inside the database.';
const String cancelledMessage = 'The operation was cancelled.';
const String dataLossMessage = 'Unrecoverable data loss or corruption.';
const String deadlineExceededMessage =
    'Deadline expired before operation could complete.';
const String failedPreconditionMessage = 'Unable to execute the operation.';
const String invalidArgumentMessage = 'An invalid argument was used.';
const String notFoundMessage = 'The requested data was not found.';
const String outOfRangeMessage =
    'Operation was attempted past the valid range.';
const String permissionDeniedMessage =
    'You have no permission to execute this operation.';
const String resourceExhaustedMessage =
    'Resources have been exhausted, please contact us.';
const String unavailableMessage = 'The service is currently unavailable.';
const String unimplementedMessage =
    'Operation is not implemented or not supported/enabled.';

//Storage
const String objectNotFoundMessage =
    'There is no matching data inside the databse.';
const String unauthorizedMessage =
    'You are not authorized to perform this action.';
const String invalidCheckSumMessage = 'Please retry uploading your file.';
const String cannotSliceBlobMessage = 'Please retry uploading your file.';
const String fileTooLargeMessage = 'Please retry uploading your file.';

//Shared
const String internalErrorMessage =
    'The server encountered an error. Please try again later.';
const String unauthenticatedMessage = 'There is no user signed in.';
