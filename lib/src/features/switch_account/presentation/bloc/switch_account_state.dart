part of 'switch_account_bloc.dart';

sealed class SwitchAccountState extends Equatable {
  const SwitchAccountState();

  @override
  List<Object> get props => [];
}

final class SwitchAccountInitial extends SwitchAccountState {}

final class SwitchAccountLoading extends SwitchAccountState {}

final class SwitchAccountLoaded extends SwitchAccountState {
  final List<AccountEntity> accountsList;

  const SwitchAccountLoaded(this.accountsList);

  @override
  List<Object> get props => [accountsList];
}

final class SwitchAccountError extends SwitchAccountState {
  final String message;

  const SwitchAccountError(this.message);

  @override
  List<Object> get props => [message];
}
