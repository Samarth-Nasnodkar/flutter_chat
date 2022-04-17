import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/pages/home_page.dart';
import 'package:flutter_chat/pages/login_page.dart';
import 'package:flutter_chat/utils/gauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

import '../pages/new_user_setup.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User?>();
    final guser = context.watch<GoogleSignInAccount?>();
    if (firebaseUser == null && guser == null) {
      return LoginPage();
    }
    if (GAuthService.acc == AccountInfo.newUser) {
      return const NewUserSetup();
    } else {
      return const HomePage();
    }
  }
}
