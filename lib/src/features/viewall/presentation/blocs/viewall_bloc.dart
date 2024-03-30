import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/expense.dart';
import '../../domain/entities/expenses_details.dart';
import '../../domain/entities/income.dart';
import '../../domain/entities/incomes_details.dart';
import '../../domain/usecases/delete_expense.dart';
import '../../domain/usecases/delete_income.dart';
import '../../domain/usecases/fetch_expenses_details.dart';
import '../../domain/usecases/fetch_incomes_details.dart';

part 'viewall_event.dart';
part 'viewall_state.dart';

class ViewallBloc extends Bloc<ViewallEvent, ViewallState> {
  final DeleteExpense _deleteExpense;
  final DeleteIncome _deleteIncome;
  final FetchExpensesDetails _fetchExpensesDetails;
  final FetchIncomesDetails _fetchIncomesDetails;
  ViewallBloc({
    required DeleteExpense deleteExpense,
    required DeleteIncome deleteIncome,
    required FetchExpensesDetails fetchExpensesDetails,
    required FetchIncomesDetails fetchIncomesDetails,
  })  : _deleteExpense = deleteExpense,
        _deleteIncome = deleteIncome,
        _fetchExpensesDetails = fetchExpensesDetails,
        _fetchIncomesDetails = fetchIncomesDetails,
        super(ViewallInitial()) {
    on<ViewallDeleteExpenseEvent>(_viewallDeleteExpenseEvent);
    on<ViewallDeleteIncomeEvent>(_viewallDeleteIncomeEvent);
    on<ViewallFetchExpensesDetailsEvent>(_viewallFetchExpensesDetailsEvent);
    on<ViewallFetchIncomesDetailsEvent>(_viewallFetchIncomesDetailsEvent);
  }

  Future<void> _viewallDeleteExpenseEvent(
    final ViewallDeleteExpenseEvent event,
    final Emitter<ViewallState> emit,
  ) async {
    final currentState = state;
    final response = await _deleteExpense(
      accountId: event.accountId,
      expenseEntity: event.expenseEntity,
    );
    response.fold((l) => null, (r) {
      if (currentState is ViewallLoaded) {
        emit(currentState.copyWith(expensesDetails: r));
      } else {
        emit(ViewallLoaded(expensesDetails: r));
      }
    });
  }

  Future<void> _viewallDeleteIncomeEvent(
    final ViewallDeleteIncomeEvent event,
    final Emitter<ViewallState> emit,
  ) async {
    final currentState = state;
    final response = await _deleteIncome(
      accountId: event.accountId,
      incomeEntity: event.incomeEntity,
    );
    response.fold((l) => null, (r) {
      if (currentState is ViewallLoaded) {
        emit(currentState.copyWith(incomesDetails: r));
      } else {
        emit(ViewallLoaded(incomesDetails: r));
      }
    });
  }

  Future<void> _viewallFetchExpensesDetailsEvent(
    final ViewallFetchExpensesDetailsEvent event,
    final Emitter<ViewallState> emit,
  ) async {
    final currentState = state;
    final response = await _fetchExpensesDetails(
      accountId: event.accountId,
    );
    response.fold((l) => null, (r) {
      if (currentState is ViewallLoaded) {
        emit(currentState.copyWith(expensesDetails: r));
      } else {
        emit(ViewallLoaded(expensesDetails: r));
      }
    });
  }

  Future<void> _viewallFetchIncomesDetailsEvent(
    final ViewallFetchIncomesDetailsEvent event,
    final Emitter<ViewallState> emit,
  ) async {
    final currentState = state;
    final response = await _fetchIncomesDetails(
      accountId: event.accountId,
    );
    response.fold((l) => null, (r) {
      if (currentState is ViewallLoaded) {
        emit(currentState.copyWith(incomesDetails: r));
      } else {
        emit(ViewallLoaded(incomesDetails: r));
      }
    });
  }
}
