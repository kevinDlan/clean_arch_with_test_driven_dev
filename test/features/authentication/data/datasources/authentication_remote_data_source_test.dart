import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/utils/constants.dart';
import 'package:tdd_app/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_app/features/authentication/data/models/user_model.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthRemoteDataSrcImpl authenticationRemoteDataSource;

  setUp(() {
    client = MockClient();
    authenticationRemoteDataSource = AuthRemoteDataSrcImpl(client);
    registerFallbackValue(Uri());
  });

  const String tExceptionErrorMessage = "Invalid email addres";
  group("createUser", () {
    test(
      "should complete successfully when the status code is 200 or 201",
      () async {
        // Stub
        when(
          () => client.post(
            any(),
            body: any(named: 'body'),
          ),
        ).thenAnswer(
          (_) async => http.Response(
            'user created successfully',
            201,
          ),
        );

        // Act
        final methodCall = authenticationRemoteDataSource.createUser;

        // Assert
        expect(
            methodCall(
              name: 'name',
              createdAt: 'createdAt',
              avatar: 'avatar',
            ),
            completes);

        verify(
          () => client.post(
            Uri.parse(kBaseUrl + kUserResourceEndPoint),
            body: jsonEncode({
              "name": "name",
              "createdAt": "createdAt",
              "avatar": "avatar",
            }),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test("should throw [APIException] when the status code is not 200 or 201",
        () async {
      // Arrange
      when(
        () => client.post(
          any(),
          body: any(
            named: "body",
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          tExceptionErrorMessage,
          400,
        ),
      );

      // Act
      final methodCall = authenticationRemoteDataSource.createUser;

      // Assert
      expect(
        () => methodCall(
          name: 'name',
          createdAt: 'createdAt',
          avatar: 'avatar',
        ),
        throwsA(
          APIException(
            message: tExceptionErrorMessage,
            statusCode: 400,
          ),
        ),
      );

      verify(
        () => client.post(
          Uri.parse("$kBaseUrl/users"),
          body: jsonEncode({
            "name": "name",
            "createdAt": "createdAt",
            "avatar": "avatar",
          }),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });

  group("getUser", () {
    const List<UserModel> tUsers = [UserModel.empty()];
    test(
      "should return [List<UserModel>] when the status code is 200",
      () async {
        // Arrange
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(
            jsonEncode([tUsers.first.toMap()]),
            200,
          ),
        );

        // Act
        final result = await authenticationRemoteDataSource.getUser();

        // Assert
        expect(result, equals(tUsers));
        verify(
          () => client.get(
            Uri.parse(kBaseUrl + kUserResourceEndPoint),
          ),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test("should throw [APIException] when the status code is not 200",
        () async {
      const tMessage = "Server down, Server down";

      when(() => client.get(any())).thenAnswer(
        (_) async => http.Response(
          tMessage,
          500,
        ),
      );

      final methodeCall = authenticationRemoteDataSource.getUser;

      expect(
        methodeCall(),
        throwsA(
          const APIException(
            message: tMessage,
            statusCode: 500,
          ),
        ),
      );

      verify(
        () => client.get(
          Uri.parse(kBaseUrl + kUserResourceEndPoint),
        ),
      ).called(1);

      verifyNoMoreInteractions(client);
    });
  });
}
