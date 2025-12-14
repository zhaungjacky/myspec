import 'package:certispec/pages/auth/bloc/auth_bloc.dart';
import 'package:certispec/pages/auth/login_form.dart';
import 'package:certispec/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatelessWidget {
  static String routhPath() => "/";
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        switch (state) {
          case AuthInitial():
            return const Center(child: CircularProgressIndicator());
          case AuthFailureState():
            return const LoginScreen();
          case AuthSuccessState():
            return const HomePage();
        }
      },
    );
  }
}
