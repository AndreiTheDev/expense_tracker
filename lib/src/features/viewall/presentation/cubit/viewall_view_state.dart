part of 'viewall_view_cubit.dart';

sealed class ViewallViewState extends Equatable {
  const ViewallViewState();

  @override
  List<Object> get props => [];
}

final class ViewallViewIncomes extends ViewallViewState {}

final class ViewallViewExpenses extends ViewallViewState {}
