import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_now/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository _userRepository;
  AuthenticationBloc({required UserRepository userRepository}) : _userRepository = userRepository,super(AuthenticationInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LoggedIn>(_onLoggedIn);
  }

  FutureOr<void> _onAppStarted(AppStarted event, Emitter<AuthenticationState> emit) async {
    emit(Uninitialized());
    final userid = await _userRepository.getCurrentUser();
    if(userid.isNotEmpty){
      emit(Authenticated(userId: userid));
    }else{
      emit(Unauthenticated());
    }

  }

  FutureOr<void> _onLoggedIn(LoggedIn event, Emitter<AuthenticationState> emit) async {
    final String userId = await _userRepository.getCurrentUser();
    if(userId.isNotEmpty) {
      emit(Authenticated(userId:userId));
    }else{
      emit(Unauthenticated());
    }

  }
}
