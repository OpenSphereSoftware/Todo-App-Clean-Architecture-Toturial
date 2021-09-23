abstract class AuthFailure {}

class ServerFailure extends AuthFailure {}

class EmailAlreadyInUse extends AuthFailure {}

class InvalidEmailAndPasswordCombination extends AuthFailure {}
