import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/3_application/auth/authBloc/auth_bloc.dart';
import 'package:todoappv0/3_application/todos/todoActor/todo_actor_bloc.dart';
import 'package:todoappv0/3_application/todos/todoObserver/todo_observer_bloc.dart';
import 'package:todoappv0/4_presentation/home/widgets/home_body.dart';
import 'package:todoappv0/4_presentation/home/widgets/todo_card.dart';
import 'package:todoappv0/4_presentation/routes/router.gr.dart';
import 'package:todoappv0/injection.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = sl<TodoObserverBloc>();

    bloc.add(ObserveAllEvent());
    final themeData = Theme.of(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<TodoObserverBloc>(create: (context) => bloc),
        BlocProvider<TodoActorBloc>(
          create: (context) => sl<TodoActorBloc>(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(listener: (context, state) {
            if (state is AuthStateUnauthenticated) {
              AutoRouter.of(context).push(const SignUpPageRoute());
            }
          }),
          BlocListener<TodoActorBloc, TodoActorState>(
              listener: (context, state) {
            if (state is ActionFailure) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.redAccent, content: Text("failure")));
            }
          }),
        ],
        child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    BlocProvider.of<AuthBloc>(context)
                        .add(SignOutPressedEvent());
                  },
                  icon: const Icon(Icons.exit_to_app)),
              centerTitle: true,
              title: Text(
                "Todo App",
                style: themeData.textTheme.headline1!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: themeData.colorScheme.secondary,
              onPressed: () {
                AutoRouter.of(context).push(TodoDetailRoute(todo: null));
              },
              child: const Icon(
                Icons.add,
                size: 26,
              ),
            ),
            body: const HomeBody()),
      ),
    );
  }
}
