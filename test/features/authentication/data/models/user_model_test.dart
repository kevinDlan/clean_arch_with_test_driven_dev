import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_app/features/authentication/data/models/user_model.dart';
import 'package:tdd_app/features/authentication/domain/entities/user.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tModel = UserModel.empty();
  test("should be a subclass of [User] entity", () {
    // Arrage
    // Act
    //  Assert
    expect(tModel, isA<User>());
  });

  final tJson = fixture("user.json");
  final tMap = jsonDecode(tJson);
  group("fromMap", () {
    test("Should return a [UserModel] with the right data", () {
      //  Arrange
      final result = UserModel.fromMap(tMap);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group("fromJson", () {
    test("Should return a [UserModel] with the right data", () {
      //  Arrange
      final result = UserModel.fromJson(tJson);

      // Assert
      expect(result, equals(tModel));
    });
  });

  group("toMap", () {
    test("Should return a [Map] with the right data", () {
      //  Arrange
      final result = tModel.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group("toJson", () {
    test("should return a [Json] string with the right data", () {
      //  Arrange
      final result = tModel.toJson();
      // Assert
      expect(result, equals(jsonEncode(jsonDecode(tJson))));
    });
  });

  group("copyWith", () {
    test("should return a [UserModel] with different data", () {
      // Arrange

      // Act
      final result = tModel.copyWith(name: "Mike Tyson");

      // Assert
      expect(result.name, equals("Mike Tyson"));
    });
  });
}
