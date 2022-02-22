import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat/utils/auth_service.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  child: TextButton(
                    onPressed: () {
                      context.read<AuthService>().signIn(
                          email: emailController.text,
                          password: passwordController.text);
                    },
                    child: const Text(
                      'Sign Up!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
