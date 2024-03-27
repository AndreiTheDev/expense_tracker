import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/expense.dart';
import '../../domain/entities/income.dart';

part 'viewall_event.dart';
part 'viewall_state.dart';

class ViewallBloc extends Bloc<ViewallEvent, ViewallState> {
  ViewallBloc() : super(ViewallInitial()) {
    on<ViewallEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
