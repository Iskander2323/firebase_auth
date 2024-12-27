import 'package:firebase_auth_app/app.dart';
import 'package:firebase_auth_app/auth_repository.dart';
import 'package:firebase_auth_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthRepository authRepository = AuthRepository();

  runApp(App(authRepository: authRepository));
}
