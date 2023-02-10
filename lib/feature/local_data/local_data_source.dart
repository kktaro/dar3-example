import 'package:dart3_sample/feature/local_data/database_define.dart';
import 'package:dart3_sample/feature/local_data/extension/domain_todo_extension.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dart3_sample/feature/todo/domain/value/todo.dart' as domain;

final localDataSourceProvider = Provider<LocalDataSource>((ref) {
  return LocalDataSource(ref.watch(todosDatabaseProvider));
});

class LocalDataSource {
  LocalDataSource(this.database);

  final TodosDatabase database;

  Future<int> upsertTodo(domain.Todo todo) =>
      database.upsert(todo.toDatabaseObject());

  Future<void> deleteTodo(domain.Todo todo) =>
      database.deleteSingle(todo.toDatabaseObject());
}
