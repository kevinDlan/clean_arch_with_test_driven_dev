import 'dart:convert';

import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.name,
      required super.createdAt,
      required super.avatar});

  DataMap toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'avatar': avatar,
      'createdAt': createdAt,
    };
  }

  String toJson() => jsonEncode(toMap());

  factory UserModel.fromMap(DataMap map) {
    return UserModel(
      id: map['id'] as int,
      name: map['name'] as String,
      avatar: map['avatar'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

  const UserModel.empty()
      : this(
            id: 1,
            name: "_empty.name",
            createdAt: "_empty.createdAt",
            avatar: "_empty.avatar");

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  // UserModel.fromMap(DataMap map)
  //     : this(
  //         id: map['id'] as int,
  //         name: map['name'] as String,
  //         createdAt: map['createdAt'] as String,
  //         avatar: map['avatar'] as String,
  //       );

  UserModel copyWith({
    int? id,
    String? name,
    String? avatar,
    String? createdAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
