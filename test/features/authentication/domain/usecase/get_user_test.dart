import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/features/authentication/domain/entities/user.dart';
import 'package:tdd_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_app/features/authentication/domain/usecase/get_users.dart';

import 'authentication_repository.mock.dart';

void main() {
  late AuthenticationRepository authenticationRepository;
  late GetUsers usercase;

  setUp(() {
    authenticationRepository = MockAuthRepo();
    usercase = GetUsers(authenticationRepository);
  });

  const tResponse = [User.empty()];

  test("Should call [AuthRepo.getUser] and return [List<Users>]", () async {
    // Arrange
    when(() => authenticationRepository.getUsers())
        .thenAnswer((_) async => const Right(tResponse));

    //Act
    final result = await usercase();

    // Assert
    expect(result, equals(const Right<dynamic, List<User>>(tResponse)));
    verify(() => authenticationRepository.getUsers()).called(1);

    verifyNoMoreInteractions(authenticationRepository);
  });
}
