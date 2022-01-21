import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/modules/splash/splash_bloc.dart';
import 'package:flutter_template/navigation/app_state.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return BlocProvider<SplashBloc>(
        create: (_) {
          return SplashBloc(false, appState);
        },
        lazy: false,
        child: SplashView());
  }
}

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
            child: Text(
          "Flutter Template",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.teal, fontSize: 24.0),
        )),
      ),
    );
  }
}
