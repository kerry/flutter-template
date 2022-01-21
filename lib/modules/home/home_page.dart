import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_template/modules/home/home_bloc.dart';
import 'package:flutter_template/navigation/app_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    return BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(HomeState(tab: HomeTab.dashboard), appState),
        child: const HomeView());
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(builder: (context, __) {
      return Scaffold(
          body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("App Version Check Passed"),
              ElevatedButton(
                  onPressed: () => context.read<HomeBloc>().signOut(),
                  child: Text("Sign out"))
            ],
          ),
        ),
      ));
    });
  }
}
