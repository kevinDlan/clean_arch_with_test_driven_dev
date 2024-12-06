import 'package:get_it/get_it.dart';
import 'package:tdd_app/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_app/features/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_app/features/authentication/domain/usecase/create_user.dart';
import 'package:tdd_app/features/authentication/domain/usecase/get_users.dart';
import 'package:tdd_app/features/authentication/presentation/cubit/authentication_cubit.dart';
import '../../features/authentication/domain/repositories/authentication_repository.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // App logic
  sl
    ..registerFactory(
      () => AuthenticationCubit(
        createUser: sl(),
        getUsers: sl(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    // Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(sl()))

    // Datasources
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthRemoteDataSrcImpl(sl()))

    // External dépendencies
    ..registerLazySingleton(() => http.Client.new);
}
