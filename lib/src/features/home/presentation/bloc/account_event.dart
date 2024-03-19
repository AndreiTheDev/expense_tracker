part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();

  @override
  List<Object> get props => [];
}

class AccountFetchEvent extends AccountEvent {
  final String accountId;

  const AccountFetchEvent({this.accountId = 'default'});

  @override
  List<Object> get props => [accountId];
}

class AccountAddIncomeEvent extends AccountEvent {
  final String accountId;
  final IncomeEntity incomeEntity;

  const AccountAddIncomeEvent({
    required this.incomeEntity,
    this.accountId = 'default',
  });

  @override
  List<Object> get props => [incomeEntity, accountId];
}

class AccountAddExpenseEvent extends AccountEvent {
  final String accountId;
  final ExpenseEntity expenseEntity;

  const AccountAddExpenseEvent({
    required this.expenseEntity,
    this.accountId = 'default',
  });

  @override
  List<Object> get props => [accountId, expenseEntity];
}

class AccountDeleteTransactionEvent extends AccountEvent {
  final String accountId;
  final TransactionEntity transactionEntity;

  const AccountDeleteTransactionEvent({
    required this.transactionEntity,
    this.accountId = 'default',
  });

  @override
  List<Object> get props => [accountId, transactionEntity];
}

class AccountErrorEvent extends AccountEvent {
  final String message;

  const AccountErrorEvent({required this.message});

  @override
  List<Object> get props => [message];
}
