import 'package:dart3_sample/feature/local_data/database_define.dart';
import 'package:dart3_sample/feature/local_data/extension/todo_status_extension.dart';
import 'package:dart3_sample/feature/todo/domain/value/todo.dart' as domain;

extension DomainTodoExtension on domain.Todo {
  Todo toDatabaseObject() {
    return Todo(
      id: id,
      title: title,
      content: content,
      status: progressStatus.toDatabaseObject(),
      updatedAt: updatedAt,
    );
  }
}
