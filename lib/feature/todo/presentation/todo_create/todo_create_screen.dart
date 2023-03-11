import 'package:dart3_sample/feature/todo/presentation/todo_create/create_todo_notifier.dart';
import 'package:dart3_sample/feature/todo/presentation/widget/todo_status_segmented_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final class TodoCreateScreen extends ConsumerWidget {
  TodoCreateScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('TodoCreate'),
        ),
        body: SingleChildScrollView(
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
                    controller: _todoNotifire(ref).titleController,
                    decoration: const InputDecoration(
                      labelText: 'タイトル',
                    ),
                    maxLength: 50,
                    onChanged: _todoNotifire(ref).updateTitle,
                    validator: _todoNotifire(ref).validateTitle,
                  ),
                  _spacer(),
                  TextFormField(
                    controller: _todoNotifire(ref).contentController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: '内容',
                    ),
                    maxLength: 500,
                    onChanged: _todoNotifire(ref).updateContent,
                    validator: _todoNotifire(ref).validateContent,
                  ),
                  _spacer(),
                  TodoStatusSegmentedButtons(
                    selectedStatus:
                        ref.watch(createTodoNotifierProvider).progressStatus,
                    onSelectSelection: _todoNotifire(ref).updateProgressStatus,
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

                          _todoNotifire(ref).addTodo();
                          context.go('/');
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Create'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _spacer() => const SizedBox(height: 16);

  CreateTodoNotifier _todoNotifire(WidgetRef ref) =>
      ref.watch(createTodoNotifierProvider.notifier);
}
