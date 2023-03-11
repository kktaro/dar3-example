import 'package:dart3_sample/feature/todo/presentation/todo_edit/edit_todo_notifier.dart';
import 'package:dart3_sample/feature/todo/presentation/widget/todo_status_segmented_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TodoEditScreen extends ConsumerWidget {
  TodoEditScreen({
    super.key,
    required this.todoId,
  });

  final int todoId;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TodoEdit'),
        ),
        body: ref.watch(editTodoNotifierProvider(todoId)).when(
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (error, stackTrace) => const Center(
                child: Text("ERROR!"),
              ),
              data: (data) => SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextFormField(
                          controller: _todoNotifier(ref).titleController,
                          decoration: const InputDecoration(
                            labelText: 'タイトル',
                          ),
                          maxLength: 50,
                          onChanged: _todoNotifier(ref).updateTitle,
                          validator: _todoNotifier(ref).validateTitle,
                        ),
                        _spacer(),
                        TextFormField(
                          controller: _todoNotifier(ref).contentController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            labelText: '内容',
                          ),
                          maxLength: 500,
                          onChanged: _todoNotifier(ref).updateContent,
                          validator: _todoNotifier(ref).validateContent,
                        ),
                        _spacer(),
                        TodoStatusSegmentedButtons(
                          selectedStatus: data.progressStatus,
                          onSelectSelection: ref
                              .read(editTodoNotifierProvider(todoId).notifier)
                              .updateProgressStatus,
                        ),
                        _spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: () => context.go('/'),
                              child: const Text('cancel'),
                            ),
                            FilledButton.icon(
                              onPressed: () {
                                if (!formKey.currentState!.validate()) return;

                                _todoNotifier(ref).updateTodo();
                                context.go('/');
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text('Edit'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
      ),
    );
  }

  Widget _spacer() => const SizedBox(height: 16);

  EditTodoNotifier _todoNotifier(WidgetRef ref) =>
      ref.watch(editTodoNotifierProvider(todoId).notifier);
}
