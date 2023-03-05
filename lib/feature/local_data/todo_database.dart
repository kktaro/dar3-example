import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'generated/todo_database.g.dart';

final todosDatabaseProvider = Provider<TodosDatabase>((ref) {
  return TodosDatabase();
});

class Todos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get content => text()();
  TextColumn get status => text()();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Todos])
class TodosDatabase extends _$TodosDatabase {
  TodosDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<int> upsert(TodosCompanion entity) =>
      into(todos).insertOnConflictUpdate(entity);

  Future<void> deleteSingle(TodosCompanion entity) =>
      (delete(todos)..where((tbl) => tbl.id.equals(entity.id.value))).go();

  Stream<List<Todo>> watchAll() => select(todos).watch();
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbDirectory = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbDirectory.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
