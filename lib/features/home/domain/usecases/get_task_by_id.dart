import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/home_repository.dart';

class GetTaskById implements Usecase<TaskEntity, GetTaskByIdParams> {
  final HomeRepository repository;
  GetTaskById(this.repository);

  @override
  Future<Either<Failure, TaskEntity>> call(GetTaskByIdParams params) async {
    return await repository.getTaskById(params.taskId);
  }
}

class GetTaskByIdParams extends Equatable {
  final String taskId;

  const GetTaskByIdParams({required this.taskId});

  @override
  List<Object?> get props => [taskId];
}
