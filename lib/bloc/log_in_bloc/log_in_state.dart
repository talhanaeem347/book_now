part of 'log_in_bloc.dart';

// abstract class LogInState extends Equatable {
//   const LogInState();
// }
//
// class LogInInitial extends LogInState {
//   @override
//   List<Object> get props => [];
// }

class LogInState{

  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isInitial;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty;

  bool get isEmail => EmailValidator.validate(email);
  bool get isPassword => password.length >= 8;

  LogInState({
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.isInitial,
  });

  factory LogInState.initial(){
    return LogInState(
      email: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isInitial: true,
    );
  }

  LogInState loading(){
    return copyWith(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isInitial: false,
    );
  }

  LogInState success(){
    return copyWith(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isInitial: false,
    );
  }

  LogInState failure(){
    return copyWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isInitial: false,
    );
  }

  LogInState update({
    String? email,
    String? password,
  }){
    return copyWith(
      email: email,
      password: password,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isInitial: false,
    );
  }

  LogInState copyWith({
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isInitial,
  }){
    return LogInState(
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isInitial: isInitial ?? this.isInitial,
    );
  }

}