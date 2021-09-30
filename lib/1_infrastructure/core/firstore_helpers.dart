import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoappv0/2_domain/auth/repositories/auth_repository.dart';
import 'package:todoappv0/core/failures/errors.dart';

import '../../injection.dart';

extension FirestoreX on FirebaseFirestore {
  Future<DocumentReference> userDocument() async {
    final userOption = sl<AuthRepository>().getSignedInUser();
    final user = userOption.getOrElse(() => throw NotAuthenticatedError());

    return FirebaseFirestore.instance
        .collection('users')
        .doc(user.id.value);
  }
}

extension DocumentReferenceX on DocumentReference {
  CollectionReference<Map<String,dynamic>> get todoCollection => collection('todos');
}
