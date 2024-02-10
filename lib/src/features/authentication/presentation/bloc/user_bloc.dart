import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/is_signed_in_user.dart';
import '../../domain/usecases/sign_in_user.dart';
import '../../domain/usecases/sign_out_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final IsSignedInUser _isSignedInUser;
  final SignInUser _signInUser;
  final SignOutUser _signOutUser;
  UserBloc({
    required IsSignedInUser isSignedInUser,
    required SignInUser signInUser,
    required SignOutUser signOutUser,
  })  : _isSignedInUser = isSignedInUser,
        _signInUser = signInUser,
        _signOutUser = signOutUser,
        super(UserLoading()) {
    on<UserStarted>((event, emit) async {
      emit(UserLoading());
      final response = await _isSignedInUser();
      response.fold((left) => emit(UserError(left.message)), (right) {
        if (right != null) {
          emit(UserAuthenticated(right));
        } else {
          emit(UserUnauthenticated());
        }
      });
    });
    on<UserSignInEvent>((event, emit) async {
      emit(UserLoading());
      final response = await _signInUser(event.email, event.password);
      response.fold((l) => emit(UserError(l.message)), (right) {
        emit(UserAuthenticated(right));
      });
    });
    on<UserSignOutEvent>((event, emit) async {
      final response = await _signOutUser();
      response.fold(
        (l) => emit(UserError(l.message)),
        (r) => emit(UserUnauthenticated()),
      );
    });
  }
}
