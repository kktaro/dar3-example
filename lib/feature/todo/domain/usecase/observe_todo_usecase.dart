import 'package:dart3_sample/feature/todo/domain/usecase/usecase.dart';
import 'package:dart3_sample/feature/todo/domain/value/todo.dart';
import 'package:dart3_sample/feature/todo/repository/todo_repository.dart';
import 'package:riverpod/riverpod.dart';

final observeTodoUsecaseProvider = Provider<ObserveTodoUsecase>((ref) {
  return ObserveTodoUsecase(
    ref.watch(todoRepositoryProvider),
  );
});

final class ObserveTodoUsecase implements Usecase {
  ObserveTodoUsecase(
    this._todoRepository,
  );

  final TodoRepository _todoRepository;

  @override
  Stream<List<Todo>> execute() {
    return _todoRepository.watchAll();
  }
}