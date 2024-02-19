part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

final class UserStarted extends UserEvent {}

final class UserSignInEvent extends UserEvent {
  final String email;
  final String password;

  const UserSignInEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

final class UserSignUpEvent extends UserEvent {
  final UserDetailsEntity userDetailsEntity;

  const UserSignUpEvent({required this.userDetailsEntity});

  @override
  List<Object> get props => [userDetailsEntity];
}

final class UserSignOutEvent extends UserEvent {}

final class UserRecoverPasswordEvent extends UserEvent {
  final String email;

  const UserRecoverPasswordEvent({required this.email});

  @override
  List<Object> get props => [email];
}

final class UserDeleteUserEvent extends UserEvent {}
