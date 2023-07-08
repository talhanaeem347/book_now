import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:book_now/utils/connectivity_utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  ConnectivityBloc() : super(ConnectivityInitial()) {
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  FutureOr<void> _onCheckConnectivity(CheckConnectivity event, Emitter<ConnectivityState> emit) async {
    emit(ConnectivityLoading());
    final bool isConnected  = await ConnectivityUtils.checkConnectivity();
    if (isConnected) {
      emit(Connected());
    } else {
      emit(DisConnected());
    }


  }

  FutureOr<void> _onConnectivityChanged(ConnectivityChanged event, Emitter<ConnectivityState> emit) {
    if (event.connectivityResult == ConnectivityResult.none) {
      emit(DisConnected());
    } else {
      emit(Connected());
    }
  }

}
