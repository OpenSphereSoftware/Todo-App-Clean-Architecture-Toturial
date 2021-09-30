import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/2_domain/auth/entities/todo.dart';
import 'package:todoappv0/3_application/todos/todoForm/todoform_bloc.dart';
import 'package:todoappv0/4_presentation/routes/router.gr.dart';
import 'package:todoappv0/4_presentation/todo_detail/widgets/color_field_widget.dart';
import 'package:todoappv0/4_presentation/todo_detail/widgets/in_prgress_overlay.dart';
import 'package:todoappv0/4_presentation/todo_detail/widgets/todo_form.dart';
import 'package:todoappv0/injection.dart';

class TodoDetail extends StatelessWidget {
  final Todo? todo;

  const TodoDetail({Key? key, required this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocProvider(
      create: (context) =>
          sl<TodoformBloc>()..add(InitializedEvent(todo: todo)),
      child: BlocConsumer<TodoformBloc, TodoformState>(
        listenWhen: (p, c) =>
            p.failureOrSuccessOption != c.failureOrSuccessOption,
        listener: (context, state) {
          state.failureOrSuccessOption.fold(() => {}, (either) {
            either.fold((failure) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.redAccent, content: Text("failure")));
            }, (_) {
              Navigator.of(context).popUntil(
                  (route) => route.settings.name == HomePageRoute.name);
            });
          });
        },
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Todo",
                  style: themeData.textTheme.headline1!
                      .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              body: Stack(
                children: [
                  const TodoForm(),
                  SavingInProgressOverlay(isSaving: state.isSaving)
                ],
              ));
        },
      ),
    );
  }
}
