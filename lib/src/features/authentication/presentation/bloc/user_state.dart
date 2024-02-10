part of 'user_bloc.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserUnauthenticated extends UserState {}

final class UserAuthenticated extends UserState {
  final UserEntity user;

  const UserAuthenticated(this.user);
}

final class UserLoading extends UserState {}

final class UserError extends UserState {
  final String message;

  const UserError(this.message);
}
