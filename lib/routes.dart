import 'package:firebase_auth/components/ui/auth_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter routes = GoRouter(
    initialLocation: '/auth',
    routes: [GoRoute(path: '/auth', builder: (context, state) => AuthPage())]);
