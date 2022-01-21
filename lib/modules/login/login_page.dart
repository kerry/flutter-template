import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/navigation/app_state.dart';
import 'package:provider/provider.dart';

import 'login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppState appState = Provider.of<AppState>(context, listen: false);
    return BlocProvider<LoginBloc>(
        create: (_) => LoginBloc(false, appState),
        lazy: false,
        child: const LoginView());
  }
}

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  void _signInWithGoogle(BuildContext context, LoginBloc bloc) {
    bloc.signInWithGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, bool>(builder: (context, state) {
      return Scaffold(
        body: Container(
            child: Center(
          child: ElevatedButton(
            onPressed: () =>
                _signInWithGoogle(context, context.read<LoginBloc>()),
            child: Text("Google Sign in"),
          ),
        )),
      );
    });
  }
}
