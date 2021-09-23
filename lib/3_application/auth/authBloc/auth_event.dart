part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}


class AuthCheckRequestedEvent extends AuthEvent{}

class SignOutPressedEvent extends AuthEvent {}