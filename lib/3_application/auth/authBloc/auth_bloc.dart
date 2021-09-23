import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoappv0/2_domain/auth/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(AuthStateInitial()) {
    on<AuthCheckRequestedEvent>((event, emit) async {
      final userOption = authRepository.getSignedInUser();
      userOption.fold(() => emit(AuthStateUnauthenticated()),
          (_) => emit(AuthStateAuthenticated()));
    });

    on<SignOutPressedEvent>((event, emit) async {
      await authRepository.signOut();
      emit(AuthStateUnauthenticated());
    });
  }
}
