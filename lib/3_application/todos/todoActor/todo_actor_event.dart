part of 'todo_actor_bloc.dart';

@immutable
abstract class TodoActorEvent {}

class DeleteTodoEvent extends TodoActorEvent {
  final Todo todo;
  DeleteTodoEvent({required this.todo});
}

class SetTodoDoneStatusEvent extends TodoActorEvent {
  final Todo todo;
  final bool done;
  SetTodoDoneStatusEvent({required this.todo, required this.done});
}
