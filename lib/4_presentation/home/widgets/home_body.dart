import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/3_application/todos/todoObserver/todo_observer_bloc.dart';
import 'package:todoappv0/4_presentation/home/widgets/todo_card.dart';
import 'package:todoappv0/injection.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TodoObserverBloc, TodoObserverState>(
      builder: (context, state) {
        if (state is TodoObserverInitial) {
          return Container();
        } else if (state is SuccessState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final todo = state.todos[index];
              return TodoCard(
                todo: todo,
              );
            },
            itemCount: state.todos.length,
          );
        } else if (state is FailureState) {
          return Container(
            color: Colors.red,
          );
        } else if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.secondary,
            ),
          );
        }
        return Container();
      },
    );
  }
}
