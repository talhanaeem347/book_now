
import 'package:book_now/app_constants/app_padding.dart';
import 'package:book_now/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:book_now/repositories/user_repository.dart';
import 'package:book_now/ui/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatefulWidget {
  final UserRepository userRepository;

  const SignUpScreen({super.key, required this.userRepository});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late SignUpBloc _signUpBloc;

  get userRepository => widget.userRepository;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _signUpBloc = SignUpBloc(userRepository: userRepository);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return BlocProvider<SignUpBloc>(
      create: (context) => _signUpBloc,
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
                SignUpForm(
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
