import 'package:tdd_app/core/usecase/usecase.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/features/authentication/domain/entities/user.dart';
import 'package:tdd_app/features/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UsecaseWithoutParams<List<User>> {
  final AuthenticationRepository _authenticationRepository;

  const GetUsers(this._authenticationRepository);

  @override
  ResultFuture<List<User>> call() => _authenticationRepository.getUsers();
}
