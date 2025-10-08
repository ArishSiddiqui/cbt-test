import 'package:cbt_test/features/auth/domain/usecases/log_in_user.dart';
import 'package:cbt_test/features/auth/domain/usecases/log_out_user.dart';
import 'package:cbt_test/features/auth/domain/usecases/sign_up_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/presentation/provider/auth_provider.dart';
import 'features/home/data/datasources/home_remote_data_source.dart';
import 'features/home/data/repositories/home_repository_impl.dart';
import 'features/home/domain/repositories/home_repository.dart';
import 'features/home/domain/usecases/add_task.dart';
import 'features/home/domain/usecases/delete_task.dart';
import 'features/home/domain/usecases/get_all_tasks.dart';
import 'features/home/domain/usecases/get_task_by_id.dart';
import 'features/home/domain/usecases/update_task.dart';
import 'features/home/presentation/provider/home_provider.dart';
import 'features/splash/data/datasources/splash_local_data_source.dart';
import 'features/splash/data/repositories/splash_repository_impl.dart';
import 'features/splash/domain/repositories/splash_repository.dart';
import 'features/splash/domain/usecases/get_user_logged_in_status.dart';
import 'features/splash/presentation/provider/splash_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  //# Providers
  sl.registerFactory(() => SplashStateNotifier(getUserLoggedInStatus: sl()));
  sl.registerFactory(
    () =>
        AuthStateNotifier(logOutUser: sl(), loginUser: sl(), signUpUser: sl()),
  );
  sl.registerFactory(
    () => HomeStateNotifier(
      deleteTask: sl(),
      addTask: sl(),
      updateTask: sl(),
      getAllTasks: sl(),
      getTaskByID: sl(),
      logOutUser: sl(),
    ),
  );

  //# Use Cases
  sl.registerLazySingleton(() => GetUserLoggedInStatus(sl()));
  sl.registerLazySingleton(() => LogOutUser(sl()));
  sl.registerLazySingleton(() => LogInUser(sl()));
  sl.registerLazySingleton(() => SignUpUser(sl()));
  sl.registerLazySingleton(() => AddTask(sl()));
  sl.registerLazySingleton(() => UpdateTask(sl()));
  sl.registerLazySingleton(() => DeleteTask(sl()));
  sl.registerLazySingleton(() => GetAllTasks(sl()));
  sl.registerLazySingleton(() => GetTaskById(sl()));

  //# Repository
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(localDataSource: sl()),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );

  //# Data sources

  sl.registerLazySingleton<SplashLocalDataSource>(
    () => SplashLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(
      sharedPreferences: sl(),
      firebaseAuth: sl(),
      firestore: sl(),
    ),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(firestore: sl()),
  );

  //! Core

  //! External
  final sharedPreference = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreference);
  //# Firebase services
  sl.registerLazySingleton(() => FirebaseAuth.instance);
  sl.registerLazySingleton(() => FirebaseFirestore.instance);
}
