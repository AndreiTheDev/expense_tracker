part of 'viewall_bloc.dart';

sealed class ViewallEvent extends Equatable {
  const ViewallEvent();
}

class ViewallDeleteExpenseEvent extends ViewallEvent {
  final String accountId;
  final ExpenseEntity expenseEntity;

  const ViewallDeleteExpenseEvent({
    required this.expenseEntity,
    this.accountId = 'default',
  });

  @override
  List<Object> get props => [accountId, expenseEntity];
}

class ViewallDeleteIncomeEvent extends ViewallEvent {
  final String accountId;
  final IncomeEntity incomeEntity;

  const ViewallDeleteIncomeEvent({
    required this.incomeEntity,
    this.accountId = 'default',
  });
  @override
  List<Object> get props => [accountId, incomeEntity];
}

class ViewallFetchExpensesDetailsEvent extends ViewallEvent {
  final String accountId;

  const ViewallFetchExpensesDetailsEvent({this.accountId = 'default'});
  @override
  List<Object> get props => [accountId];
}

class ViewallFetchIncomesDetailsEvent extends ViewallEvent {
  final String accountId;

  const ViewallFetchIncomesDetailsEvent({this.accountId = 'default'});
  @override
  List<Object> get props => [accountId];
}
