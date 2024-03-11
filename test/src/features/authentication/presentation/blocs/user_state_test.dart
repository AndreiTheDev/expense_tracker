import 'package:expense_tracker_app_bloc/src/features/authentication/presentation/blocs/user_bloc/user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('UserError initializes with right value', () {
    const sut = UserError('test');

    expect(sut, const UserError('test'));
  });
}
