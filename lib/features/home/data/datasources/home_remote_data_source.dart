import 'package:cbt_test/core/error/exceptions.dart';
import 'package:cbt_test/features/home/data/models/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/constants/app_constants.dart';

abstract class HomeRemoteDataSource {
  Future<void> addTask({
    required String title,
    required String description,
    required String status,
  });
  Future<List<TaskModel>> getAllTasks();
  Future<void> updateTask({
    required String taskId,
    String? title,
    String? description,
    String? status,
  });
  Future<void> deleteTask(String taskId);
  Future<TaskModel> getTaskById(String taskId);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final FirebaseFirestore firestore;
  final CollectionReference _tasksRef;
  HomeRemoteDataSourceImpl({required this.firestore})
    : _tasksRef = firestore.collection(taskDB);

  /// Add a new task
  @override
  Future<void> addTask({
    required String title,
    required String description,
    required String status,
  }) async {
    await _tasksRef
        .add({
          'title': title,
          'description': description,
          'status': status,
          'createdBy': userUID,
          'createdAt': FieldValue.serverTimestamp(),
        })
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw ServerException('Adding task timed out. Please try again.');
          },
        );
  }

  /// Read all tasks
  @override
  Future<List<TaskModel>> getAllTasks() async {
    final querySnapshot = await _tasksRef
        .orderBy('createdAt', descending: true)
        .get()
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw ServerException(
              'Fetching all tasks timed out. Please try again.',
            );
          },
        );
    return querySnapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id; // include document ID
      return TaskModel.fromJson(data);
    }).toList();
  }

  /// Update an existing task
  @override
  Future<void> updateTask({
    required String taskId,
    String? title,
    String? description,
    String? status,
  }) async {
    final updateData = <String, dynamic>{
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (status != null) 'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    await _tasksRef
        .doc(taskId)
        .update(updateData)
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw ServerException('Upadting task timed out. Please try again.');
          },
        );
  }

  /// Delete a task
  @override
  Future<void> deleteTask(String taskId) async {
    await _tasksRef
        .doc(taskId)
        .delete()
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw ServerException('Deleting task timed out. Please try again.');
          },
        );
  }

  /// Read a single task by ID
  @override
  Future<TaskModel> getTaskById(String taskId) async {
    final doc = await _tasksRef
        .doc(taskId)
        .get()
        .timeout(
          timeoutDuration,
          onTimeout: () {
            throw ServerException('Fetching task timed out. Please try again.');
          },
        );
    if (doc.exists) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return TaskModel.fromJson(data);
    }
    throw ServerException("No task found.");
  }
}
