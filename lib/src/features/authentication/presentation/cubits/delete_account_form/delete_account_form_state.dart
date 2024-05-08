part of 'delete_account_form_cubit.dart';

class DeleteAccountFormState extends Equatable {
  const DeleteAccountFormState({
    this.password = const Password.pure(),
    this.isValid = false,
  });

  final Password password;
  final bool isValid;

  DeleteAccountFormState copyWith({
    final Password? password,
    final bool? isValid,
  }) {
    return DeleteAccountFormState(
      password: password ?? this.password,
      isValid: isValid ?? this.isValid,
    );
  }

  @override
  List<Object> get props => [password, isValid];
}
