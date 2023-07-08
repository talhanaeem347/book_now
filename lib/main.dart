import 'package:book_now/app_constants/app_strings.dart';
import 'package:book_now/bloc/blocDelegate.dart';
import 'package:book_now/bloc/connectivity/connectivity_bloc.dart';
import 'package:book_now/ui/loading_screen.dart';
import 'package:book_now/utils/toses.dart';
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
  runApp(BlocProvider(
      create: (context) => ConnectivityBloc(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(title: 'Book Now'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ConnectivityBloc _connectivityBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _connectivityBloc = BlocProvider.of<ConnectivityBloc>(context);
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
            return const Scaffold(
              body: Center(
                child: Text('Connected'),
              ),
            );

          }
          showFailureTos(AppStrings.noInternet, context);
          return const LoadingScreen();

    });
  }
}
