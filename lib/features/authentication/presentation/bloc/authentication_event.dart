part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class CreateUserEvent extends AuthenticationEvent {
  final String name;
  final String createdAt;
  final String avatar;

  const CreateUserEvent({
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  @override
  List<Object> get props => [
        name,
        createdAt,
        avatar,
      ];
}

class GetUserEvent extends AuthenticationEvent {
  const GetUserEvent();
}
