import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/home_repository.dart';

class AddTask implements Usecase<void, AddTaskParams> {
  final HomeRepository repository;
  AddTask(this.repository);

  @override
  Future<Either<Failure, void>> call(AddTaskParams params) async {
    return await repository.addTask(
      title: params.title,
      description: params.description,
      status: params.status,
    );
  }
}

class AddTaskParams extends Equatable {
  final String title;
  final String description;
  final String status;

  const AddTaskParams({
    required this.title,
    required this.description,
    required this.status,
  });

  @override
  List<Object?> get props => [title, description, status];
}
