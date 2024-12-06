import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/features/authentication/domain/entities/user.dart';

abstract interface class AuthenticationRepository {
  const AuthenticationRepository();

  ResultVoid createUser({
    required String name,
    required String createdAt,
    required String avatar,
  });

  ResultFuture<List<User>> getUsers();
}
