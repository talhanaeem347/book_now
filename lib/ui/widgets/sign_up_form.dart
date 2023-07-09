import 'package:book_now/app_constants/app_colors.dart';
import 'package:book_now/app_constants/app_padding.dart';
import 'package:book_now/app_constants/app_strings.dart';
import 'package:book_now/bloc/authetication_bloc/authentication_bloc.dart';
import 'package:book_now/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:book_now/repositories/user_repository.dart';
import 'package:book_now/ui/custom/custom_text_field.dart';
import 'package:book_now/ui/custom/simple_button.dart';
import 'package:book_now/utils/toses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpForm extends StatefulWidget {
  final UserRepository userRepository;

  const SignUpForm({super.key, required this.userRepository});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  get userRepository => widget.userRepository;
  late SignUpBloc _signUpBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpBloc = SignUpBloc(userRepository: userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _signUpBloc,
      listener: (context, SignUpState state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
        if (state.isFailure) {
          showFailureTos(AppStrings.noInternet, context);
        }
        if (state.isSubmitting) {
          showInfoTos(AppStrings.loading, context);
        }
      },
      child: BlocBuilder(
        bloc: _signUpBloc,
        builder: (context, SignUpState state) {
          return Container(
            padding: const EdgeInsets.all(AppPadding.normal),
            decoration: BoxDecoration(
              color: AppColor.lightGrey.withOpacity(AppPadding.small * 0.1),
              borderRadius: BorderRadius.circular(AppPadding.normal),
            ),
            child: Column(
              children: [
                CustomTextField(
                  label: AppStrings.userName,
                  onChanged: (value) {
                    _signUpBloc.add(UsernameChanged(userName: value));
                  },
                  validator: (value) {
                    return !state.isUserName
                        ? AppStrings.invalidUserName
                        : null;
                  },
                ),
                const SizedBox(height: AppPadding.normal),
                CustomTextField(
                  label: AppStrings.family,
                  onChanged: (value) {
                    _signUpBloc.add(FamilyChanged(family: value));
                  },
                  validator: (value) {
                    return !state.isFamily ? AppStrings.invalidFamily : null;
                  },
                ),
                const SizedBox(height: AppPadding.normal),
                CustomTextField(
                  label: AppStrings.email,
                  onChanged: (value) {
                    _signUpBloc.add(SignUpEmailChanged(email: value));
                  },
                  validator: (value) {
                    return !state.isEmail ? AppStrings.invalidEmail : null;
                  },
                ),
                const SizedBox(height: AppPadding.normal),
                CustomTextField(
                  isPassword: true,
                  label: AppStrings.password,
                  onChanged: (value) {
                    _signUpBloc.add(SignUpPasswordChanged(password: value));
                  },
                  validator: (value) {
                    return !state.isUserName
                        ? AppStrings.invalidUserName
                        : null;
                  },
                ),
                const SizedBox(height: AppPadding.normal),
                SimpleButton(
                  label: AppStrings.register,
                  isEnable: state.isFormValid,
                  onPressed: () {
                    if (state.isFormValid) {
                      _signUpBloc.add(SignUpWithEmail());
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
