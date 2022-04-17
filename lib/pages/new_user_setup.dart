import 'package:flutter/material.dart';

class NewUserSetup extends StatelessWidget {
  const NewUserSetup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Container(
          child: const Center(
            child: Text('New user Page'),
          ),
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
