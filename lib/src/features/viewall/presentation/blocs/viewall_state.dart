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
  final IncomesDetailsEntity? incomesDetails;
  final ExpensesDetailsEntity? expensesDetails;

  const ViewallLoaded({
    this.incomesDetails,
    this.expensesDetails,
  });

  ViewallLoaded copyWith({
    final IncomesDetailsEntity? incomesDetails,
    final ExpensesDetailsEntity? expensesDetails,
  }) {
    return ViewallLoaded(
      incomesDetails: incomesDetails ?? this.incomesDetails,
      expensesDetails: expensesDetails ?? this.expensesDetails,
    );
  }

  @override
  List<Object?> get props => [incomesDetails, expensesDetails];
}

final class ViewallError extends ViewallState {
  final String message;

  const ViewallError(this.message);

  @override
  List<Object> get props => [message];
}
