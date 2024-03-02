import 'package:bloc_presentation/bloc_presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/entities/user_signup_details.dart';
import '../../../domain/usecases/delete_user.dart';
import '../../../domain/usecases/is_signed_in_user.dart';
import '../../../domain/usecases/recover_password.dart';
import '../../../domain/usecases/sign_in_user.dart';
import '../../../domain/usecases/sign_out_user.dart';
import '../../../domain/usecases/sign_up_user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState>
    with BlocPresentationMixin<UserState, UserEvent> {
  final IsSignedInUser _isSignedInUser;
  final SignInUser _signInUser;
  final SignUpUser _signUpUser;
  final SignOutUser _signOutUser;
  final RecoverPassword _recoverPassword;
  final DeleteUser _deleteUser;
  UserBloc({
    required IsSignedInUser isSignedInUser,
    required SignInUser signInUser,
    required SignUpUser signUpUser,
    required SignOutUser signOutUser,
    required RecoverPassword recoverPassword,
    required DeleteUser deleteUser,
  })  : _isSignedInUser = isSignedInUser,
        _signInUser = signInUser,
        _signUpUser = signUpUser,
        _signOutUser = signOutUser,
        _recoverPassword = recoverPassword,
        _deleteUser = deleteUser,
        super(UserLoading()) {
    on<UserStarted>(_userStarted);
    on<UserSignInEvent>(_userSignIn);
    on<UserSignUpEvent>(_userSignUp);
    on<UserSignOutEvent>(_userSignOut);
    on<UserRecoverPasswordEvent>(_userRecoverPassword);
    on<UserDeleteUserEvent>(_userDeleteUser);
  }

  Future<void> _userStarted(
    final UserStarted event,
    final Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final response = await _isSignedInUser();
    response.fold((left) {
      emitPresentation(UserErrorEvent(message: left.message));
      emit(UserUnauthenticated());
    }, (right) {
      if (right != null) {
        emit(UserAuthenticated(right));
      } else {
        emit(UserUnauthenticated());
      }
    });
  }

  Future<void> _userSignIn(
      final UserSignInEvent event, final Emitter<UserState> emit) async {
    emit(UserLoading());
    final response = await _signInUser(event.email, event.password);
    response.fold((left) {
      emitPresentation(UserErrorEvent(message: left.message));
      emit(UserUnauthenticated());
    }, (right) {
      emit(UserAuthenticated(right));
    });
  }

  Future<void> _userSignUp(
    final UserSignUpEvent event,
    final Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final response = await _signUpUser(event.userDetailsEntity);
    response.fold(
      (left) {
        emitPresentation(UserErrorEvent(message: left.message));
        emit(UserUnauthenticated());
      },
      (right) => emit(UserAuthenticated(right)),
    );
  }

  Future<void> _userSignOut(
    final UserSignOutEvent event,
    final Emitter<UserState> emit,
  ) async {
    final response = await _signOutUser();
    response.fold(
      (left) => emitPresentation(UserErrorEvent(message: left.message)),
      (right) => emit(UserUnauthenticated()),
    );
  }

  Future<void> _userRecoverPassword(
    final UserRecoverPasswordEvent event,
    final Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final response = await _recoverPassword(event.email);
    response.fold(
      (left) {
        emitPresentation(UserErrorEvent(message: left.message));
        emit(UserUnauthenticated());
      },
      (right) => emit(UserUnauthenticated()),
    );
  }

  Future<void> _userDeleteUser(
    final UserDeleteUserEvent event,
    final Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    final response = await _deleteUser();
    response.fold(
      (left) => emitPresentation(UserErrorEvent(message: left.message)),
      (right) => emit(UserUnauthenticated()),
    );
  }
}
