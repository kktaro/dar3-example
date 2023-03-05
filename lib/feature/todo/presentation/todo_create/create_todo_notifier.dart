import 'package:dart3_sample/feature/todo/domain/value/todo.dart';
import 'package:dart3_sample/feature/todo/domain/value/todo_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final createTodoNotifierProvider = StateNotifierProvider<CreateTodoNotifier, Todo>((ref) {
  return CreateTodoNotifier();
});

final class CreateTodoNotifier extends StateNotifier<Todo> {
  CreateTodoNotifier(): super(
    Todo(
    id: -1, // 登録時に再度割り当てるため、この値は使用しない
    title: '', 
    content: '', 
    progressStatus: NotStarted(), 
    updatedAt: DateTime.now(),
    )
    );

  final titleController = TextEditingController(text: '');
  final contentController = TextEditingController(text: '');

  String? validateTitle(String? value) {
    if (value?.isEmpty ?? true) return 'タイトルを入力してください';
    
    return null;
  }

  void updateTitle(String value) {
    state = state.copyWith(title: value);
  }

  String? validateContent(String? value) {
    if (value?.isEmpty ?? true) return '内容を入力してください';

    return null;
  }

  void updateContent(String value) {
    state = state.copyWith(content: value);
  }

  void updateProgressStatus(TodoStatus value) {
    state = state.copyWith(progressStatus: value);
  }
}
