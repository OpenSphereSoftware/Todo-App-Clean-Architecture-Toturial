import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/3_application/auth/authBloc/auth_bloc.dart';
import 'package:todoappv0/4_presentation/home/widgets/todo_card.dart';
import 'package:todoappv0/4_presentation/routes/router.gr.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(listener: (context, state) {
          if (state is AuthStateUnauthenticated) {
            AutoRouter.of(context).push(const SignUpPageRoute());
          }
        }),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(SignOutPressedEvent());
              },
              icon: const Icon(Icons.exit_to_app)),
          centerTitle: true,
          title: Text(
            "Todo App",
            style: themeData.textTheme.headline1!
                .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(Icons.check_box),
            ),
          ],
        ),
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 20,
            itemBuilder: (BuildContext context, index) {
              return TodoCard(title: "todo ");
            }),
        floatingActionButton: FloatingActionButton(
          backgroundColor: themeData.colorScheme.secondary,
          onPressed: () {
            //todo implement on pressed
          },
          child: const Icon(
            Icons.add,
            size: 26,
          ),
        ),
      ),
    );
  }
}
