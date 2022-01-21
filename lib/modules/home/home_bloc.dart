import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/navigation/app_state.dart';

abstract class HomeEvent {}

enum HomeTab { dashboard, accounts, transactions }

class HomeState {
  const HomeState({
    this.tab = HomeTab.dashboard,
  });

  final HomeTab tab;
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc(HomeState initialState, this.appState) : super(initialState);

  final AppState appState;

  void signOut() {}
}
