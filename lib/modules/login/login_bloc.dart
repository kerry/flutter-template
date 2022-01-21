import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/navigation/app_state.dart';
import 'package:flutter_template/navigation/page_constants.dart';
import 'package:flutter_template/navigation/pages.dart';

abstract class LoginEvent {}

class LoginBloc extends Bloc<LoginEvent, bool> {
  LoginBloc(bool initialState, this.appState) : super(initialState);

  final AppState appState;

  @override
  Future<void> close() {
    // TODO: implement close
    print("disposing off login bloc");
    // _appChecksController.close();
    // _appVersionCheckController.close();
    // subscription?.cancel();
    return super.close();
  }

  void _initialize() {
    appState.currentAction =
        PageAction(state: PageState.replace, page: HomePageConfig);
  }

  void signInWithGoogle() => _initialize();
}
