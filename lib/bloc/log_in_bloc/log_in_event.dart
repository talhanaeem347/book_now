part of 'log_in_bloc.dart';

abstract class LogInEvent extends Equatable {
  const LogInEvent();

  @override
  List<Object> get props => [];
}

class LogInEmailChanged extends LogInEvent {
  final String email;

  const LogInEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class LogInPasswordChanged extends LogInEvent {
  final String password;

  const LogInPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

  class LogInWithEmail extends LogInEvent {}
