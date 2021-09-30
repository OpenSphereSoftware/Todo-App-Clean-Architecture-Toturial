import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todoappv0/2_domain/auth/entities/todo.dart';
import 'package:todoappv0/2_domain/auth/entities/todo_color.dart';
import 'package:todoappv0/2_domain/auth/repositories/todo_repository.dart';
import 'package:todoappv0/core/failures/todo_failures.dart';

part 'todoform_event.dart';
part 'todoform_state.dart';

class TodoformBloc extends Bloc<TodoformEvent, TodoformState> {
  final TodoRepository todoRepository;
  TodoformBloc({required this.todoRepository})
      : super(TodoformState.initial()) {
    on<InitializedEvent>((event, emit) {
      if (event.todo != null) {
        emit(state.copyWith(todo: event.todo, isEditing: true));
      } else {
        emit(state);
      }
    });

    on<Saved>((event, emit) async {
      Either<TodoFailures, Unit>? failureOrSuccess;
      emit(state.copyWith(
        isSaving: true,
        failureOrSuccessOption: none(),
      ));

      if (event.title != null && event.body != null && event.color != null) {
        final Todo editedTodo = state.todo.copyWith(
            color: TodoColor(color: event.color!),
            title: event.title,
            body: event.body);
        if (state.isEditing) {
          failureOrSuccess = await todoRepository.update(editedTodo);
        } else {
          failureOrSuccess = await todoRepository.create(editedTodo);
        }
      }

      emit(state.copyWith(
        isSaving: false,
        showErrorMessages: true,
        failureOrSuccessOption: optionOf(failureOrSuccess),
      ));
    });
  }
}
