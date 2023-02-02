import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TodoCreateScreen extends ConsumerWidget {
  const TodoCreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TodoCreate'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Todo Create'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () => context.go('/'),
                child: const Text('cancel'),
              ),
              OutlinedButton(
                onPressed: () => context.go('/'),
                child: const Text('Create!'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
