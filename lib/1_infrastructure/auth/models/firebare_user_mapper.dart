import 'package:firebase_auth/firebase_auth.dart';
import 'package:todoappv0/2_domain/auth/entities/id.dart';
import 'package:todoappv0/2_domain/auth/entities/user.dart';

extension FirebaseUserToDomain on User {
  CustomUser toDomain() {
    return CustomUser(
      id: UniqueId.fromUniqueString(uid),
    );
  }
}
