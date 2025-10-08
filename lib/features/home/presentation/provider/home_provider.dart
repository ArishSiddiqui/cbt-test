import 'package:cbt_test/core/usecases/usecase.dart';
import 'package:cbt_test/features/home/domain/entities/task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/router.dart';
import '../../../../core/util/custom_utils.dart';
import '../../../../injection_container.dart';
import '../../../auth/domain/usecases/log_out_user.dart';
import '../../domain/usecases/get_all_tasks.dart';
import '../../domain/usecases/get_task_by_id.dart';
import '../../domain/usecases/update_task.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/add_task.dart';
import 'home_state.dart';

class HomeStateNotifier extends StateNotifier<HomeState> {
  final AddTask addTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  final GetAllTasks getAllTasks;
  final GetTaskById getTaskByID;
  final LogOutUser logOutUser;
  HomeStateNotifier({
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.getAllTasks,
    required this.getTaskByID,
    required this.logOutUser,
  }) : super(const HomeState());

  Future<void> logOut() async {
    final result = await logOutUser.call(NoParams());
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(
          message: failure.message ?? "Failed to log out user",
        );
      },
      (response) {
        state = state.copywith(status: ApiStatus.success);
        if (response) {
          Head.offAll(AppPages.login);
        } else {
          showCustomSnackBar(message: "Failed to log out user");
        }
      },
    );
  }

  Future<void> getAllTask() async {
    final result = await getAllTasks.call(NoParams());
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(
          message: failure.message ?? "Failed to get all tasks",
        );
      },
      (response) {
        List<TaskEntity> done = <TaskEntity>[];
        List<TaskEntity> inProgress = <TaskEntity>[];
        List<TaskEntity> todo = <TaskEntity>[];
        if (response.isNotEmpty) {
          done = response.where((t) => t.status == "Completed").toList();
          todo = response.where((t) => t.status == "To Do").toList();
          inProgress = response
              .where((t) => t.status == "In Progress")
              .toList();
        }
        state = state.copywith(
          status: ApiStatus.success,
          done: done,
          inProgress: inProgress,
          todo: todo,
        );
      },
    );
  }

  void createTask({
    required String title,
    required String description,
    required String status,
    required WidgetRef ref,
  }) async {
    state = state.copywith(status: ApiStatus.loading);
    final result = await addTask.call(
      AddTaskParams(description: description, status: status, title: title),
    );
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(message: failure.message ?? "Failed to add task");
      },
      (response) {
        state = state.copywith(status: ApiStatus.success);
        ref.invalidate(getAllTasksProvider);
        Head.back();
      },
    );
  }

  void editTask({
    required String title,
    required String description,
    required String status,
    required String taskID,
    required WidgetRef ref,
  }) async {
    state = state.copywith(status: ApiStatus.loading);
    final result = await updateTask.call(
      UpdateTaskParams(
        taskId: taskID,
        description: description,
        status: status,
        title: title,
      ),
    );
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(message: failure.message ?? "Failed to update task");
      },
      (response) {
        state = state.copywith(status: ApiStatus.success);
        ref.invalidate(getAllTasksProvider);
        Head.back();
      },
    );
  }

  void deleteSingleTask({
    required String taskID,
    required WidgetRef ref,
  }) async {
    state = state.copywith(status: ApiStatus.loading);
    final result = await deleteTask.call(DeleteTaskParams(taskId: taskID));
    result.fold(
      (failure) {
        state = state.copywith(status: ApiStatus.error);
        showCustomSnackBar(message: failure.message ?? "Failed to delete task");
      },
      (response) {
        state = state.copywith(status: ApiStatus.success);
        ref.invalidate(getAllTasksProvider);
        Head.back();
      },
    );
  }
}

final homeProvider = StateNotifierProvider<HomeStateNotifier, HomeState>(
  (ref) => sl<HomeStateNotifier>(),
);

final getAllTasksProvider = FutureProvider(
  (ref) => ref.read(homeProvider.notifier).getAllTask(),
);
