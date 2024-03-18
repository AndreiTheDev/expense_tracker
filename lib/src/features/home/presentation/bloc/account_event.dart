part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountFetchEvent extends AccountEvent {}

class AccountAddIncomeEvent extends AccountEvent {}

class AccountAddExpenseEvent extends AccountEvent {}

class AccountDeleteTransactionEvent extends AccountEvent {}
