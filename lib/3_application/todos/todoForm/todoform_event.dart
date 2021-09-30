part of 'todoform_bloc.dart';

@immutable
abstract class TodoformEvent {}

class InitializedEvent extends TodoformEvent {
  final Todo? todo;
  InitializedEvent({required this.todo});
}

class Saved extends TodoformEvent {
  final Color? color;
  final String? title;
  final String? body;
  Saved({required this.color, required this.title, required this.body});
}
