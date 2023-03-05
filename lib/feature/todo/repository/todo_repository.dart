import 'package:dart3_sample/feature/local_data/todo_database.dart';
import 'package:dart3_sample/feature/todo/domain/value/todo.dart' as domain;
import 'package:dart3_sample/feature/todo/repository/extension/domain_todo_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  return TodoRepository(ref.watch(todosDatabaseProvider));
});

final class TodoRepository {
  TodoRepository(this._database);

  final TodosDatabase _database;

  Future<int> add(domain.Todo todo) => _database.upsert(todo.toDTO());

  Future<int> update(domain.Todo todo) => _database.upsert(todo.toUniqueDTO());

  Future<void> delete(domain.Todo todo) => _database.deleteSingle(todo.toUniqueDTO());

  Stream<List<domain.Todo>> watchAll() => _database.watchAll()
    .map((event) => event.map((e) => DomainTodoExtension.fromDTO(e)).toList());
}
