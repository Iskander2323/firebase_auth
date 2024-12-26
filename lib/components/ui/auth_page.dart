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
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
              height: constraints.maxHeight * 0.5,
              padding: EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Sign up',
                    style: TextStyle(fontSize: 30),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email', border: OutlineInputBorder()),
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder()))
                ],
              ));
        },
      ),
    );
  }
}
