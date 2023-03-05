import 'package:dart3_sample/feature/todo/domain/value/todo_status.dart';
import 'package:flutter/material.dart';

@immutable
final class Todo {
  const Todo({
    required this.id,
    required this.title, 
    required this.content, 
    required this.progressStatus,
    required this.updatedAt,
  });

  final int id;
  final String title;
  final String content;
  final TodoStatus progressStatus;
  final DateTime updatedAt;

  Todo copyWith({
    int? id,
    String? title,
    String? content,
    TodoStatus? progressStatus,
    DateTime? updatedAt,
  }) => Todo(
    id: id ?? this.id,
    title: title ?? this.title,
    content: content ?? this.content,
    progressStatus: progressStatus ?? this.progressStatus,
    updatedAt: updatedAt ?? this.updatedAt,
  );
}
