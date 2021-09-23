part of 'signinfrom_bloc.dart';

@immutable
abstract class SigninfromEvent {}


class RegisterWithEmailAndPasswordPressed extends SigninfromEvent {
  final String? email;
  final String? password;
  RegisterWithEmailAndPasswordPressed(
      {required this.email, required this.password});
}

class SignInWithEmailAndPasswordPressed extends SigninfromEvent {
  final String? email;
  final String? password;
  SignInWithEmailAndPasswordPressed(
      {required this.email, required this.password});
}