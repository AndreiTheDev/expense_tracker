import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/entities/account.dart';

import 'package:expense_tracker_app_bloc/src/features/switch_account/presentation/cubit/add_account_form_cubit.dart';
import 'package:expense_tracker_app_bloc/src/features/switch_account/presentation/models/name.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AddAccountFormState sut;

  setUp(() {
    sut = const AddAccountFormState(
      name: Name.dirty(value: 'test'),
    );
  });

  test(
    'AddAccountFormState toAccountEntity returns an account entity',
    () {
      final response = sut.toAccountEntity('testUid', 'testUsername');
      expect(response, isA<AccountEntity>());
    },
  );

  test(
    'AddAccountFormState copyWith updates right fields',
    () {
      final nameResponse = sut.copyWith(name: const Name.dirty(value: 'teest'));
      expect(nameResponse.name, const Name.dirty(value: 'teest'));
      final isValidResponse = sut.copyWith(isValid: true);
      expect(isValidResponse.isValid, true);
    },
  );
}
