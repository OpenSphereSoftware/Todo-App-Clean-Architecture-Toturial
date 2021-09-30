part of 'todo_observer_bloc.dart';

@immutable
abstract class TodoObserverEvent {}

class ObserveAllEvent extends TodoObserverEvent {}


class TodosUpdatedEvent extends TodoObserverEvent {
  final Either<TodoFailures, List<Todo>> failureOrTodos;
  TodosUpdatedEvent({required this.failureOrTodos});
}
