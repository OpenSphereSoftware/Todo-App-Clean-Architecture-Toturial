part of 'todo_actor_bloc.dart';

@immutable
abstract class TodoActorState {}

class TodoActorInitial extends TodoActorState {}

class ActionInProgress extends TodoActorState {}

class ActionSuccess extends TodoActorState {}

class ActionFailure extends TodoActorState {
  final TodoFailures failure;
  ActionFailure({required this.failure});
}


 
