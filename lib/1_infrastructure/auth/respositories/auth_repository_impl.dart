import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoappv0/1_infrastructure/auth/models/firebare_user_mapper.dart';
import 'package:todoappv0/2_domain/auth/entities/user.dart';
import 'package:todoappv0/2_domain/auth/repositories/auth_repository.dart';
import 'package:todoappv0/core/failures/auth_failures.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepositoryImpl({required this.firebaseAuth});

  @override
  Future<Either<AuthFailure, Unit>> registerWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: emailAddress, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return left(EmailAlreadyInUse());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signInWithEmailAndPassword(
      {required String emailAddress, required String password}) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return right(unit);
    } on FirebaseAuthException catch (e) {
      if (e.code == "wrong-password" || e.code == "user-not-found") {
        return left(InvalidEmailAndPasswordCombination());
      } else {
        return left(ServerFailure());
      }
    }
  }

  @override
  Option<CustomUser> getSignedInUser() => optionOf(firebaseAuth.currentUser
      ?.toDomain()); // some(CustomUser(id: UniqueId.fromUniqueString(_firebaseAuth.currentUser!.uid)));

  @override
  Future<void> signOut() => Future.wait([
        firebaseAuth.signOut(),
      ]);
}
