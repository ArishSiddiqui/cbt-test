import 'package:cbt_test/core/error/exceptions.dart';
import 'package:cbt_test/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/task.dart';
import '../../domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

import '../datasources/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addTask({
    required String title,
    required String description,
    required String status,
  }) async {
    try {
      await remoteDataSource.addTask(
        title: title,
        description: description,
        status: status,
      );
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } catch (e) {
      return Left(ServerFailure(unexpectedErrorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(String taskId) async {
    try {
      await remoteDataSource.deleteTask(taskId);
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } catch (e) {
      return Left(ServerFailure(unexpectedErrorMessage));
    }
  }

  @override
  Future<Either<Failure, List<TaskEntity>>> getAllTasks() async {
    try {
      final List<TaskEntity> result = await remoteDataSource.getAllTasks();
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } catch (e) {
      return Left(ServerFailure(unexpectedErrorMessage));
    }
  }

  @override
  Future<Either<Failure, TaskEntity>> getTaskById(String taskId) async {
    try {
      final TaskEntity result = await remoteDataSource.getTaskById(taskId);
      return Right(result);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } catch (e) {
      return Left(ServerFailure(unexpectedErrorMessage));
    }
  }

  @override
  Future<Either<Failure, void>> updateTask({
    required String taskId,
    String? title,
    String? description,
    String? status,
  }) async {
    try {
      await remoteDataSource.updateTask(
        taskId: taskId,
        title: title,
        description: description,
        status: status,
      );
      return Right(null);
    } on FirebaseException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message ?? unexpectedErrorMessage));
    } catch (e) {
      return Left(ServerFailure(unexpectedErrorMessage));
    }
  }
}
