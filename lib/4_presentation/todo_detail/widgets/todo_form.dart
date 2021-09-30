import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/3_application/todos/todoForm/todoform_bloc.dart';
import 'package:todoappv0/4_presentation/todo_detail/widgets/color_field_widget.dart';

class TodoForm extends StatelessWidget {
  const TodoForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocBuilder<TodoformBloc, TodoformState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Form(
            autovalidateMode: state.showErrorMessages
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            child: Column(
              children: [
                TextFormField(
                  
                  initialValue: state.todo.title,
                  decoration: InputDecoration(
                      labelText: "Title",
                      counterText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  maxLength: 100,
                  maxLines: 2,
                  minLines: 1,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  initialValue: state.todo.body,
                  
                  decoration: InputDecoration(
                      labelText: "Description",
                      counterText: "",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                  maxLength: 300,
                  maxLines: 8,
                  minLines: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                 ColorField(
                  color: state.todo.color,
                  callback: (){

                  },

                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: themeData.colorScheme.secondary),
                  child: Center(
                    child: Text("Safe",
                        style: themeData.textTheme.headline1!.copyWith(
                            fontSize: 14,
                            color: Colors.blueGrey[800],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4)),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
