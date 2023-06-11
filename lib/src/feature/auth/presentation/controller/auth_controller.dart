import 'package:atas/src/feature/auth/auth.dart';
import 'package:flutter/material.dart';

// @RoutePage(name: 'login')
class AuthController extends StatelessWidget {
  static const name = 'auth';
  static const path = '/login';

  const AuthController({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginForm();
  }
}
