import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime createdAt;
  final String createdBy;
  final DateTime? updatedAt;

  const TaskEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.createdBy,
    this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    status,
    createdAt,
    createdBy,
    updatedAt,
  ];
}
