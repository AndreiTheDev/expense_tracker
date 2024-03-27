part of 'viewall_bloc.dart';

sealed class ViewallState extends Equatable {
  const ViewallState();
}

final class ViewallInitial extends ViewallState {
  @override
  List<Object> get props => [];
}

final class ViewallLoading extends ViewallState {
  @override
  List<Object> get props => [];
}

final class ViewallLoaded extends ViewallState {
  final List<IncomeEntity> incomesList;
  final List<ExpenseEntity> expensesList;

  const ViewallLoaded(this.incomesList, this.expensesList);

  @override
  List<Object> get props => [incomesList, expensesList];
}

final class ViewallError extends ViewallState {
  @override
  List<Object> get props => [];
}
