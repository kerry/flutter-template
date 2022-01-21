import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/navigation/app_state.dart';
import 'package:flutter_template/navigation/page_constants.dart';
import 'package:flutter_template/navigation/pages.dart';

abstract class SplashEvent {}

class SplashBloc extends Bloc<SplashEvent, bool> {
  SplashBloc(bool initialState, this.appState) : super(initialState) {
    print("init bloc");
    _initialize();
    checkAppVersion();
  }

  final AppState appState;

  @override
  Future<void> close() {
    // TODO: implement close
    print("disposing off splash bloc");
    // _appChecksController.close();
    // _appVersionCheckController.close();
    // subscription?.cancel();
    return super.close();
  }

  void _initialize() {
    print("initialize");
  }

  Future<void> checkAppVersion() async {
    print("check app version");
    Future.delayed(
        const Duration(seconds: 2),
        () => this.appState.currentAction =
            PageAction(state: PageState.replace, page: LoginPageConfig));
  }
}
