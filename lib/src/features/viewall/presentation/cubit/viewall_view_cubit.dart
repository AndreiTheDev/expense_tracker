import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'viewall_view_state.dart';

class ViewallViewCubit extends Cubit<ViewallViewState> {
  ViewallViewCubit() : super(ViewallViewIncomes());

  void switchToIncomes() {
    emit(ViewallViewIncomes());
  }

  void switchToExpenses() {
    emit(ViewallViewExpenses());
  }
}
