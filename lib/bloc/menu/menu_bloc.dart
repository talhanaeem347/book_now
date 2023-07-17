import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'menu_event.dart';
part 'menu_state.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  MenuBloc() : super(MenuInitial()) {
    on<MenuEvent>((event, emit) {
      if(event is OpenMenu){
        emit(MenuOpen());
      }else if(event is CloseMenu){
        emit(MenuClose());
      }
      // TODO: implement event handler
    });
  }
}
