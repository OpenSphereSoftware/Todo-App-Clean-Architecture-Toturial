import 'package:dartz/dartz.dart';
import 'package:todoappv0/2_domain/auth/entities/todo.dart';
import 'package:todoappv0/core/failures/todo_failures.dart';

abstract class TodoRepository {
  Stream<Either<TodoFailures, List<Todo>>> watchAll();

  Future<Either<TodoFailures, Unit>> create(Todo todo);

  Future<Either<TodoFailures, Unit>> update(Todo todo);

  Future<Either<TodoFailures, Unit>> delete(Todo todo);
}
