import 'package:book_now/bloc/authetication_bloc/authentication_bloc.dart';
import 'package:book_now/bloc/blocDelegate.dart';
import 'package:book_now/bloc/connectivity_bloc/connectivity_bloc.dart';
import 'package:book_now/repositories/user_repository.dart';
import 'package:book_now/ui/Screens/loading_screen.dart';
import 'package:book_now/ui/Screens/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = SimpleBlocObserver();
  final userRepository = UserRepository();
  // runApp(BlocProvider(
  //     create: (context) => ConnectivityBloc(), child: const MyApp()));

  runApp(MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ConnectivityBloc()),
        BlocProvider(create: (context) => AuthenticationBloc(userRepository: userRepository )),
      ],
      child: MyApp(userRepository: userRepository)));
}

class MyApp extends StatelessWidget {
  final UserRepository _userRepository;
   const MyApp({super.key, required UserRepository userRepository}) : _userRepository = userRepository;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(userRepository: _userRepository),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final UserRepository _userRepository;

  const MyHomePage({super.key, required UserRepository userRepository})
      : _userRepository = userRepository;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConnectivityBloc _connectivityBloc;
  late AuthenticationBloc _authenticationBloc;
  get _userRepository => widget._userRepository;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivityBloc = BlocProvider.of<ConnectivityBloc>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _connectivityBloc,
        builder: (context, connectionState){
          if(connectionState is ConnectivityInitial){
            _connectivityBloc.add(CheckConnectivity());
            return const LoadingScreen();
          }
          if(connectionState is Connected){
            return BlocBuilder(
              bloc: _authenticationBloc,
                builder: (context, authState) {
                if(authState is AuthenticationInitial){
                  _authenticationBloc.add(AppStarted());
                  return const LoadingScreen();
                }
              if (authState is Uninitialized) {
                return const LoadingScreen();
              }
              if (authState is Authenticated) {
                return const Scaffold(
                  body: Center(
                    child: Text('Connected'),
                  ),
                );
              }
              if (authState is Unauthenticated) {
                return SignUpScreen(userRepository:_userRepository,);
              }
              return const LoadingScreen();
            });
          }
          // showFailureTos(AppStrings.noInternet, context);
          return const LoadingScreen();

    });
  }

}
