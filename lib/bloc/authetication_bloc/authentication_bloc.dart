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
}
