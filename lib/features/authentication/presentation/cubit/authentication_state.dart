part of 'authentication_cubit.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

final class AuthenticationInitial extends AuthenticationState {}

final class CreatingUser extends AuthenticationState {
  const CreatingUser();
}

final class GettingUser extends AuthenticationState {
  const GettingUser();
}

final class UserCreated extends AuthenticationState {
  const UserCreated();
}

final class UserLoaded extends AuthenticationState {
  final List<User> users;

  const UserLoaded(this.users);

  @override
  List<Object> get props => users.map((user) => user.id).toList();
}

class AuthenticationError extends AuthenticationState {
  final String message;

  const AuthenticationError(this.message);

  @override
  List<String> get props => [message];
}
