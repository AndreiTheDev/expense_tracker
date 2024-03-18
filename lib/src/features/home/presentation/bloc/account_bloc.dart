import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

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
    on<AccountFetchEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AccountAddIncomeEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AccountAddExpenseEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AccountDeleteTransactionEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
