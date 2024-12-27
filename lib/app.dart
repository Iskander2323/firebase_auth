import 'package:firebase_auth_app/components/repository/auth_repository.dart';
import 'package:firebase_auth_app/routes.dart';
import 'package:firebase_auth_app/components/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key, required this.authRepository});
  final AuthRepository authRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: authRepository),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Firebase Auth',
        routerConfig: routes,
      ),
    );
  }
}
