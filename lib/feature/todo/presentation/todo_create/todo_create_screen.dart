import 'package:dart3_sample/feature/todo/presentation/todo_create/create_todo_notifier.dart';
import 'package:dart3_sample/feature/todo/presentation/todo_create/widget/todo_status_segmented_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TodoCreateScreen extends ConsumerWidget {
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
                    controller: ref
                        .watch(createTodoNotifierProvider.notifier)
                        .titleController,
                    decoration: const InputDecoration(
                      labelText: 'タイトル',
                    ),
                    maxLength: 50,
                    onChanged: ref
                        .read(createTodoNotifierProvider.notifier)
                        .updateTitle,
                    validator: ref
                        .read(createTodoNotifierProvider.notifier)
                        .validateTitle,
                  ),
                  _spacer(),
                  TextFormField(
                    controller: ref
                        .watch(createTodoNotifierProvider.notifier)
                        .contentController,
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: '内容',
                    ),
                    maxLength: 500,
                    onChanged: ref
                        .read(createTodoNotifierProvider.notifier)
                        .updateContent,
                    validator: ref
                        .read(createTodoNotifierProvider.notifier)
                        .validateContent,
                  ),
                  _spacer(),
                  TodoStatusSegmentedButtons(
                    selectedStatus:
                        ref.watch(createTodoNotifierProvider).progressStatus,
                    onSelectSelection: ref
                        .read(createTodoNotifierProvider.notifier)
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

                          ref
                              .read(createTodoNotifierProvider.notifier)
                              .addTodo();
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
}
