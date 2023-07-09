import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_now/models/user_model.dart';
import 'package:book_now/repositories/user_repository.dart';
import 'package:email_validator/email_validator.dart';
import 'package:equatable/equatable.dart';

part 'sign_up_event.dart';

part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final UserRepository _userRepository;

  SignUpBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(SignUpState.initial()) {
    on<UsernameChanged>(_onUsernameChanged);
    on<FamilyChanged>(_onFamilyChanged);
    on<SignUpEmailChanged>(_onSignUpEmailChanged);
    on<SignUpPasswordChanged>(_onSignUpPasswordChanged);
    on<SignUpWithEmail>(_onSignUpWithEmail);
  }

  FutureOr<void> _onUsernameChanged(
      UsernameChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(username: event.userName));
  }

  FutureOr<void> _onFamilyChanged(
      FamilyChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(family: event.family));
  }

  FutureOr<void> _onSignUpEmailChanged(
      SignUpEmailChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(email: event.email));
  }

  FutureOr<void> _onSignUpPasswordChanged(
      SignUpPasswordChanged event, Emitter<SignUpState> emit) {
    emit(state.copyWith(password: event.password));
  }

  FutureOr<void> _onSignUpWithEmail(
      SignUpWithEmail event, Emitter<SignUpState> emit) async {
    emit(state.loading());
    String userId = await _userRepository.signUpWithCredential(
        email: state.email, password: state.password);
    if (userId.isNotEmpty) {
      bool isSet = await _userRepository.addUser(
          user: state.toUserMap(userId: userId));
      if (isSet) {
        emit(state.success());
        return;
      }
    }
    emit(state.failure());
  }
}
