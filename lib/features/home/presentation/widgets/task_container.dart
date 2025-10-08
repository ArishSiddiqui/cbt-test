import 'package:cbt_test/core/constants/app_colors.dart';
import 'package:cbt_test/core/constants/app_constants.dart';
import 'package:cbt_test/features/home/domain/entities/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/router/router.dart';

class TaskContainer extends StatefulWidget {
  final String section;
  final String? iconPath;
  final bool? isDone;
  final List<TaskEntity> tasks;
  final Function(TaskEntity task, String newStatus) onTaskDropped;
  const TaskContainer({
    required this.section,
    required this.tasks,
    required this.onTaskDropped,
    this.iconPath,
    this.isDone,
    super.key,
  });

  @override
  State<TaskContainer> createState() => _TaskContainerState();
}

class _TaskContainerState extends State<TaskContainer> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget<TaskEntity>(
      onWillAcceptWithDetails: (data) => true,
      onAcceptWithDetails: (detail) {
        setState(() {
          _currentPage = 0;
        });
        widget.onTaskDropped(detail.data, widget.section);
      },
      builder: (context, candidateData, rejectedData) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  if (widget.iconPath != null) ...[
                    Container(
                      padding: EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.white,
                      ),
                      child: SvgPicture.asset(widget.iconPath!, height: 24.0),
                    ),
                    const SizedBox(width: 16.0),
                  ],
                  Text(
                    widget.section,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.0,
                      color: AppColors.deepBlack,
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Text(
                    widget.tasks.length.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 15.0,
                      color: AppColors.grey,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: screenHeight! * 0.15,
              child: PageView.builder(
                controller: _pageController,
                itemCount: widget.tasks.length,
                onPageChanged: (index) {
                  setState(() => _currentPage = index);
                },
                itemBuilder: (context, index) {
                  final scale = _currentPage == index ? 1.0 : 0.9;

                  return AnimatedScale(
                    scale: scale,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                    child: _TaskCardWidget(
                      task: widget.tasks[index],
                      isDone: widget.isDone ?? false,
                      onDragCompleted: (drag) {},
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8.0),
            SizedBox(
              height: 6,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: widget.tasks.length,
                itemBuilder: (context, index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentPage == index ? 10 : 6,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.greyDark
                        : AppColors.grey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _TaskCardWidget extends StatelessWidget {
  final TaskEntity task;
  final bool isDone;
  final Function(TaskEntity) onDragCompleted;

  const _TaskCardWidget({
    required this.task,
    required this.isDone,
    required this.onDragCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<TaskEntity>(
      data: task,
      feedback: Material(
        color: Colors.transparent,
        child: Opacity(opacity: 0.8, child: _buildCard(isDragging: true)),
      ),
      childWhenDragging: Opacity(opacity: 0.5, child: _buildCard()),
      onDragCompleted: () => onDragCompleted(task),
      child: GestureDetector(
        onTap: () => Head.to(AppPages.taskDetail, arguments: task),
        child: _buildCard(),
      ),
    );
  }

  Widget _buildCard({bool? isDragging}) {
    return Container(
      height: (isDragging ?? false) ? screenHeight! * 0.145 : null,
      width: (isDragging ?? false) ? screenWidth! * 0.9 : null,
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            maxLines: 1,
            style: TextStyle(
              decoration: isDone ? TextDecoration.lineThrough : null,
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: Colors.black87,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.notes_rounded, color: Colors.grey, size: 16.0),
              const SizedBox(width: 4),
              Flexible(
                child: Text(
                  task.description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
