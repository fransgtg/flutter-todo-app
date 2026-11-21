import 'package:auth/screens/profile_screen.dart';
import 'package:auth/screens/sign_in_screen.dart';
import 'package:auth/services/auth/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:auth/screens/todo_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();

    return StreamBuilder<User?>(
        stream: auth.authStateChange,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Gagal memuat status login!"),
              ),
            );
          }

          if (snapshot.hasData) {
            return TodoScreen();
          }

          return SignInScreen();
        }
    );
  }
}