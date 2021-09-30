part of 'todoform_bloc.dart';

class TodoformState {
  final Todo todo;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<TodoFailures, Unit>> failureOrSuccessOption;

  TodoformState(
      {required this.todo,
      required this.showErrorMessages,
      required this.isEditing,
      required this.isSaving,
      required this.failureOrSuccessOption});

  factory TodoformState.initial() => TodoformState(
      failureOrSuccessOption: none(),
      todo: Todo.empty(),
      showErrorMessages: false,
      isEditing: false,
      isSaving: false);

  TodoformState copyWith({
    Todo? todo,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<TodoFailures, Unit>>? failureOrSuccessOption,
  }) {
    return TodoformState(
      todo: todo ?? this.todo,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}
