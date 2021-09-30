import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoappv0/2_domain/auth/entities/todo.dart';
import 'package:todoappv0/2_domain/auth/repositories/todo_repository.dart';
import 'package:todoappv0/core/failures/todo_failures.dart';

part 'todo_actor_event.dart';
part 'todo_actor_state.dart';

class TodoActorBloc extends Bloc<TodoActorEvent, TodoActorState> {
  final TodoRepository todoRepository;
  TodoActorBloc({required this.todoRepository}) : super(TodoActorInitial()) {
    on<SetTodoDoneStatusEvent>((event, emit) async {
      emit(ActionInProgress());
      final failureOrSuccess =
          await todoRepository.update(event.todo.copyWith(done: event.done));
      failureOrSuccess.fold((failure) => emit(ActionFailure(failure: failure)),
          (_) => emit(ActionSuccess()));
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(ActionInProgress());
      final failureOrSuccess = await todoRepository.delete(event.todo);
      failureOrSuccess.fold((failure) => emit(ActionFailure(failure: failure)),
          (_) => emit(ActionSuccess()));
    });
  }
}
