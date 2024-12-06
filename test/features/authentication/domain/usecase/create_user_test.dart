// What does the class depend on ?
// How can we create the fake version of that dependency ?
// --> Use packages like Mocktail to do that
// How do we control what our dependencies do ?
// --> Using the mocktail's API

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_app/features/authentication/domain/usecase/create_user.dart';
import 'authentication_repository.mock.dart';

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  const CreateUserParams params = CreateUserParams.empty();

  test("Should call the [AuthRepo.createUser]", () async {
    // Arrange
    // STUB
    when(
      () => repository.createUser(
          name: any(named: "name"),
          createdAt: any(named: "createdAt"),
          avatar: any(named: "avatar")),
    ).thenAnswer((_) async => const Right(null));
    // Act
    final result = await usecase.call(params);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(
      () => repository.createUser(
        name: params.name,
        createdAt: params.createdAt,
        avatar: params.avatar,
      ),
    ).called(1);

    verifyNoMoreInteractions(repository);
  });
}
