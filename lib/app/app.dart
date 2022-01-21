import 'package:flutter/material.dart';
import 'package:flutter_template/navigation/app_state.dart';
import 'package:flutter_template/navigation/page_constants.dart';
import 'package:flutter_template/navigation/router/app_router_parser.dart';
import 'package:flutter_template/navigation/router/router_delegate.dart';
import 'package:provider/provider.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final appState = AppState.instance;
  late AppRouterDelegate delegate;
  final parser = AppRouterParser();

  _AppState() {
    delegate = AppRouterDelegate(appState);
    delegate.setNewRoutePath(SplashPageConfig);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: MaterialApp.router(
        title: "Flutter Template",
        debugShowCheckedModeBanner: true,
        theme: ThemeData(primarySwatch: Colors.teal),
        routerDelegate: delegate,
        routeInformationParser: parser,
      ),
    );
  }
}
