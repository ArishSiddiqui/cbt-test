import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/task.dart';
import '../repositories/home_repository.dart';

class GetAllTasks implements Usecase<List<TaskEntity>, NoParams> {
  final HomeRepository repository;
  GetAllTasks(this.repository);

  @override
  Future<Either<Failure, List<TaskEntity>>> call(NoParams params) async {
    return await repository.getAllTasks();
  }
}
