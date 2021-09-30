import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/2_domain/auth/entities/todo.dart';
import 'package:todoappv0/3_application/todos/todoActor/todo_actor_bloc.dart';
import 'package:todoappv0/4_presentation/routes/router.gr.dart';

class TodoCard extends StatelessWidget {
  final Todo todo;
  const TodoCard({Key? key, required this.todo}) : super(key: key);

  void _showDeletionDialog(
      {required BuildContext context, required TodoActorBloc todoActorBloc}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Selected todo to delete:"),
            content: Text(
              todo.title,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    "CANCEL",
                    style: TextStyle(color: Colors.white),
                  )),
              TextButton(
                  onPressed: () {
                    todoActorBloc.add(DeleteTodoEvent(todo: todo));
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "DELETE",
                    style: TextStyle(color: Colors.white),
                  )),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return InkResponse(
      onLongPress: () {
        final todoActorBloc = context.read<TodoActorBloc>();
        _showDeletionDialog(context: context, todoActorBloc: todoActorBloc);
      },
      onTap: () {
        AutoRouter.of(context).push(TodoDetailRoute(todo: todo));
      },
      child: Card(
        elevation: 16,
        color: todo.color.color,
        child: ListTile(
          leading: Checkbox(
              value: todo.done,
              onChanged: (value) {
                if (value != null) {
                  BlocProvider.of<TodoActorBloc>(context)
                      .add(SetTodoDoneStatusEvent(todo: todo, done: value));
                }
              }),
          title: Text(
            todo.title,
            style: themeData.textTheme.headline1!
                .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
