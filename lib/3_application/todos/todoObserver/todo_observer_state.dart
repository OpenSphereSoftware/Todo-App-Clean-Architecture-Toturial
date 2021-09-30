part of 'todo_observer_bloc.dart';

@immutable
abstract class TodoObserverState {}

class TodoObserverInitial extends TodoObserverState {}

class LoadingState extends TodoObserverState {}

class FailureState extends TodoObserverState {
  final TodoFailures todoFailure;
  FailureState({required this.todoFailure});
}

class SuccessState extends TodoObserverState {
  final List<Todo> todos;
  SuccessState({required this.todos});
}
