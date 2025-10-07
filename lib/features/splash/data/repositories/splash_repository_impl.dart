import 'package:cbt_test/core/error/failure.dart';

import '../../domain/repositories/splash_repository.dart';
import '../datasources/splash_local_data_source.dart';
import 'package:dartz/dartz.dart';

class SplashRepositoryImpl implements SplashRepository {
  final SplashLocalDataSource localDataSource;

  SplashRepositoryImpl({required this.localDataSource});

  @override
  Either<Failure, bool> isUserLoggedIn() {
    try {
      final result = localDataSource.isUserLoggedIn();
      return Right(result);
    } catch (e) {
      return Left(CacheFailure('Failed to check user login status: $e'));
    }
  }
}
