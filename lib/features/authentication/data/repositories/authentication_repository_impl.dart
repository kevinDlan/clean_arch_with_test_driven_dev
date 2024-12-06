import 'package:dartz/dartz.dart';
import 'package:tdd_app/core/utils/typedef.dart';
import 'package:tdd_app/features/authentication/data/datasources/authentication_remote_data_source.dart';

import 'package:tdd_app/features/authentication/domain/entities/user.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  AuthenticationRepositoryImpl(this._remoteDataSource);

  final AuthenticationRemoteDataSource _remoteDataSource;

  @override
  ResultVoid createUser(
      {required String name,
      required String createdAt,
      required String avatar}) async {
    try {
      await _remoteDataSource.createUser(
          name: name, createdAt: createdAt, avatar: avatar);

      return const Right(null);
    } on APIException catch (e) {
      return Left(
        ApiFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final users = await _remoteDataSource.getUser();
      return Right(users);
    } on APIException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
