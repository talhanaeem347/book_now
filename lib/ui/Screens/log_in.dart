

import 'package:book_now/app_constants/app_padding.dart';
import 'package:book_now/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:book_now/repositories/user_repository.dart';
import 'package:book_now/ui/widgets/log_in_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInScreen extends StatefulWidget {
  final UserRepository userRepository;

  const LogInScreen({super.key, required this.userRepository});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late LogInBloc _logInBloc;

  get userRepository => widget.userRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _logInBloc = LogInBloc(userRepository: userRepository);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider<LogInBloc>(
      create: (context) => _logInBloc,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: size.height,
            width: size.width,
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.normal),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/backgroundImage.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: AppPadding.extraLarge * 3,
                ),
                const Image(image: AssetImage("assets/logo.png")),
                const SizedBox(
                  height: AppPadding.extraLarge,
                ),
                LogInForm(
                  userRepository: userRepository,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
