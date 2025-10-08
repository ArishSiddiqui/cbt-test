import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/router/router.dart';
import '../provider/home_provider.dart';
import '../widgets/widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void dispose() {
    super.dispose();
    // Disposing controllers to free up resources and prevent memory leaks
    ref.invalidate(homeProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        actions: [
          IconButton(
            onPressed: () => Head.to(AppPages.taskDetail),
            icon: const Icon(Icons.add, color: AppColors.indigo),
          ),
        ],
        elevation: 0.0,
        title: Text(
          "CB Kanban",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: AppColors.black,
            fontSize: 15.0,
          ),
        ),
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Consumer(
      builder: (context, ref, _) {
        final notifier = ref.read(homeProvider.notifier);
        final state = ref.watch(homeProvider);
        final getTasks = ref.watch(getAllTasksProvider);
        return getTasks.when(
          data: (_) => RefreshIndicator(
            onRefresh: notifier.getAllTask,
            child:
                state.done.isEmpty &&
                    state.inProgress.isEmpty &&
                    state.todo.isEmpty
                ? NoTask()
                : ListView(
                    children: [
                      if (state.todo.isNotEmpty) ...[
                        TaskContainer(
                          section: "To Do",
                          iconPath: AppIcons.todo,
                          tasks: state.todo,
                          onTaskDropped: (task, status) => notifier.editTask(
                            taskID: task.id,
                            description: task.description,
                            status: status,
                            title: task.title,
                            ref: ref,
                          ),
                        ),
                      ],
                      if (state.inProgress.isNotEmpty) ...[
                        TaskContainer(
                          section: "In Progress",
                          iconPath: AppIcons.inProgress,
                          tasks: state.inProgress,
                          onTaskDropped: (task, status) => notifier.editTask(
                            taskID: task.id,
                            description: task.description,
                            status: status,
                            title: task.title,
                            ref: ref,
                          ),
                        ),
                      ],
                      if (state.done.isNotEmpty) ...[
                        TaskContainer(
                          section: "Done",
                          iconPath: AppIcons.done,
                          isDone: true,
                          tasks: state.done,
                          onTaskDropped: (task, status) => notifier.editTask(
                            taskID: task.id,
                            description: task.description,
                            status: status,
                            title: task.title,
                            ref: ref,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
          error: (error, stackTrace) => const Center(
            child: Text('Error', style: TextStyle(color: AppColors.deepBlack)),
          ),
          loading: () => const CustomLoader(),
        );
      },
    );
  }
}
