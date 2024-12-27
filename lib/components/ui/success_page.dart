import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_app/components/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key, UserCredential? userCredential})
      : _userCredential = userCredential;
  final UserCredential? _userCredential;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _userCredential != null
                  ? 'Welcome ${_userCredential.user!.email}!'
                  : 'Welcome user',
              style: TextStyle(fontSize: 20),
            ),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                context.read<AuthBloc>().add(LogOutEvent());
              },
            ),
          ],
        ),
      ),
    );
  }
}
