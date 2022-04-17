import 'package:flutter/material.dart';
import 'package:flutter_chat/utils/auth_service.dart';
import 'package:flutter_chat/utils/gauth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 11, 11),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                cursorColor: Colors.deepPurple,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                controller: passwordController,
                cursorColor: Colors.deepPurple,
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
                      context
                          .read<AuthService>()
                          .signIn(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((err) {
                        if (err != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.deepPurple,
                              content: Text(
                                err,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          );
                        }
                      });
                    },
                    child: const Text(
                      'Sign Up!',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: IconButton(
                      splashRadius: 0.5,
                      onPressed: () async {
                        final prov =
                            Provider.of<GAuthService>(context, listen: false);
                        await prov.googleLogIn();
                      },
                      icon: const FaIcon(FontAwesomeIcons.google),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  const SizedBox(
                    width: 40.0,
                  ),
                  Container(
                    child: IconButton(
                      splashRadius: 0.5,
                      onPressed: () {},
                      icon: const FaIcon(
                        FontAwesomeIcons.apple,
                        size: 30,
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
