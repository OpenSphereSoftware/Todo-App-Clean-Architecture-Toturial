import 'package:uuid/uuid.dart';

class UniqueId {
  const UniqueId._(this.value);

  final String value;

  factory UniqueId() {
    return UniqueId._(
      const Uuid().v1(),
    );
  }

  factory UniqueId.fromUniqueString(String uniqueId) {
    return UniqueId._(
      uniqueId,
    );
  }
}
