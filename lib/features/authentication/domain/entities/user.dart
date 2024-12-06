import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String avatar;
  final String createdAt;

  const User({
    required this.id,
    required this.name,
    required this.avatar,
    required this.createdAt,
  });

  const User.empty()
      : this(
          id: 1,
          name: "_empty.name",
          createdAt: "_empty.createdAt",
          avatar: "_empty.avatar",
        );

  @override
  List<Object?> get props => [
        id,
        name,
        createdAt,
        avatar,
      ];
}
