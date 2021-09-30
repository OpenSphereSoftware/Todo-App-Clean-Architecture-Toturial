import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todoappv0/2_domain/auth/entities/todo.dart';
import 'package:todoappv0/2_domain/auth/repositories/todo_repository.dart';
import 'package:todoappv0/core/failures/todo_failures.dart';

part 'todo_observer_event.dart';
part 'todo_observer_state.dart';

class TodoObserverBloc extends Bloc<TodoObserverEvent, TodoObserverState> {
  final TodoRepository todoRepository;

  StreamSubscription<Either<TodoFailures, List<Todo>>>? _todoStreamSubscription;

  TodoObserverBloc({required this.todoRepository})
      : super(TodoObserverInitial()) {
    on<ObserveAllEvent>((event, emit) async {
      emit(LoadingState());
      await _todoStreamSubscription?.cancel();
      _todoStreamSubscription = todoRepository.watchAll().listen(
          (failureOrTodos) =>
              add(TodosUpdatedEvent(failureOrTodos: failureOrTodos)));
    });

    on<TodosUpdatedEvent>((event, emit) {
      event.failureOrTodos.fold((failure) {
        emit(FailureState(todoFailure: failure));
      }, (todos) {
        emit(SuccessState(todos: todos));
      });
    });
  }

  @override
  Future<void> close() async {
    await _todoStreamSubscription?.cancel();
    return super.close();
  }
}
