part of 'viewall_bloc.dart';

sealed class ViewallEvent extends Equatable {
  const ViewallEvent();

  @override
  List<Object> get props => [];
}

class ViewallDeleteExpenseEvent extends ViewallEvent {}

class ViewallDeleteIncomeEvent extends ViewallEvent {}

class ViewallDeleteFetchExpensesEvent extends ViewallEvent {}

class ViewallDeleteFetchIncomesEvent extends ViewallEvent {}
