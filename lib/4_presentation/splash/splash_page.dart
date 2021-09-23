import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/3_application/auth/authBloc/auth_bloc.dart';
import 'package:todoappv0/4_presentation/routes/router.gr.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateAuthenticated) {
          context.router.replace(const HomePageRoute());
        } else if (state is AuthStateUnauthenticated) {
          context.router.replace(const SignUpPageRoute());
        }
      },
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Loading...",
                style: themeData.textTheme.headline1!.copyWith(
                  fontSize: 16,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
