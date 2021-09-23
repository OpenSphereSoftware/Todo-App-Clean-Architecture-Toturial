import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/3_application/auth/authBloc/auth_bloc.dart';
import 'package:todoappv0/3_application/auth/signInFromBloc/signinfrom_bloc.dart';
import 'package:todoappv0/4_presentation/routes/router.gr.dart';
import 'package:todoappv0/core/failures/auth_failures.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final themeData = Theme.of(context);

    late String email;
    late String password;

    String? validateEmail(String? input) {
      const emailRegex =
          r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""";
      if (input == null || input.isEmpty) {
        return "please enter email";
      } else if (RegExp(emailRegex).hasMatch(input)) {
        email = input;
        return null;
      } else {
        return "Invalid e-mail";
      }
    }

    String? validatePassword(String? input) {
      if (input == null || input.isEmpty) {
        return "please enter password";
      } else if (input.length >= 6) {
        password = input;
        return null;
      } else {
        return "short password";
      }
    }

    String mapFailureMessage(AuthFailure failure) {
      switch (failure.runtimeType) {
        case ServerFailure:
          return "something went wrong";
        case EmailAlreadyInUse:
          return "email already in use";
        case InvalidEmailAndPasswordCombination:
          return "wrong password please try again";
        default:
          return "Something went wrong";
      }
    }

    return BlocConsumer<SigninfromBloc, SigninformState>(
      listener: (context, state) {
        state.authFailureOrSuccessOption.fold(
            () => {}, //! if none
            (either) => either.fold((failure) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.redAccent,
                      content: Text(mapFailureMessage(failure),
                          style: themeData.textTheme.bodyText1)));
                }, (_) {
                  AutoRouter.of(context).push(const HomePageRoute());
                  BlocProvider.of<AuthBloc>(context)
                      .add(AuthCheckRequestedEvent());
                }));
      },
      builder: (context, state) {
        return Form(
          autovalidateMode: state.showValidationMessages
              ? AutovalidateMode.always
              : AutovalidateMode.disabled,
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              const SizedBox(
                height: 80,
              ),
              Text(
                "Welcome",
                style: themeData.textTheme.headline1!.copyWith(
                    fontSize: 50,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 4),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Please register or sign in",
                style: themeData.textTheme.headline1!.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 4),
              ),
              const SizedBox(
                height: 80,
              ),
              TextFormField(
                  cursorColor: Colors.white,
                  decoration: const InputDecoration(
                    labelText: "E-Mail",
                  ),
                  validator: validateEmail),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                cursorColor: Colors.white,
                decoration: const InputDecoration(
                  labelText: "Password",
                ),
                validator: validatePassword,
              ),
              const SizedBox(
                height: 30,
              ),
              InkResponse(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    BlocProvider.of<SigninfromBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: email, password: password));
                  } else {
                    //TODO add bloc event to autvalidate from now
                    BlocProvider.of<SigninfromBloc>(context).add(
                        SignInWithEmailAndPasswordPressed(
                            email: null, password: null));

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text("invalid Input",
                            style: themeData.textTheme.bodyText1)));
                  }
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: themeData.colorScheme.secondary),
                  child: Center(
                    child: Text("Sign In",
                        style: themeData.textTheme.headline1!.copyWith(
                            fontSize: 14,
                            color: Colors.blueGrey[800],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4)),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              InkResponse(
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    print("validated");
                    BlocProvider.of<SigninfromBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: email, password: password));
                  } else {
                    //TODO add bloc event to autvalidate from now
                    BlocProvider.of<SigninfromBloc>(context).add(
                        RegisterWithEmailAndPasswordPressed(
                            email: null, password: null));
                    print("not valid");
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.redAccent,
                        content: Text("invalid Input",
                            style: themeData.textTheme.bodyText1)));
                  }
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: themeData.colorScheme.secondary),
                  child: Center(
                    child: Text("Register",
                        style: themeData.textTheme.headline1!.copyWith(
                            fontSize: 14,
                            color: Colors.blueGrey[800],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4)),
                  ),
                ),
              ),
              if (state.isSubmitting) ...[
                const SizedBox(
                  height: 8,
                ),
                LinearProgressIndicator(color: themeData.colorScheme.secondary),
              ]
            ],
          ),
        );
      },
    );
  }
}
