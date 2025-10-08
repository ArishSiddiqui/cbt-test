import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class UpdateTask implements Usecase<void, UpdateTaskParams> {
  final HomeRepository repository;
  UpdateTask(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateTaskParams params) async {
    return await repository.updateTask(
      taskId: params.taskId,
      title: params.title,
      description: params.description,
      status: params.status,
    );
  }
}

class UpdateTaskParams extends Equatable {
  final String taskId;
  final String? title;
  final String? description;
  final String? status;

  const UpdateTaskParams({
    required this.taskId,
    this.title,
    this.description,
    this.status,
  });

  @override
  List<Object?> get props => [taskId, title, description, status];
}
