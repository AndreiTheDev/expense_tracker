part of 'switch_account_bloc.dart';

sealed class SwitchAccountEvent extends Equatable {
  const SwitchAccountEvent();

  @override
  List<Object> get props => [];
}

class SwitchAccountFetchAccountsEvent extends SwitchAccountEvent {}

class SwtichAccountCreateAccountEvent extends SwitchAccountEvent {
  final AccountEntity accountEntity;

  const SwtichAccountCreateAccountEvent({required this.accountEntity});

  @override
  List<Object> get props => [accountEntity];
}
