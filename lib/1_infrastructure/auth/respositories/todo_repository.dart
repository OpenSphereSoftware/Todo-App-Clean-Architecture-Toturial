import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:todoappv0/1_infrastructure/auth/models/todo_model.dart';
import 'package:todoappv0/1_infrastructure/core/firstore_helpers.dart';
import 'package:todoappv0/2_domain/auth/entities/todo.dart';
import 'package:todoappv0/2_domain/auth/repositories/todo_repository.dart';
import 'package:todoappv0/core/failures/todo_failures.dart';

class TodoRepositoryImpl implements TodoRepository {
  final FirebaseFirestore firestore;
  TodoRepositoryImpl({required this.firestore});

  @override
  Future<Either<TodoFailures, Unit>> create(Todo todo) async {
    try {
      final userDoc = await firestore.userDocument();
      final todoModel = TodoModel.fromDomain(todo);

      await userDoc.todoCollection.doc(todoModel.id).set(todoModel
          .toMap()); // creates a new document with the local generated unique id

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message.toString().contains('PERMISSION_DENIED')) {
        return left(InsufficientPermisssons());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<TodoFailures, Unit>> delete(Todo todo) async {
    try {
      final userDoc = await firestore.userDocument();
      final todoID = todo.id;

      await userDoc.todoCollection.doc(todoID.value).delete();

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message.toString().contains('PERMISSION_DENIED')) {
        return left(InsufficientPermisssons());
      } else if (e.message.toString().contains('NOT_FOUND')) {
        return left(unableToUpdate());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Future<Either<TodoFailures, Unit>> update(Todo todo) async {
    try {
      final userDoc = await firestore.userDocument();
      final todoModel = TodoModel.fromDomain(todo);

      await userDoc.todoCollection.doc(todoModel.id).update(todoModel.toMap());

      return right(unit);
    } on FirebaseException catch (e) {
      if (e.message.toString().contains('PERMISSION_DENIED')) {
        return left(InsufficientPermisssons());
      } else if (e.message.toString().contains('NOT_FOUND')) {
        return left(unableToUpdate());
      } else {
        return left(UnexpectedFailure());
      }
    }
  }

  @override
  Stream<Either<TodoFailures, List<Todo>>> watchAll() async* {
    //yield left(const InsufficientPermissions());
    // users/{user ID}/notes/{todo ID}
    final userDoc = await firestore.userDocument();
    yield* userDoc.todoCollection
        .orderBy('serverTimeStamp', descending: true)
        .snapshots()
        .map((snapshot) => right<TodoFailures, List<Todo>>(snapshot.docs
            .map((doc) => TodoModel.fromFirestore(doc).toDomain())
            .toList()))
        .handleError((e) {
      if (e is FirebaseException) {
        if (e.code.contains('permission-denied') ||
            e.code.contains("PERMISSION_DENIED")) {
          return left(InsufficientPermisssons());
        } else {
          return left(UnexpectedFailure());
        }
      } else {
        // ? check for the unauthenticated error
        // ! log.e(e.toString());  // we can log unexpected exceptions
        return left(UnexpectedFailure());
      }
    });
  }
}
