import 'package:flutter/material.dart';

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
      backgroundColor: Colors.white,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      ),
    );
  }
}
