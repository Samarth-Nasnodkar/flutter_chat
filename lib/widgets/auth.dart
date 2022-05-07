import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/home_page.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/pages/signup_page.dart';
import 'package:flutter_chat/pages/welcome_page.dart';
import 'package:flutter_chat/utils/gauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../pages/new_user_setup.dart';

class AuthWrapper extends StatelessWidget {
  final int indx;
  static Map? userData;
  const AuthWrapper({Key? key, this.indx = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final guser = context.watch<GoogleSignInAccount?>();
    if (firebaseUser == null && guser == null) {
      userData = null;
      if (indx == 0) {
        return const WelcomePage();
      }
      if (indx == 1) {
        return LoginPage();
      }
      return SignUpPage();
    }
    if (userData != null) {
      return HomePage(userData: userData!);
    }
    final isNewUser = GAuthService.acc == AccountInfo.newUser;
    debugPrint("INU = $isNewUser");
    debugPrint("Acc status = " + isNewUser.toString());
    // return const HomePage();
    String e;
    if (firebaseUser != null) {
      e = firebaseUser.email!;
    } else {
      e = guser!.email;
    }
    if (isNewUser) {
      return NewUserSetup(email: e);
    } else {
      FirebaseStorage.instance.ref().child("users/$e").getData().then(
        (value) {
          final s = String.fromCharCodes(value!);
          final jsonData = jsonDecode(s);
          userData = jsonData;
          Navigator.push(context,
              MaterialPageRoute(builder: (ctx) => const AuthWrapper()));
        },
      );
      return const AlertDialog(
        content: CircularProgressIndicator.adaptive(
          backgroundColor: Colors.transparent,
        ),
      );
    }
  }
}
