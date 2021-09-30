import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todoappv0/1_infrastructure/auth/respositories/auth_repository_impl.dart';
import 'package:todoappv0/1_infrastructure/auth/respositories/todo_repository.dart';
import 'package:todoappv0/2_domain/auth/repositories/auth_repository.dart';
import 'package:todoappv0/2_domain/auth/repositories/todo_repository.dart';
import 'package:todoappv0/3_application/auth/signInFromBloc/signinfrom_bloc.dart';
import 'package:todoappv0/3_application/todos/todoActor/todo_actor_bloc.dart';
import 'package:todoappv0/3_application/todos/todoForm/todoform_bloc.dart';
import 'package:todoappv0/3_application/todos/todoObserver/todo_observer_bloc.dart';

import '3_application/auth/authBloc/auth_bloc.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async {
//? ####################  Authentication ################
//! state management (blocs, changeNotifier, Services)
  sl.registerFactory(() => SigninfromBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

//! repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

//! External
  final firebase = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebase);

//? ####################  TODO ################

//! state management
  sl.registerFactory(() => TodoObserverBloc(todoRepository: sl()));
  sl.registerFactory(() => TodoActorBloc(todoRepository: sl()));
  sl.registerFactory(() => TodoformBloc(todoRepository: sl()));

//! repositories
  sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(firestore: sl()));

//! External
  final firestore = FirebaseFirestore.instance;
  sl.registerLazySingleton<FirebaseFirestore>(() => firestore);
}
