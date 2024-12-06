import 'dart:convert';

import 'package:tdd_app/core/errors/exceptions.dart';
import 'package:tdd_app/core/utils/constants.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/features/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

abstract interface class AuthenticationRemoteDataSource {
  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  });

  Future<List<UserModel>> getUser();
}

class AuthRemoteDataSrcImpl implements AuthenticationRemoteDataSource {
  final http.Client _client;

  AuthRemoteDataSrcImpl(this._client);

  @override
  Future<void> createUser({
    required String name,
    required String createdAt,
    required String avatar,
  }) async {
    // 1. Check to make sure that it returns the right datas when the status code
    // is 200 or the proper response code
    // 2. Check to make sure that it "THROW A CUSTOM EXCEPTION" with the right message
    // when the status code is the bad one

    try {
      final response =
          await _client.post(Uri.parse(kBaseUrl + kUserResourceEndPoint),
              body: jsonEncode(
                {
                  "name": name,
                  "createdAt": createdAt,
                  "avatar": avatar,
                },
              ),
              headers: {
            "Content-Type": "application/json",
            // "Accept": "application/json"
          });

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }

  @override
  Future<List<UserModel>> getUser() async {
    try {
      final response =
          await _client.get(Uri.parse(kBaseUrl + kUserResourceEndPoint)
              // Uri.https(
              //   kBaseUrl,
              //   kUserResourceEndPoint,
              // ),
              );
      if (response.statusCode != 200) {
        throw APIException(
            message: response.body, statusCode: response.statusCode);
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map(
            (userData) => UserModel.fromMap(userData),
          )
          .toList();
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(message: e.toString(), statusCode: 505);
    }
  }
}
