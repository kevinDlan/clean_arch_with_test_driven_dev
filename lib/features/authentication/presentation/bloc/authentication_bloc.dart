import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app/features/authentication/domain/entities/user.dart';
import 'package:tdd_app/features/authentication/domain/usecase/create_user.dart';
import 'package:tdd_app/features/authentication/domain/usecase/get_users.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    required CreateUser createUser,
    required GetUsers getUser,
  })  : _createUser = createUser,
        _getUser = getUser,
        super(
          const AuthenticationInitial(),
        ) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUserHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUser;

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        name: event.name,
        createdAt: event.createdAt,
        avatar: event.avatar,
      ),
    );

    result.fold(
      (failure) => emit(
        AuthenticationError(
          failure.errorMessage,
        ),
      ),
      (_) => emit(
        const UserCreated(),
      ),
    );
  }

  Future<void> _getUserHandler(
      GetUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUser());

    final result = await _getUser();

    result.fold(
      (failure) => emit(AuthenticationError(failure.errorMessage)),
      (users) => emit(
        UserLoaded(users),
      ),
    );
  }
}
