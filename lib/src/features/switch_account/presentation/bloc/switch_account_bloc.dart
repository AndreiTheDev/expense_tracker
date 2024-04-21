import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/account.dart';
import '../../domain/usecases/create_new_account.dart';
import '../../domain/usecases/fetch_accounts_list.dart';

part 'switch_account_event.dart';
part 'switch_account_state.dart';

class SwitchAccountBloc extends Bloc<SwitchAccountEvent, SwitchAccountState> {
  final CreateNewAccount _createNewAccount;
  final FetchAccountsList _fetchAccountsList;
  SwitchAccountBloc({
    required CreateNewAccount createNewAccount,
    required FetchAccountsList fetchAccountsList,
  })  : _createNewAccount = createNewAccount,
        _fetchAccountsList = fetchAccountsList,
        super(SwitchAccountLoading()) {
    on<SwitchAccountFetchAccountsEvent>(_onSwitchAccountFetchAccountsEvent);
    on<SwtichAccountCreateAccountEvent>(_onSwitchAccountCreateAccountEvent);
  }

  Future<void> _onSwitchAccountFetchAccountsEvent(
    SwitchAccountFetchAccountsEvent event,
    Emitter<SwitchAccountState> emit,
  ) async {
    emit(SwitchAccountLoading());
    final response = await _fetchAccountsList();
    response.fold(
      (error) => emit(SwitchAccountError(error.message)),
      (accountsList) => emit(SwitchAccountLoaded(accountsList)),
    );
  }

  Future<void> _onSwitchAccountCreateAccountEvent(
    SwtichAccountCreateAccountEvent event,
    Emitter<SwitchAccountState> emit,
  ) async {
    emit(SwitchAccountLoading());
    final createResponse =
        await _createNewAccount(account: event.accountEntity);
    createResponse.fold(
      (error) => emit(SwitchAccountError(error.message)),
      (r) => null,
    );
    if (createResponse.isLeft()) {
      return;
    }
    final fetchResponse = await _fetchAccountsList();
    fetchResponse.fold(
      (error) => emit(SwitchAccountError(error.message)),
      (accountsList) => emit(SwitchAccountLoaded(accountsList)),
    );
  }
}
