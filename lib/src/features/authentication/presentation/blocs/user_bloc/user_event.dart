part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();
}

final class UserStarted extends UserEvent {
  @override
  List<Object> get props => [];
}

final class UserSignInEvent extends UserEvent {
  final String email;
  final String password;

  const UserSignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class UserSignUpEvent extends UserEvent {
  final UserSignUpDetailsEntity userDetailsEntity;

  const UserSignUpEvent({required this.userDetailsEntity});

  @override
  List<Object> get props => [userDetailsEntity];
}

final class UserSignOutEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

final class UserRecoverPasswordEvent extends UserEvent {
  final String email;

  const UserRecoverPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

final class UserDeleteUserEvent extends UserEvent {
  @override
  List<Object> get props => [];
}

final class UserErrorEvent extends UserEvent {
  final String message;
  const UserErrorEvent({required this.message});
  @override
  List<Object?> get props => [message];
}
