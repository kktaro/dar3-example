import 'package:dart3_sample/feature/todo/domain/value/todo_status.dart';

extension TodoStatusExtension on TodoStatus {
  String toDatabaseObject() => switch(this) {
     NotStarted() => 'not_started',
     InProgress() => 'in_progress',
     Finished() => 'finished',
  };
}