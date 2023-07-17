part of 'menu_bloc.dart';

abstract class MenuState extends Equatable {
  const MenuState();
}

class MenuInitial extends MenuState {
  @override
  List<Object> get props => [];
}

class MenuOpen extends MenuState {
  @override
  List<Object> get props => [];
}

class MenuClose extends MenuState {
  @override
  List<Object> get props => [];
}

