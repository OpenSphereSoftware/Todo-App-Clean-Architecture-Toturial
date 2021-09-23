import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoappv0/3_application/auth/signInFromBloc/signinfrom_bloc.dart';
import 'package:todoappv0/4_presentation/signup/widgets/signup_form.dart';
import 'package:todoappv0/injection.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => sl<SigninfromBloc>(),
      child: const SignUpForm(),
    ));
  }
}
