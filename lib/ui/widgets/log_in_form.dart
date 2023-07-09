import 'package:book_now/app_constants/app_colors.dart';
import 'package:book_now/app_constants/app_padding.dart';
import 'package:book_now/app_constants/app_strings.dart';
import 'package:book_now/app_constants/app_text_style.dart';
import 'package:book_now/bloc/authetication_bloc/authentication_bloc.dart';
import 'package:book_now/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:book_now/repositories/user_repository.dart';
import 'package:book_now/ui/Screens/sign_up.dart';
import 'package:book_now/ui/custom/custom_text_field.dart';
import 'package:book_now/ui/custom/simple_button.dart';
import 'package:book_now/utils/toses.dart';
import 'package:book_now/utils/turn_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInForm extends StatefulWidget {
  final UserRepository userRepository;

  const LogInForm({super.key, required this.userRepository});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  get userRepository => widget.userRepository;
  late LogInBloc _logInBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _logInBloc = LogInBloc(userRepository: userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _logInBloc,
      listener: (context, LogInState state) {
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
        bloc: _logInBloc,
        builder: (context, LogInState state) {
          return Container(
            padding: const EdgeInsets.all(AppPadding.normal),
            decoration: BoxDecoration(
              color: AppColor.lightGrey.withOpacity(AppPadding.small * 0.1),
              borderRadius: BorderRadius.circular(AppPadding.normal),
            ),
            child: Column(
              children: [
                const SizedBox(height: AppPadding.normal),
                CustomTextField(
                  label: AppStrings.email,
                  onChanged: (value) {
                    _logInBloc.add(LogInEmailChanged(email: value));
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
                    _logInBloc.add(LogInPasswordChanged(password: value));
                  },
                  validator: (value) {
                    return !state.isPassword
                        ? AppStrings.invalidUserName
                        : null;
                  },
                ),
                const SizedBox(height: AppPadding.normal),
                SimpleButton(
                  label: AppStrings.login,
                  isEnable: state.isFormValid,
                  onPressed: () {
                    if (state.isFormValid) {
                      _logInBloc.add(LogInWithEmail());
                    }
                  },
                ),
                const SizedBox(height: AppPadding.normal),
                Text(
                  AppStrings.wantToRegister,
                  style: AppStyle.labelStyle,
                ),
                const SizedBox(height: AppPadding.normal),
                SimpleButton(
                  label: AppStrings.register,

                  onPressed: () {
                    TurnPage.pushScreen(context, SignUpScreen(userRepository: userRepository));

                  }



                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
