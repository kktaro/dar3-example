import 'package:dart3_sample/feature/common_widget/message_alert_dialog.dart';
import 'package:dart3_sample/feature/todo/domain/usecase/delete_todo_usecase.dart';
import 'package:dart3_sample/feature/todo/domain/usecase/observe_todo_usecase.dart';
import 'package:dart3_sample/feature/todo/presentation/todo_list/widget/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoList'),
      ),
      body: Center(
        child: StreamBuilder(
          stream: ref.watch(observeTodoUsecaseProvider).execute(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Loading
              return const Center(child: CircularProgressIndicator());
            } else {
              if (snapshot.hasError) {
                return const Center(child: Text('ERROR!'));
              }

              final todos = snapshot.data!;

              if (todos.isEmpty) {
                return const Center(child: Text('TODO is Empty'));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(4),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return TodoItem(
                    id: todo.id,
                    title: todo.title,
                    content: todo.content,
                    status: todo.progressStatus,
                    updatedAt: todo.updatedAt,
                    onClickEdit: (p0) {},
                    onClickDelete: (id) {
                      showDialog(
                        context: context,
                        builder: (_) => MessageAlertDialog(
                          title: 'Todoを削除',
                          message: '${todo.title} を削除してもよろしいですか？',
                          onCancel: () => Navigator.of(context).pop(),
                          onApprove: () {
                            ref.read(deleteTodoUsecaseProvider).execute(id);
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  );
                },
                separatorBuilder: (_, __) => const Divider(),
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/create'),
        child: const Icon(Icons.add),
      ),
    );
  }
}
