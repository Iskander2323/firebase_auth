import 'package:firebase_auth_app/components/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailTextController = TextEditingController();
    final TextEditingController _passwordTextController =
        TextEditingController();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return LayoutBuilder(
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
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email field cannot be empty';
                        }
                        final emailRegExp = RegExp(
                          r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                        );
                        if (!emailRegExp.hasMatch(value)) {
                          return 'Enter correct email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder()),
                    ),
                    TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'The field password cannot be empty';
                          }
                          return null;
                        },
                        controller: _passwordTextController,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder())),
                    GestureDetector(
                      onTap: () {
                        context.read<AuthBloc>().add(
                            SignUpWithEmailAndPasswordEvent(
                                email: _emailTextController.text,
                                password: _passwordTextController.text));
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: double.infinity,
                        height: constraints.maxHeight * 0.08,
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius:
                                BorderRadius.all(Radius.circular(15))),
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    )
                  ],
                ));
          },
        );
      },
    );
  }
}
