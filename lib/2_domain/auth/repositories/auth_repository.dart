import 'package:dartz/dartz.dart';
import 'package:todoappv0/2_domain/auth/entities/user.dart';
import 'package:todoappv0/core/failures/auth_failures.dart';

abstract class AuthRepository {
  Option<CustomUser> getSignedInUser();

  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String emailAddress, required String password});

  Future<void> signOut();
}
