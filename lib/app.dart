import 'package:firebase_auth/components/bloc/auth_bloc.dart';
import 'package:firebase_auth/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth',
        routerConfig: routes,
      ),
    );
  }
}
