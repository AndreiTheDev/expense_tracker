part of 'add_account_form_cubit.dart';

class AddAccountFormState extends Equatable {
  const AddAccountFormState({
    this.name = const Name.pure(),
    this.isValid = false,
  });

  final Name name;
  final bool isValid;

  AddAccountFormState copyWith({
    final Name? name,
    final bool? isValid,
  }) {
    return AddAccountFormState(
      name: name ?? this.name,
      isValid: isValid ?? this.isValid,
    );
  }

  AccountEntity toAccountEntity(final String uid, final String username) {
    return AccountEntity(name: name.value, createdBy: uid, owner: username);
  }

  @override
  List<Object> get props => [name, isValid];
}
