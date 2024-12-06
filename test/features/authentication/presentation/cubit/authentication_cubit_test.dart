import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/errors/failure.dart';
import 'package:tdd_app/features/authentication/domain/usecase/create_user.dart';
import 'package:tdd_app/features/authentication/domain/usecase/get_users.dart';
import 'package:tdd_app/features/authentication/presentation/cubit/authentication_cubit.dart';

class MockCreateUser extends Mock implements CreateUser {}

class MockGetUsers extends Mock implements GetUsers {}

void main() {
  late CreateUser createUser;
  late GetUsers getUsers;
  late AuthenticationCubit cubit;

  const tCreateUserParams = CreateUserParams.empty();
  const tApiFailure = ApiFailure(message: "message", statusCode: 400);

  setUp(() {
    createUser = MockCreateUser();
    getUsers = MockGetUsers();
    cubit = AuthenticationCubit(
      createUser: createUser,
      getUsers: getUsers,
    );

    registerFallbackValue(tCreateUserParams);
  });

  tearDown(() => cubit.close());

  test("initial state should be [AuthenticationInitialState]", () async {
    expect(cubit.state, AuthenticationInitial());
  });

  group("createUser", () {
    blocTest<AuthenticationCubit, AuthenticationState>(
      "should emit [CreatingUser and UserCreated] when successful",
      build: () {
        when(
          () => createUser(
            any(),
          ),
        ).thenAnswer(
          (_) async => const Right(null),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        name: tCreateUserParams.name,
        createdAt: tCreateUserParams.createdAt,
        avatar: tCreateUserParams.avatar,
      ),
      // act: (bloc) => bloc.add(CreateUserEvent(name: "name", createdAt: "createdAt", avatar: "avatar")),
      expect: () => const [CreatingUser(), UserCreated()],
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );

    blocTest(
      "should emit [CreatingUser, AuthenticationError] when unsuccessfull",
      build: () {
        when(() => createUser(any())).thenAnswer(
          (_) async => const Left(tApiFailure),
        );
        return cubit;
      },
      act: (cubit) => cubit.createUser(
        name: tCreateUserParams.name,
        createdAt: tCreateUserParams.createdAt,
        avatar: tCreateUserParams.avatar,
      ),
      expect: () => [
        const CreatingUser(),
        AuthenticationError(tApiFailure.errorMessage),
      ],
      verify: (_) {
        verify(() => createUser(tCreateUserParams)).called(1);
        verifyNoMoreInteractions(createUser);
      },
    );
  });

  group("getUsers", () async {
    blocTest<AuthenticationCubit, AuthenticationState>(
        "should emit [GettingUser, UserLoaded] when successfull",
        build: () {
          when(() => getUsers()).thenAnswer(
            (_) async => const Right(
              [],
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => const [GettingUser(), UserLoaded([])],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
        "should emit [GettingUser, AuthenticationError] when unsuccessfull",
        build: () {
          when(() => getUsers()).thenAnswer(
            (_) async => const Left(tApiFailure),
          );
          return cubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => [
              const GettingUser(),
              AuthenticationError(tApiFailure.errorMessage)
            ],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });
}
