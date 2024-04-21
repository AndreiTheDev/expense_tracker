import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/entities/account.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/presentation/bloc/switch_account_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final AccountEntity accountEntity =
      AccountEntity(name: 'name', createdBy: 'createdBy', owner: 'owner');

  test('SwtichAccountFetchAccountsEvent props are equal', () {
    final sut = SwitchAccountFetchAccountsEvent();
    expect(sut.props, []);
  });

  test('SwtichAccountCreateAccountEvent props are equal', () {
    final sut = SwtichAccountCreateAccountEvent(accountEntity: accountEntity);
    expect(sut.props, [accountEntity]);
  });
}
