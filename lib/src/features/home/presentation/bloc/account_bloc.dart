import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/account.dart';
import '../../domain/entities/expense.dart';
import '../../domain/entities/income.dart';
import '../../domain/entities/transaction.dart';
import '../../domain/usecases/add_expense.dart';
import '../../domain/usecases/add_income.dart';
import '../../domain/usecases/delete_transaction.dart';
import '../../domain/usecases/fetch_account.dart';

part 'account_event.dart';
part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final FetchAccount _fetchAccount;
  final AddIncome _addIncome;
  final AddExpense _addExpense;
  final DeleteTransaction _deleteTransaction;
  AccountBloc({
    required FetchAccount fetchAccount,
    required AddIncome addIncome,
    required AddExpense addExpense,
    required DeleteTransaction deleteTransaction,
  })  : _fetchAccount = fetchAccount,
        _addIncome = addIncome,
        _addExpense = addExpense,
        _deleteTransaction = deleteTransaction,
        super(AccountLoading()) {
    on<AccountFetchEvent>(_accountFetchEvent);
    on<AccountAddIncomeEvent>(_accountAddIncomeEvent);
    on<AccountAddExpenseEvent>(_accountAddExpenseEvent);
    on<AccountDeleteTransactionEvent>(_accountDeleteTransactionEvent);
  }

  Future<void> _accountFetchEvent(
    final AccountFetchEvent event,
    final Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final repsponse = await _fetchAccount(
      accountId: event.accountId,
    );
    repsponse.fold(
      (failure) {
        emit(AccountError(failure.message));
      },
      (entity) => emit(AccountLoaded(entity)),
    );
  }

  Future<void> _accountAddIncomeEvent(
    final AccountAddIncomeEvent event,
    final Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final repsponse = await _addIncome(
      accountId: event.accountId,
      incomeEntity: event.incomeEntity,
    );
    repsponse.fold(
      (failure) {
        emit(AccountError(failure.message));
      },
      (entity) => emit(AccountLoaded(entity)),
    );
  }

  Future<void> _accountAddExpenseEvent(
    final AccountAddExpenseEvent event,
    final Emitter<AccountState> emit,
  ) async {
    emit(AccountLoading());
    final repsponse = await _addExpense(
      accountId: event.accountId,
      expenseEntity: event.expenseEntity,
    );
    repsponse.fold(
      (failure) {
        emit(AccountError(failure.message));
      },
      (entity) => emit(AccountLoaded(entity)),
    );
  }

  Future<void> _accountDeleteTransactionEvent(
    final AccountDeleteTransactionEvent event,
    final Emitter<AccountState> emit,
  ) async {
    final repsponse = await _deleteTransaction(
      accountId: event.accountId,
      transactionEntity: event.transactionEntity,
    );
    repsponse.fold(
      (failure) {
        emit(AccountError(failure.message));
      },
      (entity) => emit(AccountLoaded(entity)),
    );
  }
}
