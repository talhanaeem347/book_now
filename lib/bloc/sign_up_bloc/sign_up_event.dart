part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}
class UsernameChanged extends SignUpEvent {
  final String userName;

  const UsernameChanged({required this.userName});

  @override
  List<Object> get props => [userName];
}

class FamilyChanged extends SignUpEvent {
  final String family;

  const FamilyChanged({required this.family});

  @override
  List<Object> get props => [family];
}

class SignUpEmailChanged extends SignUpEvent {
  final String email;

  const SignUpEmailChanged({required this.email});

  @override
  List<Object> get props => [email];
}

class SignUpPasswordChanged extends SignUpEvent {
  final String password;

  const SignUpPasswordChanged({required this.password});

  @override
  List<Object> get props => [password];
}

class SignUpWithEmail extends SignUpEvent {}