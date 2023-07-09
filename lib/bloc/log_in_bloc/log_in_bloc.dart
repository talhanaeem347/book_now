import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_now/repositories/user_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'log_in_event.dart';
part 'log_in_state.dart';

class LogInBloc extends Bloc<LogInEvent, LogInState> {
  final UserRepository _userRepository;

  LogInBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(LogInState.initial()) {
    on<LogInEmailChanged>(_onLogInEmailChanged);
    on<LogInPasswordChanged>(_onLogInPasswordChanged);
    on<LogInWithEmail>(_onLogInWithEmail);
  }

  FutureOr<void> _onLogInEmailChanged(
      LogInEmailChanged event, Emitter<LogInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onLogInPasswordChanged(
      LogInPasswordChanged event, Emitter<LogInState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onLogInWithEmail(
      LogInWithEmail event, Emitter<LogInState> emit) async {
    emit(state.loading());
    String userId = await _userRepository.signInWithCredential(
        email: state.email, password: state.password);
    if (userId == '') {
      emit(state.failure());
      return; 
    }
    emit(state.success());
  }
}