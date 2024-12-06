import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_app/features/authentication/domain/usecase/create_user.dart';
import 'package:tdd_app/features/authentication/domain/usecase/get_users.dart';

import '../../domain/entities/user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit({
    required CreateUser createUser,
    required GetUsers getUsers,
  })  : _createUser = createUser,
        _getUser = getUsers,
        super(AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUser;

  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  }) async {
    emit(const CreatingUser());

    final result = await _createUser(
      CreateUserParams(
        name: name,
        createdAt: createdAt,
        avatar: avatar,
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

  Future<void> getUsers() async {
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
