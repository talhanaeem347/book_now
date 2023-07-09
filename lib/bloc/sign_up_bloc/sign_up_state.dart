part of 'sign_up_bloc.dart';

// abstract class SignUpState extends Equatable {
//   const SignUpState();
// }
//
// class SignUpInitial extends SignUpState {
//   @override
//   List<Object> get props => [];
// }

class SignUpState{

  final String username;
  final String family;
  final String email;
  final String password;
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final bool isInitial;

  bool get isFormValid => username.isNotEmpty && family.isNotEmpty && email.isNotEmpty && password.isNotEmpty;

  bool get isEmail => EmailValidator.validate(email);
  bool get isPassword => password.length >= 8;
  bool get isUsername => username.length >= 3;
  bool get isFamily => family.length >= 3;

  SignUpState({
    required this.username,
    required this.family,
    required this.email,
    required this.password,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    required this.isInitial,
  });

  factory SignUpState.initial(){
    return SignUpState(
      username: '',
      family: '',
      email: '',
      password: '',
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isInitial: true,
    );
  }

   SignUpState loading(){
    return copyWith(
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
      isInitial: false,
    );
  }

  SignUpState success(){
    return copyWith(
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
      isInitial: false,
    );
  }

   SignUpState failure(){
    return copyWith(
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
      isInitial: false,
    );
  }

  bool get isUserName => username.isNotEmpty && username.length >= 3;

  SignUpState update({
    String? username,
    String? family,
    String? email,
    String? password,
  }){
    return copyWith(
      username: username,
      family: family,
      email: email,
      password: password,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      isInitial: false,
    );
  }

  SignUpState copyWith({
    String? username,
    String? family,
    String? email,
    String? password,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    bool? isInitial,
  }){
    return SignUpState(
      username: username ?? this.username,
      family: family ?? this.family,
      email: email ?? this.email,
      password: password ?? this.password,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      isInitial: isInitial ?? this.isInitial,
    );
  }

  Map<String,dynamic>  toUserMap({required String userId}){
    return UserModel(
      userId: userId,
      username: username,
      family: family,
      email: email,
    ).toMap();
  }
}
