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
}

final class UserSignUpEvent extends UserEvent {}

final class UserSignOutEvent extends UserEvent {}

final class UserRecoverPasswordEvent extends UserEvent {
  final String email;

  const UserRecoverPasswordEvent({required this.email});
}

final class UserDeleteUserEvent extends UserEvent {}
