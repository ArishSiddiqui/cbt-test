import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/task.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> addTask({
    required String title,
    required String description,
    required String status,
  });
  Future<Either<Failure, List<TaskEntity>>> getAllTasks();
  Future<Either<Failure, void>> updateTask({
    required String taskId,
    String? title,
    String? description,
    String? status,
  });
  Future<Either<Failure, void>> deleteTask(String taskId);
  Future<Either<Failure, TaskEntity>> getTaskById(String taskId);
}
