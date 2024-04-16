part of 'account_bloc.dart';

sealed class AccountEvent extends Equatable {
  const AccountEvent();
}

class AccountFetchEvent extends AccountEvent {
  final String accountId;

  const AccountFetchEvent({this.accountId = 'default'});

  @override
  List<Object> get props => [accountId];
}

class AccountAddIncomeEvent extends AccountEvent {
  final IncomeEntity incomeEntity;

  const AccountAddIncomeEvent({
    required this.incomeEntity,
  });

  @override
  List<Object> get props => [incomeEntity];
}

class AccountAddExpenseEvent extends AccountEvent {
  final ExpenseEntity expenseEntity;

  const AccountAddExpenseEvent({
    required this.expenseEntity,
  });

  @override
  List<Object> get props => [expenseEntity];
}

class AccountDeleteTransactionEvent extends AccountEvent {
  final TransactionEntity transactionEntity;

  const AccountDeleteTransactionEvent({
    required this.transactionEntity,
  });

  @override
  List<Object> get props => [transactionEntity];
}
