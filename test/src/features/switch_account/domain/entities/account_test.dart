import 'package:expense_tracker_app_bloc/src/features/switch_account/domain/entities/account.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late AccountEntity sut;
  setUp(() {
    sut = AccountEntity(
      name: 'name',
      createdBy: 'createdBy',
      owner: 'owner',
      id: 'id',
    );
  });

  test('AccountEntity props are equal', () {
    expect(sut.props, ['id', 'name', 0, 'owner', 'createdBy', 0, 0, []]);
  });

  test('Id field gets initialized with uuid string', () {
    final sut = AccountEntity(
      name: 'name',
      createdBy: 'createdBy',
      owner: 'owner',
    );
    expect(sut.id, isA<String>());
    expect(sut.id.length, inInclusiveRange(32, 36));
  });
}
