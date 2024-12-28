import 'package:firebase_auth_app/components/bloc/auth_bloc.dart';
import 'package:firebase_auth_app/components/ui/login_page.dart';
import 'package:firebase_auth_app/components/ui/register_page.dart';
import 'package:firebase_auth_app/components/ui/success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Firebase Auth'),
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.isError != null && state.isError!) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Text(state.errorMessage ?? 'Произошла ошибка'),
                backgroundColor: Colors.red,
              ),
            );
            context.read<AuthBloc>().add(ResetErrorBoolEvent());
          }
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              switch (state.status) {
                case AuthStateStatus.loading:
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                case AuthStateStatus.success:
                  return SuccessPage(userCredential: state.userCredential);
                case AuthStateStatus.initial:
                  return LoginPage();
                case AuthStateStatus.register:
                  return RegisterPage();
              }
            },
          );
        },
      ),
    );
  }
}
