part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthStateInitial extends AuthState {}

class AuthStateAuthenticated extends AuthState {}

class AuthStateUnauthenticated extends AuthState {}
