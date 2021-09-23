import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:todoappv0/1_infrastructure/auth/respositories/auth_repository_impl.dart';
import 'package:todoappv0/2_domain/auth/repositories/auth_repository.dart';
import 'package:todoappv0/3_application/auth/signInFromBloc/signinfrom_bloc.dart';

import '3_application/auth/authBloc/auth_bloc.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async {
//! state management (blocs, changeNotifier, Services)
  sl.registerFactory(() => SigninfromBloc(authRepository: sl()));
  sl.registerFactory(() => AuthBloc(authRepository: sl()));

//! repositories
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(firebaseAuth: sl()));

//! External
  final firebase = FirebaseAuth.instance;
  sl.registerLazySingleton(() => firebase);
}
