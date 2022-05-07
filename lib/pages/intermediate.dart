import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/new_user_setup.dart';

class IntermediatePage extends StatelessWidget {
  const IntermediatePage({Key? key}) : super(key: key);

  loadPage(BuildContext context) async {
    final userRef = FirebaseDatabase.instance.ref('users');
    userRef.get().then((value) {
      value.children.every((element) {
        final _d = element.value;
        if (_d is! Map) return false;

        return true;
      });
    });
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const NewUserSetup(
                email: "samarthnasnodkar@gmail.com",
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
