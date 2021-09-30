import 'package:todoappv0/2_domain/auth/entities/id.dart';
import 'package:todoappv0/2_domain/auth/entities/todo_color.dart';

class Todo {
  final UniqueId id;
  final String title;
  final String body;
  final TodoColor color;
  final bool done;

  Todo(
      {required this.id,
      required this.body,
      required this.color,
      required this.title
      , required this.done
      });

  factory Todo.empty() {
    return Todo(
        id: UniqueId(),
        title: "",
        body: "",
        done: false,
        color: TodoColor(color: TodoColor.predefinedColors[0]));
  }

  Todo copyWith({
    UniqueId? id,
    String? title,
    String? body,
    TodoColor? color,
    bool? done,
  }) {
    return Todo(
      id: id ?? this.id,
     title: title ?? this.title,
     body: body ?? this.body,
      color: color ?? this.color,
      done: done ?? this.done,
    );
  }
}
