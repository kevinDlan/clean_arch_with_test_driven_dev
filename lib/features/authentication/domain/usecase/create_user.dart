import 'package:equatable/equatable.dart';
import 'package:tdd_app/core/usecase/usecase.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/features/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UsecaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _authenticationRepository;

  const CreateUser(this._authenticationRepository);

  // ResultVoid createUser({
  //   required String name,
  //   required String createdAt,
  //   required String avatar,
  // }) =>
  //     _authenticationRepository.createUser(
  //       name: name,
  //       createdAt: createdAt,
  //       avatar: avatar,
  //     );

  @override
  ResultVoid call(CreateUserParams params) =>
      _authenticationRepository.createUser(
        name: params.name,
        createdAt: params.createdAt,
        avatar: params.avatar,
      );
}

class CreateUserParams extends Equatable {
  final String name;
  final String createdAt;
  final String avatar;

  const CreateUserParams({
    required this.name,
    required this.createdAt,
    required this.avatar,
  });

  const CreateUserParams.empty()
      : this(
            name: "_empty.name",
            createdAt: "_empty.createdAt",
            avatar: "_empty.avatar");

  @override
  List<Object?> get props => [name, createdAt, avatar];
}
