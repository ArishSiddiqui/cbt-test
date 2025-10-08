import 'package:cbt_test/features/home/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/presentation/widgets/widgets.dart';
import '../../../../core/router/router.dart';
import '../../../../core/util/custom_utils.dart';
import '../provider/home_provider.dart';

class TaskDetailPage extends StatefulWidget {
  final TaskEntity? task;
  const TaskDetailPage({this.task, super.key});

  @override
  State<TaskDetailPage> createState() => _TaskDetailPageState();
}

class _TaskDetailPageState extends State<TaskDetailPage> {
  final GlobalKey<FormState> taskKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final ValueNotifier<String?> statusNotifier = ValueNotifier<String?>(null);

  final List<String> statuses = ["To Do", "In Progress", "Done"];

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    if (widget.task != null) {
      titleController.text = widget.task?.title ?? "";
      descriptionController.text = widget.task?.description ?? "";
      statusNotifier.value = widget.task?.status;
    }
  }

  @override
  void dispose() {
    super.dispose();
    // Disposing controllers to free up resources and prevent memory leaks
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
        builder: (context, ref, _) {
          final state = ref.watch(homeProvider);
          final notifier = ref.read(homeProvider.notifier);
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: pendingScreenHeight,
              child: Form(
                key: taskKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20.0),
                    Row(
                      spacing: 16.0,
                      children: [
                        InkWell(
                          onTap: () => Head.back(),
                          child: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 22.0,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${widget.task != null ? "Edit" : "Create"} a task',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: AppColors.black,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                        if (widget.task != null) ...[
                          InkWell(
                            onTap: state.status == ApiStatus.loading
                                ? null
                                : () => notifier.deleteSingleTask(
                                    taskID: widget.task?.id ?? "",
                                    ref: ref,
                                  ),
                            child: Icon(
                              Icons.delete_outline_rounded,
                              size: 22.0,
                              color: state.status == ApiStatus.loading
                                  ? AppColors.grey
                                  : AppColors.red,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 36.0),
                    CustomTextField(
                      controller: titleController,
                      label: 'Title',
                      hint: "Enter your title",
                      validator: InputValidators.validateTitle,
                      maxLength: 50,
                    ),
                    const SizedBox(height: 16.0),
                    CustomTextField(
                      controller: descriptionController,
                      label: 'Description',
                      hint: "Enter your description",
                      minLines: 3,
                      maxLines: 3,
                      maxLength: 500,
                      validator: InputValidators.validateDescription,
                    ),
                    const SizedBox(height: 16.0),
                    ValueListenableBuilder(
                      valueListenable: statusNotifier,
                      builder: (context, status, _) {
                        return CustomDropDownFormField(
                          value: status,
                          label: 'Status',
                          onChanged: (val) => statusNotifier.value = val,
                          items: statuses.map((status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                          validator: InputValidators.validateStatus,
                        );
                      },
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 36.0),
                      child: CustomButton(
                        name: 'Save',
                        onTap: () {
                          if (taskKey.currentState?.validate() ?? false) {
                            widget.task != null
                                ? notifier.editTask(
                                    taskID: widget.task!.id,
                                    description: descriptionController.text,
                                    status: statusNotifier.value ?? "",
                                    title: titleController.text,
                                    ref: ref,
                                  )
                                : notifier.createTask(
                                    description: descriptionController.text,
                                    status: statusNotifier.value ?? "",
                                    title: titleController.text,
                                    ref: ref,
                                  );
                          }
                        },
                        disable: state.status == ApiStatus.loading,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
