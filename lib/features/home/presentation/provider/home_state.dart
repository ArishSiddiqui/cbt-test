import 'package:equatable/equatable.dart';

import '../../../../core/constants/app_constants.dart';
import '../../domain/entities/task.dart';

class HomeState extends Equatable {
  final ApiStatus status;
  final List<TaskEntity> done;
  final List<TaskEntity> inProgress;
  final List<TaskEntity> todo;
  const HomeState({
    this.status = ApiStatus.initial,
    this.done = const <TaskEntity>[],
    this.todo = const <TaskEntity>[],
    this.inProgress = const <TaskEntity>[],
  });

  HomeState copywith({
    ApiStatus? status,
    List<TaskEntity>? inProgress,
    List<TaskEntity>? todo,
    List<TaskEntity>? done,
  }) {
    return HomeState(
      status: status ?? this.status,
      done: done ?? this.done,
      todo: todo ?? this.todo,
      inProgress: inProgress ?? this.inProgress,
    );
  }

  @override
  List<Object?> get props => [status, done, todo, inProgress];
}
