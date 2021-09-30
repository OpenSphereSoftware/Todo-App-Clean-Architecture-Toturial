import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:todoappv0/2_domain/auth/repositories/auth_repository.dart';
import 'package:todoappv0/core/failures/auth_failures.dart';

part 'signinfrom_event.dart';
part 'signinfrom_state.dart';

class SigninfromBloc extends Bloc<SigninfromEvent, SigninformState> {
  final AuthRepository authRepository;

  SigninfromBloc({required this.authRepository})
      : super(SigninformState(
            isSubmitting: false,
            showValidationMessages: false,
            authFailureOrSuccessOption: none())) {
    on<RegisterWithEmailAndPasswordPressed>((event, emit) async {
      Either<AuthFailure, Unit>? failureOrSuccess;

      if (event.password == null || event.email == null) {
        emit(state.copyWith(
          showValidationMessages: true,
          isSubmitting: false,
        ));
      } else {
        emit(state.copyWith(
            isSubmitting: true, authFailureOrSuccessOption: none()));
        failureOrSuccess = await authRepository.registerWithEmailAndPassword(
            emailAddress: event.email!, password: event.password!);
        emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });

    on<SignInWithEmailAndPasswordPressed>((event, emit) async {
      Either<AuthFailure, Unit>? failureOrSuccess;

      if (event.password == null || event.email == null) {
        emit(state.copyWith(
          showValidationMessages: true,
          isSubmitting: false,
        ));
      } else {
        emit(state.copyWith(
            isSubmitting: true, authFailureOrSuccessOption: none()));
        failureOrSuccess = await authRepository.signInWithEmailAndPassword(
            emailAddress: event.email!, password: event.password!);
        emit(state.copyWith(
            isSubmitting: false,
            authFailureOrSuccessOption: optionOf(failureOrSuccess)));
      }
    });
  }
}
