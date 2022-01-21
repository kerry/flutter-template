import 'package:flutter/material.dart';
import 'package:flutter_template/navigation/pages.dart';

class AppState extends ChangeNotifier {
  PageAction _currentAction = PageAction();
  PageAction get currentAction => _currentAction;
  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }

  static final AppState _instance = AppState._internal();

  AppState._internal() {}

  static AppState get instance {
    return _instance;
  }

  void resetCurrentAction() {
    _currentAction = PageAction();
  }
}
