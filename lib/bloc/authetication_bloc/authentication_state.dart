part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final String userId;

  const Authenticated({required this.userId});

  @override
  List<Object> get props => [userId];
}

class Unauthenticated extends AuthenticationState {}

