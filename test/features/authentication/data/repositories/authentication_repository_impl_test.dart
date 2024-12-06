import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/errors/failure.dart';
import 'package:tdd_app/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_app/features/authentication/data/models/user_model.dart';
import 'package:tdd_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_app/features/authentication/domain/entities/user.dart';

class MockAuthRemoteDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource authenticationRemoteDataSource;
  late AuthenticationRepositoryImpl authenticationRepositoryImpl;
  setUp(() {
    authenticationRemoteDataSource = MockAuthRemoteDataSource();
    authenticationRepositoryImpl =
        AuthenticationRepositoryImpl(authenticationRemoteDataSource);
  });

  const tException = APIException(
    message: "Unknown errors occurred",
    statusCode: 500,
  );

  group("createUser", () {
    const String createdAt = "createdAt";
    const String name = "name";
    const String avatar = "avatar";

    test(
      "should call the [RemoteDataSource.createUser] and complete successfully "
      "when the call to the remote source is successful",
      () async {
        // Arrange
        when(
          () => authenticationRemoteDataSource.createUser(
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt'),
            avatar: any(named: 'avatar'),
          ),
        ).thenAnswer((_) async => Future.value());

        //Act
        final result = await authenticationRepositoryImpl.createUser(
            name: name, createdAt: createdAt, avatar: avatar);

        //Assert
        expect(result, equals(const Right(null)));
        verify(() => authenticationRemoteDataSource.createUser(
            name: name, createdAt: createdAt, avatar: avatar)).called(1);

        verifyNoMoreInteractions(authenticationRemoteDataSource);
      },
    );

    test(
      "should return a [ApiFailure] when the call to the remote "
      "server is unsuccessfull",
      () async {
        // Arrange
        when(
          () => authenticationRemoteDataSource.createUser(
            name: any(named: 'name'),
            createdAt: any(named: 'createdAt'),
            avatar: any(named: 'avatar'),
          ),
        ).thenThrow(
          tException,
        );

        // Act
        final result = await authenticationRepositoryImpl.createUser(
          name: name,
          createdAt: createdAt,
          avatar: avatar,
        );

        // Assert
        expect(
          result,
          equals(
            Left(
              ApiFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );

        verify(() => authenticationRemoteDataSource.createUser(
            name: name, createdAt: createdAt, avatar: avatar)).called(1);

        verifyNoMoreInteractions(authenticationRemoteDataSource);
      },
    );
  });

  group("getUsers", () async {
    const expectedUsers = [UserModel.empty()];
    test(
      "should the [RemoteDataSource.getUsers] and return [List<User>] when call the remote source is successfuly",
      () async {
        //  Arrange
        when(
          () => authenticationRemoteDataSource.getUser(),
        ).thenAnswer(
          (_) async => expectedUsers,
        );
        // Act
        final result = await authenticationRemoteDataSource.getUser();

        // Assert
        expect(result, isA<Right<dynamic, List<User>>>());

        verify(() => authenticationRemoteDataSource.getUser()).called(1);

        verifyNoMoreInteractions(authenticationRemoteDataSource);
      },
    );

    test(
      "should return a [ApiFailure] when the call to the remote "
      "server is unsuccessfull",
      () async {
        when(() => authenticationRemoteDataSource.getUser())
            .thenThrow(tException);

        final result = await authenticationRemoteDataSource.getUser();

        expect(
          result,
          equals(
            Left(
              ApiFailure(
                message: tException.message,
                statusCode: tException.statusCode,
              ),
            ),
          ),
        );

        verify(() => authenticationRemoteDataSource.getUser()).called(1);

        verifyNoMoreInteractions(authenticationRemoteDataSource);
      },
    );
  });
}
