import 'package:expense_tracker_app_bloc/src/features/viewall/presentation/blocs/viewall_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ViewallInitial state props are equal', () {
    final sut = ViewallInitial();
    expect(sut.props, []);
  });

  test('ViewallLoading state props are equal', () {
    final sut = ViewallLoading();
    expect(sut.props, []);
  });

  test('ViewallError state props are equal', () {
    final sut = ViewallError();
    expect(sut.props, []);
  });
}
